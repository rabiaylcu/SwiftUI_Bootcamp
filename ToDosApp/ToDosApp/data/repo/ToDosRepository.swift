//
//  ToDosRepository.swift
//  ToDosApp
//
//  Created by Rabia Yolcu on 11.09.2025.
//

import Foundation

class ToDosRepository {
    let db:FMDatabase?
    
    init(){
        let veritabaniYolu = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let hedefYol = URL(fileURLWithPath: veritabaniYolu).appendingPathComponent("todos_app.sqlite")
        db = FMDatabase(path: hedefYol.path)
    }
    
    func save(name:String, image:String) async throws {
        db?.open()
        
        do{
            try db!.executeUpdate("INSERT INTO toDos (name, image) VALUES (?, ?)", values: [name, image])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func update(id: Int, name:String) async throws {
        db?.open()
        
        do{
            try db!.executeUpdate("UPDATE toDos SET name = ? WHERE id = ?", values: [name, id])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func delete(id: Int) async throws {
        db?.open()
        
        do{
            try db!.executeUpdate("DELETE FROM toDos WHERE id = ?", values: [id])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func loadToDos() async throws -> [ToDos] {
        var list = [ToDos]()
        
        db?.open()
        
        do{
            let result = try db!.executeQuery("SELECT * FROM toDos", values: nil)
            
            while result.next() {
                let id = Int(result.string(forColumn: "id"))!
                let name = result.string(forColumn: "name")!
                let image = result.string(forColumn: "image")!
                
                let toDo = ToDos(id: id, name: name, image: image)
                list.append(toDo)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return list
    }
    
    func search(searchText: String) async throws -> [ToDos] {
        //        let allToDos = try await loadToDos()
        //
        //        if searchText.isEmpty {
        //            return allToDos
        //        }
        //
        //        //bitirme projesinde kullanabilirsin
        //        return allToDos.filter { $0.name!.lowercased().contains(searchText.lowercased()) }
        //    }
        
        var list = [ToDos]()
        
        db?.open()
        
        do{
            let result = try db!.executeQuery("SELECT * FROM toDos WHERE name LIKE '%\(searchText)%'", values: nil)
            
            while result.next() {
                let id = Int(result.string(forColumn: "id"))!
                let name = result.string(forColumn: "name")!
                let image = result.string(forColumn: "image")!
                
                let toDo = ToDos(id: id, name: name, image: image)
                list.append(toDo)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return list
        
        
    }
}
