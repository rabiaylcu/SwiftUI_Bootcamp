//
//  SaveViewModel.swift
//  TaskFlow
//
//  Created by Rabia Yolcu on 25.09.2025.
//

import Foundation

@MainActor
class SaveViewModel {
    private let repository = TasksRepository()
    
    func save(name: String) async {
        do {
            try await repository.save(name: name)
        } catch {
            
        }
    }
}
