//
//  ToDos.swift
//  ToDosApp
//
//  Created by Rabia Yolcu on 6.09.2025.
//

import Foundation

class ToDos : Identifiable {
    var id:Int?
    var name:String?
    var image:String?
    
    init(){
        
    }
    
    init(id: Int, name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
    }
    
}
