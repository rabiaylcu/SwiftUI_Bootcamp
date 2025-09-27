//
//  SaveViewModel.swift
//  ToDosApp
//
//  Created by Rabia Yolcu on 11.09.2025.
//

import Foundation

@MainActor // = DispatchQueue(UIKit) async iş yapıyorsanız yani aynı anda birden fazla iş yapılıyorsa verimli çalışması için kullanıyoruz
class SaveViewModel {
    private let repository = ToDosRepository()
    
    func save(name:String, image:String) async {
        do{
            try await repository.save(name: name, image: image) //async old için try await
        }catch{
            //Hata olursa burda kodlama yap.
        }
    }
    
}
