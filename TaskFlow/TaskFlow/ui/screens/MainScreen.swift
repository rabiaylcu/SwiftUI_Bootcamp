//
//  MainScreen.swift
//  TaskFlow
//
//  Created by Rabia Yolcu on 25.09.2025.
//

import SwiftUI

struct MainScreen: View {
    
    init() {
        DatabaseHelper.copyDatabase()
    }
    
    @State private var searchText = ""
    @ObservedObject var viewModel = MainViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.tasksList.isEmpty {
                    Text("Henüz görev yok!")
                } else {
                    List {
                        ForEach(viewModel.tasksList) { task in
                            NavigationLink(destination: UpdateScreen(task: task)) {
                                TaskListItem(task: task)
                            }
                        }
                        .onDelete(perform: delete)
                    }
                }
            }
            .navigationTitle("Task Flow")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SaveScreen()) {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear {
                Task {
                    await viewModel.loadTasks()
                }
            }
        }
        .searchable(text: $searchText, prompt: "Görev ara...")
        .onChange(of: searchText) { _, result in
            Task {
                await viewModel.search(searchText: result)
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        let task = viewModel.tasksList[offsets.first!]
        Task {
            await viewModel.delete(id: task.id!)
        }
    }
}
