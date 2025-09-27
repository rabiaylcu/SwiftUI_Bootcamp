//
//  CustomTextfieldStyle.swift
//  ToDosApp
//
//  Created by Rabia Yolcu on 11.09.2025.
//

import Foundation
import SwiftUI

struct CustomTextfieldStyle : TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(8)
            .overlay(RoundedRectangle(cornerRadius: 4).stroke(AppColors.mainColor, lineWidth: 1))

    }
}
