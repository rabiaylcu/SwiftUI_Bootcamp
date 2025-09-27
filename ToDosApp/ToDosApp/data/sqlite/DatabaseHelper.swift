//
//  DatabaseHelper.swift
//  ToDosApp
//
//  Created by Rabia Yolcu on 13.09.2025.
//

import Foundation

class DatabaseHelper {
    static func copyDatabase() {
        let bundle = Bundle.main.path(forResource: "todos_app", ofType: ".sqlite")
                
        let veritabaniYolu = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
                
        let hedefYol = URL(fileURLWithPath: veritabaniYolu).appendingPathComponent("todos_app.sqlite")
                
        let fm = FileManager.default
                
        if fm.fileExists(atPath: hedefYol.path) {
                    print("Veritabanı daha önce kopyalanmış.")
        }else{
            do{
                try fm.copyItem(atPath: bundle!, toPath: hedefYol.path)
            }catch{
                print(error.localizedDescription)
            }
        }

    }
}
