//
//  NavigationBarStyle.swift
//  FilmlerApp
//
//  Created by Rabia Yolcu on 25.09.2025.
//

import Foundation
import SwiftUI

struct NavigationBarStyle {
    static func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(AppColors.mainColor)
        appearance.titleTextAttributes = [.foregroundColor: UIColor(AppColors.white), .font: UIFont(name: "oswald", size: 28) ?? UIFont.systemFont(ofSize: 28)]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(AppColors.white), .font: UIFont(name: "oswald", size: 28) ?? UIFont.systemFont(ofSize: 28)]
        
        // Navigation bar height ayarı
        appearance.titlePositionAdjustment = UIOffset(horizontal: -150, vertical: 5)
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
//        let searchFieldAppearance = UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
//        searchFieldAppearance.textColor = .white
//        searchFieldAppearance.attributedPlaceholder = NSAttributedString(
//            string: "Film Ara",
//            attributes: [.foregroundColor: UIColor.white]
//        )
        
    }
}
