//
//  SepetSayfaViewModel.swift
//  FilmlerApp
//
//  Created by Rabia Yolcu on 25.09.2025.
//

import SwiftUI
import Foundation

@MainActor
class SepetSayfaViewModel: ObservableObject {
    private let repository = FilmlerRepository.shared
    @Published var sepetFilmlerListesi = [SepetFilmler]()
    
    func sepetFilmleriYukle() async {
        do {
            sepetFilmlerListesi = try await repository.getMovieCart()
        } catch {
            sepetFilmlerListesi = []
        }
    }

    func removeLocally(cartIds: [Int]) {
        sepetFilmlerListesi.removeAll { item in
            guard let id = item.cartId else { return false }
            return cartIds.contains(id)
        }
    }

    func filmSilWithoutReload(cartId: Int) async {
        do {
            try await repository.deleteMovie(cartId: cartId)
        } catch {
            print("Film silinirken hata: \(error)")
        }
    }
    
    func filmSil(cartId: Int) async {
        do {
            try await repository.deleteMovie(cartId: cartId)
            await sepetFilmleriYukle()
        } catch {
            print("Film silinirken hata: \(error)")
        }
    }
    
    func miktarArtir(cartId: Int) async {
        guard let index = sepetFilmlerListesi.firstIndex(where: { $0.cartId == cartId }) else { return }

        let oldAmount = sepetFilmlerListesi[index].orderAmount ?? 0
        let film = sepetFilmlerListesi[index]

        withAnimation(.easeInOut) {
            sepetFilmlerListesi[index].orderAmount = oldAmount + 1
        }

        do {
            try await repository.deleteMovie(cartId: cartId)
            try await repository.insertMovie(
                name: film.name ?? "",
                image: film.image ?? "",
                price: film.price ?? 0,
                category: film.category ?? "",
                rating: film.rating ?? 0.0,
                year: film.year ?? 0,
                director: film.director ?? "",
                description: film.description ?? "",
                orderAmount: oldAmount + 1
            )
            await sepetFilmleriYukle()
        } catch {
            print("Miktar artırılırken hata: \(error)")
        }
    }
    
    func miktarAzalt(cartId: Int) async {
        guard let index = sepetFilmlerListesi.firstIndex(where: { $0.cartId == cartId }) else { return }
        let film = sepetFilmlerListesi[index]
        let current = film.orderAmount ?? 0
        guard current > 0 else { return }

        if current > 1 {
            withAnimation(.easeInOut) {
                sepetFilmlerListesi[index].orderAmount = current - 1
            }

            do {
                try await repository.deleteMovie(cartId: cartId)
                try await repository.insertMovie(
                    name: film.name ?? "",
                    image: film.image ?? "",
                    price: film.price ?? 0,
                    category: film.category ?? "",
                    rating: film.rating ?? 0.0,
                    year: film.year ?? 0,
                    director: film.director ?? "",
                    description: film.description ?? "",
                    orderAmount: current - 1
                )
                await sepetFilmleriYukle()
            } catch {
                print("Miktar azaltılırken hata: \(error)")
            }
        } else {
            _ = withAnimation(.easeInOut) {
                sepetFilmlerListesi.remove(at: index)
            }

            do {
                try await repository.deleteMovie(cartId: cartId)
                await sepetFilmleriYukle()
            } catch {
                print("Satır silinirken hata: \(error)")
            }
        }
    }
}
