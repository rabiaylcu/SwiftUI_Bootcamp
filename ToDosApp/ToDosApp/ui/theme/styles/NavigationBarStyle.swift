//
//  NavigationBarStyle.swift
//  ToDosApp
//
//  Created by Rabia Yolcu on 11.09.2025.
//

import Foundation
import SwiftUI

struct NavigationBarStyle {
    static func setupNAvigationBar(){
        let appearence = UINavigationBarAppearance()
        appearence.backgroundColor = UIColor(AppColors.mainColor)
        appearence.titleTextAttributes = [.foregroundColor: UIColor(AppColors.white), .font: UIFont(name: "oswald", size: 22)!]
        appearence.largeTitleTextAttributes = [.foregroundColor: UIColor(AppColors.white), .font: UIFont(name: "oswald", size: 32)!]
        
        UINavigationBar.appearance().standardAppearance = appearence
        UINavigationBar.appearance().compactAppearance = appearence
        UINavigationBar.appearance().scrollEdgeAppearance = appearence
    }
}
