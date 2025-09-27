//
//  SaveScreen.swift
//  TaskFlow
//
//  Created by Rabia Yolcu on 25.09.2025.
//

import SwiftUI

struct SaveScreen: View {
    @Environment(\.dismiss) private var dismiss
    @State private var nameController = ""
    @State private var showError = false
    var viewModel = SaveViewModel()
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("Görev adı", text: $nameController)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if showError {
                Text("Görev adı boş olamaz!")
                    .foregroundStyle(.red)
            }
            
            Button {
                if nameController.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    showError = true
                } else {
                    showError = false
                    Task {
                        await viewModel.save(name: nameController)
                    }
                    dismiss()
                }
            } label: {
                Text("Kaydet")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            
                Spacer()    
            
        }
        .padding()
        .navigationTitle("Görev Ekle")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "arrow.backward")
                        Text("Geri")
                    }
                }
            }
        }
    }
}
