//
//  DetaySayfaViewModel.swift
//  FilmlerApp
//
//  Created by Rabia Yolcu on 25.09.2025.
//

import Foundation

@MainActor
final class DetaySayfaViewModel: ObservableObject {
    @Published var film: Filmler?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let repository = FilmlerRepository.shared

    func loadFilm(passed: Filmler?) async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        guard let passed = passed else {
            self.film = nil
            self.errorMessage = "Film bilgisi bulunamadı."
            return
        }

        if hasMinimumForCart(passed) {
            self.film = passed
            return
        }

        do {
            let all = try await repository.getAllMovies()
            if let id = passed.id,
               let match = all.first(where: { $0.id == id }) {
                self.film = match
                return
            }
            if let name = passed.name,
               let match = all.first(where: { $0.name == name }) {
                self.film = match
                return
            }
            self.film = passed
        } catch {
            self.film = passed
            self.errorMessage = "Film bilgisi alınamadı."
        }
    }

    func sepeteEkle(film: Filmler, orderAmount: Int) async {
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
                orderAmount: orderAmount
            )
        } catch {
            self.errorMessage = "Sepete eklenirken hata: \(error.localizedDescription)"
        }
    }

    func hasMinimumForCart(_ f: Filmler) -> Bool {
        guard let name = f.name, !name.isEmpty else { return false }
        guard let image = f.image, !image.isEmpty else { return false }
        guard f.price != nil else { return false }
        return true
    }

    func canAddToCart(film: Filmler) -> Bool {
        return hasMinimumForCart(film)
    }
}
