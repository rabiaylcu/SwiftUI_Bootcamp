//
//  UpdateScreen.swift
//  ToDosApp
//
//  Created by Rabia Yolcu on 6.09.2025.
//

import SwiftUI

struct UpdateScreen: View {
    @Environment(\.dismiss) private var dismiss
    var toDo = ToDos()
    @State private var nameController = ""
    @State private var showError = false
    var viewModel = UpdateViewModel()
    
    var body: some View {
        VStack(spacing: 32) {
            Image(toDo.image ?? "agac")
            
            TextField("Name", text: $nameController).textFieldStyle(CustomTextfieldStyle())
            
            if showError {
                Text("Name can not be empty !").foregroundStyle(AppColors.red)
            }
            
            Button{
                if nameController.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{ //beyaz boşlukları kaldırdık boş mu dolu mu kontrol ettik
                    showError = true
                }else{
                    showError = false
                    if let id = toDo.id {
                        Task {
                            await viewModel.update(id: id, name: nameController)
                        }
                    }
                    dismiss()
                }
                
            }label: {
                Text("Update")
                    .frame(maxWidth: .infinity)
            }.buttonStyle(CustomButtonStyle())
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
        .navigationTitle("Update Screen")
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
            }
            .onAppear {
                if let name = toDo.name {
                    nameController = name
                }
            }
    }
}

#Preview {
    UpdateScreen()
}
