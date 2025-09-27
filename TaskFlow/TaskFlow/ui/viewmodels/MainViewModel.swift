//
//  MainViewModel.swift
//  TaskFlow
//
//  Created by Rabia Yolcu on 25.09.2025.
//

import Foundation

class MainViewModel: ObservableObject {
    private let repository = TasksRepository()
    @Published var tasksList = [Tasks]()
    
    func loadTasks() async {
        do {
            tasksList = try await repository.loadTasks()
        } catch {
            tasksList = [Tasks]()
        }
    }
    
    func search(searchText: String) async {
        do {
            tasksList = try await repository.search(searchText: searchText)
        } catch {
            tasksList = [Tasks]()
        }
    }
    
    func delete(id: Int) async {
        do {
            try await repository.delete(id: id)
            await loadTasks()
        } catch {
            
        }
    }
}
