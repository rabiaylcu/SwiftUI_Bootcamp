//
//  FilmlerAppApp.swift
//  FilmlerApp
//
//  Created by Rabia Yolcu on 25.09.2025.
//

import SwiftUI

@main
struct FilmlerAppApp: App {
    
    init() {
        NavigationBarStyle.setupNavigationBar()
    }
    
    var body: some Scene {
        WindowGroup {
            Anasayfa()
                .environment(\.font, .custom("oswald", size: 18))
        }
    }
}
