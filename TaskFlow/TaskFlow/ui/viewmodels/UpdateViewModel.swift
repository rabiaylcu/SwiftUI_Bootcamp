//
//  UpdateViewModel.swift
//  TaskFlow
//
//  Created by Rabia Yolcu on 25.09.2025.
//

import Foundation

@MainActor
class UpdateViewModel {
    private let repository = TasksRepository()
    
    func update(id: Int, name: String) async {
        do {
            try await repository.update(id: id, name: name)
        } catch {
            
        }
    }
}
