//
//  MainViewModel.swift
//  ToDosApp
//
//  Created by Rabia Yolcu on 11.09.2025.
//

import Foundation

class MainViewModel : ObservableObject /*veri gönderiyor sayfaya demek*/ {
    private let repository = ToDosRepository()
    @Published var toDosList = [ToDos]() //published demek: veri okumak (veri değişti arayüzde bunu göster biz bunu gözlemleyeceğiz)
    
    func loadToDos() async {
        do{
            toDosList = try await repository.loadToDos()
        }catch{
            toDosList = [ToDos]()
        }
    }
    
    func search(searchText: String) async {
        do{
            toDosList = try await repository.search(searchText: searchText)
        }catch{
            toDosList = [ToDos]()
        }
    }
    
    func delete(id: Int) async {
        do{
            try await repository.delete(id: id)
            await loadToDos()
        }catch{
            
        }
    }
    
}
