//
//  ToDoListItem.swift
//  ToDosApp
//
//  Created by Rabia Yolcu on 9.09.2025.
//

import Foundation
import SwiftUI

struct ToDoListItem : View {
    var toDo = ToDos()
    
    var body: some View {
        HStack {
            Image(toDo.image!)
            Text(toDo.name!).foregroundStyle(AppColors.textColor)
        }.padding(8)
    }
}
