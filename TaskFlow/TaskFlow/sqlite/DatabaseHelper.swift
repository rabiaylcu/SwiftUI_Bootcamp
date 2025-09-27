//
//  DatabaseHelper.swift
//  TaskFlow
//
//  Created by Rabia Yolcu on 25.09.2025.
//

import Foundation

class DatabaseHelper {
    static func copyDatabase() {
        guard let bundlePath = Bundle.main.path(forResource: "task_flow", ofType: "sqlite") else {
            print("Bundle içinde veritabanı bulunamadı.")
            return
        }
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let destinationURL = URL(fileURLWithPath: documentsPath).appendingPathComponent("task_flow.sqlite")
        
        let fm = FileManager.default
        
        if fm.fileExists(atPath: destinationURL.path) {
            print("Veritabanı daha önce kopyalanmış.")
        } else {
            do {
                try fm.copyItem(atPath: bundlePath, toPath: destinationURL.path)
                print("Veritabanı kopyalandı: \(destinationURL.path)")
            } catch {
                print("Kopyalama hatası: \(error.localizedDescription)")
            }
        }
    }
    
    static func getDatabasePath() -> String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return URL(fileURLWithPath: documentsPath).appendingPathComponent("task_flow.sqlite").path
    }
}


