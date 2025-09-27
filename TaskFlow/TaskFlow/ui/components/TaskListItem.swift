//
//  TaskListItem.swift
//  TaskFlow
//
//  Created by Rabia Yolcu on 25.09.2025.
//

import Foundation
import SwiftUI

struct TaskListItem: View {
    var task = Tasks()
    
    var body: some View {
        HStack {
            Text(task.name!)
                .padding(8)
        }
    }
}
