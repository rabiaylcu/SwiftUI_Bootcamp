//
//  CustomTextfieldStyle.swift
//  FilmlerApp
//
//  Created by Rabia Yolcu on 25.09.2025.
//

import Foundation
import SwiftUI

struct CustomTextfieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(8)
            .overlay(RoundedRectangle(cornerRadius: 4).stroke(AppColors.mainColor, lineWidth: 1))
    }
}
