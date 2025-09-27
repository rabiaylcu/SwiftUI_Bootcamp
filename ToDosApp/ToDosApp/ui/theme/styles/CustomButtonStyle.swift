//
//  CustomButtonStyle.swift
//  ToDosApp
//
//  Created by Rabia Yolcu on 11.09.2025.
//

import Foundation
import SwiftUI

// protocol = interface
struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(8)
            .background(AppColors.mainColor)
            .foregroundStyle(AppColors.white)
            .cornerRadius(8)
    }
}
