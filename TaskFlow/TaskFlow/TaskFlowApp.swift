//
//  TaskFlowApp.swift
//  TaskFlow
//
//  Created by Rabia Yolcu on 25.09.2025.
//

import SwiftUI

@main
struct TaskFlowApp: App {
    init() {
        DatabaseHelper.copyDatabase()
    }

    var body: some Scene {
        WindowGroup {
            MainScreen()
        }
    }
}


