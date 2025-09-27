//
//  Tasks.swift
//  TaskFlow
//
//  Created by Rabia Yolcu on 25.09.2025.
//

import Foundation

class Tasks: Identifiable {
    var id: Int?
    var name: String?
    
    init() {
        
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
