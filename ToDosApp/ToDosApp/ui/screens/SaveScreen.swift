//
//  SaveScreen.swift
//  ToDosApp
//
//  Created by Rabia Yolcu on 6.09.2025.
//

import SwiftUI

struct SaveScreen: View {
    @Environment(\.dismiss) private var dismiss
    @State private var randomImage = ""
    @State private var nameController = ""
    @State private var showError = false
    var viewModel = SaveViewModel()
    
    var body: some View {
        VStack(spacing: 32) {
            Image(randomImage)
            
            TextField("Name", text: $nameController).textFieldStyle(CustomTextfieldStyle())
            
            if showError {
                Text("Name can not be empty !").foregroundStyle(AppColors.red)
            }
            
            Button{
                if nameController.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{ //beyaz boşlukları kaldırdık boş mu dolu mu kontrol ettik
                    showError = true
                }else{
                    showError = false
                    Task { //asyc çalışmanın burada bitirilmesi gerekiyor tekrar tekrar çalışmaması için task kullanmalıyız
                        await viewModel.save(name: nameController, image: randomImage)
                    }
                    dismiss()
                }
                
            }label: {
                Text("Save")
                    .frame(maxWidth: .infinity)
                    
            }.buttonStyle(CustomButtonStyle())
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding()
        .navigationTitle("Save Screen")
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Button{
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "arrow.backward").foregroundColor(AppColors.white)
                            Text("ToDos").foregroundColor(AppColors.white)
                        }
                    }
                }
            }.onAppear(){
                let images = ["agac", "araba", "cicek", "damla", "gezegen", "gunes", "roket", "semsiye", "yildiz"]
                randomImage = images.randomElement() ?? "agac"
            }
    }
}

#Preview {
    SaveScreen()
}
