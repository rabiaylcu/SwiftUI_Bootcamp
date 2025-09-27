//
//  UpdateScreen.swift
//  TaskFlow
//
//  Created by Rabia Yolcu on 25.09.2025.
//

import SwiftUI

struct UpdateScreen: View {
    @Environment(\.dismiss) private var dismiss
    var task = Tasks()
    @State private var nameController = ""
    @State private var showError = false
    var viewModel = UpdateViewModel()
    
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
                    if let id = task.id {
                        Task {
                            await viewModel.update(id: id, name: nameController)
                        }
                    }
                    dismiss()
                }
            } label: {
                Text("Güncelle")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Görevi Güncelle")
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
        .onAppear {
            if let name = task.name {
                nameController = name
            }
        }
    }
}
