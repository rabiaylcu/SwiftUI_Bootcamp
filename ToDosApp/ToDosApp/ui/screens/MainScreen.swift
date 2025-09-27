//
//  ContentView.swift
//  ToDosApp
//
//  Created by Rabia Yolcu on 4.09.2025.
//

import SwiftUI

//left - start - leading
//right - end - trailing
//maxWidth: .infinity, maxHeight: .infinity -> match parent - match constraint (bulunduğu alan kadar yayıl)

struct MainScreen: View {
    
    init(){
        NavigationBarStyle.setupNAvigationBar()
        DatabaseHelper.copyDatabase()
    }
    
    //@State private var sayfaGecisKontrol = false
    @State private var searchText = ""
    @ObservedObject var viewModel = MainViewModel()
    
    var body: some View {
        NavigationStack {
            
            Group {
                if viewModel.toDosList.isEmpty {
                    Text("No ToDos Yet !").foregroundStyle(AppColors.textColor)
                }else{
                    List {
                        
                        ForEach(viewModel.toDosList){ toDo in
                            NavigationLink(destination: UpdateScreen(toDo: toDo)){
                                ToDoListItem(toDo: toDo)
                            }
                        }.onDelete(perform: delete) //delete fonksiyonuna gönderiyor aşağıda
                        
                        //Button("Modal Geçiş"){
                        //Present Modal
                        //sayfaGecisKontrol = true
                        //}
                        
                    }
                    //.sheet(isPresented: $sayfaGecisKontrol){
                    //SaveScreen()
                    //}
                    
                }
            }
            .navigationTitle("ToDos")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink(destination: SaveScreen()){
                        Image(systemName: "plus").foregroundColor(AppColors.white)
                    }
                }
            }
            .onAppear(){
                //print("On Appear metodu çalıştı")
                //Sayfa her göründüğünde çalışır.
                //Bu sayfaya gelindiğinde çalışır.
                
                Task {
                    await viewModel.loadToDos()
                }
                
            }
            
            //.onDisappear(){
            //print("On Disappear metodu çalıştı")
            //Sayfa her görünmez olduğunda çalışır.
            //}
        }
        .tint(AppColors.white)
        .searchable(text: $searchText, prompt: "Search")
        .onChange(of: searchText){ _,result in
            Task{
                await viewModel.search(searchText: result)
            }
        }
        
    }
    
    func delete (at offsets: IndexSet){
        let toDo = viewModel.toDosList[offsets.first!]
        Task {
            await viewModel.delete(id: toDo.id!)
        }
    }
}

#Preview {
    MainScreen()
}


/*VStack(alignment: .trailing, spacing: 32){
    Rectangle().fill(.red).frame(width: 100, height: 100).padding()
    Rectangle().fill(.green).frame(width: 75, height: 75).padding(8)
    Spacer().frame(width: 50, height: 50)
    Rectangle().fill(.blue).frame(width: 50, height: 50).padding(.top, 30)
    Rectangle().fill(.yellow).frame(width: 50, height: 50).padding(.horizontal, 8)
    Rectangle().fill(.orange).frame(width: 50, height: 50).padding([.leading, .top], 10)
    Rectangle().fill(.black).frame(maxHeight: .infinity)
}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
*/
