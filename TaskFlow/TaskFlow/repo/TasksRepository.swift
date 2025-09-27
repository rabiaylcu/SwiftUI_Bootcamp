//
//  TasksRepository.swift
//  TaskFlow
//
//  Created by Rabia Yolcu on 25.09.2025.
//

import Foundation
import FMDB

class TasksRepository {
    let db: FMDatabase?
    
    init() {
        let path = DatabaseHelper.getDatabasePath()
        print("DB Path (TasksRepository): \(path)")
        db = FMDatabase(path: path)
    }
    
    func save(name: String) async throws {
        db?.open()
        
        do {
            try db!.executeUpdate("INSERT INTO tasks (name) VALUES (?)", values: [name])
        } catch {
            print("Save error: \(error.localizedDescription)")
        }
        
        db?.close()
    }
    
    func update(id: Int, name: String) async throws {
        db?.open()
        
        do {
            try db!.executeUpdate("UPDATE tasks SET name = ? WHERE id = ?", values: [name, id])
        } catch {
            print("Update error: \(error.localizedDescription)")
        }
        
        db?.close()
    }
    
    func delete(id: Int) async throws {
        db?.open()
        
        do {
            try db!.executeUpdate("DELETE FROM tasks WHERE id = ?", values: [id])
        } catch {
            print("Delete error: \(error.localizedDescription)")
        }
        
        db?.close()
    }
    
    func loadTasks() async throws -> [Tasks] {
        var list = [Tasks]()
        
        db?.open()
        
        do {
            let result = try db!.executeQuery("SELECT * FROM tasks", values: nil)
            
            while result.next() {
                let id = Int(result.int(forColumn: "id"))
                let name = result.string(forColumn: "name") ?? ""
                
                let task = Tasks(id: id, name: name)
                list.append(task)
            }
        } catch {
            print("Load error: \(error.localizedDescription)")
        }
        
        db?.close()
        
        return list
    }
    
    func search(searchText: String) async throws -> [Tasks] {
        var list = [Tasks]()
        
        db?.open()
        
        do {
            let result = try db!.executeQuery("SELECT * FROM tasks WHERE name LIKE ?", values: ["%\(searchText)%"])
            
            while result.next() {
                let id = Int(result.int(forColumn: "id"))
                let name = result.string(forColumn: "name") ?? ""
                
                let task = Tasks(id: id, name: name)
                list.append(task)
            }
        } catch {
            print("Search error: \(error.localizedDescription)")
        }
        
        db?.close()
        
        return list
    }
}
