//
//  AnasayfaViewModel.swift
//  FilmlerApp
//
//  Created by Rabia Yolcu on 25.09.2025.
//

import Foundation

@MainActor
class AnasayfaViewModel: ObservableObject {
    private let repository = FilmlerRepository.shared
    @Published var filmlerListesi = [Filmler]()
    @Published var sepetItemSayisi = 0
    
    func filmleriYukle() async {
        print("ViewModel: Filmler yükleniyor...")
        do {
            filmlerListesi = try await repository.getAllMovies()
            print("ViewModel: \(filmlerListesi.count) film yüklendi")
            await sepetSayisiniGuncelle()
        } catch {
            print("ViewModel hatası: \(error)")
            filmlerListesi = []
        }
    }
    
    func filmAra(searchText: String) async {
        do {
            filmlerListesi = try await repository.searchMovies(searchText: searchText)
        } catch {
            filmlerListesi = []
        }
    }
    
    func filmSepeteEkle(film: Filmler) async {
        do {
           try await repository.insertMovie(
               name: film.name ?? "",
               image: film.image ?? "",
               price: film.price ?? 0,
               category: film.category ?? "",
               rating: film.rating ?? 0.0,
               year: film.year ?? 0,
               director: film.director ?? "",
               description: film.description ?? "",
               orderAmount: 1
           )
        } catch {
            print("Sepete ekleme hatası: \(error)")
        }
    }
    
    func sepetSayisiniGuncelle() async {
        do {
            let sepetFilmleri = try await repository.getMovieCart()
            sepetItemSayisi = sepetFilmleri.reduce(0) { $0 + $1.orderAmount! }
        } catch {
            sepetItemSayisi = 0
        }
    }
}
