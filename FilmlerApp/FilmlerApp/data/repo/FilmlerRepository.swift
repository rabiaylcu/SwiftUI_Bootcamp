//
//  FilmlerRepository.swift
//  FilmlerApp
//
//  Created by Rabia Yolcu on 25.09.2025.
//

import Foundation

// MARK: - DTOs
struct FilmlerCevap: Codable {
    let movies: [Filmler]?
}

struct SepetFilmlerCevap: Codable {
    let movieCart: [SepetFilmler]?

    enum CodingKeys: String, CodingKey {
        case movieCart = "movie_cart"
    }
}

// MARK: - Repository
final class FilmlerRepository {

    static let shared = FilmlerRepository()

    private init(userName: String = "rabia_yolcu") {
        self.userName = userName
    }

    // MARK: - Private
    private let baseURL = URL(string: "http://kasimadalan.pe.hu/movies/")!
    private let userName: String

    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 20
        config.timeoutIntervalForResource = 30
        return URLSession(configuration: config)
    }()

    private func formBody(_ params: [String: String]) -> Data? {
        var components = URLComponents()
        components.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        return components.percentEncodedQuery?.data(using: .utf8)
    }

    private func validate(_ response: URLResponse, data: Data) throws {
        guard let http = response as? HTTPURLResponse else { return }
        guard (200..<300).contains(http.statusCode) else {
            #if DEBUG
            let body = String(data: data, encoding: .utf8) ?? ""
            print("❌ HTTP \(http.statusCode) | Body: \(body)")
            #endif
            throw URLError(.badServerResponse)
        }
    }

    // MARK: - Public API
    func getAllMovies() async throws -> [Filmler] {
        let url = baseURL.appendingPathComponent("getAllMovies.php")

        #if DEBUG
        print("➡️ GET \(url.absoluteString)")
        #endif

        let (data, response) = try await session.data(from: url)
        try validate(response, data: data)

        #if DEBUG
        print("✅ \(data.count) byte alındı")
        #endif

        let decoded = try JSONDecoder().decode(FilmlerCevap.self, from: data)
        return decoded.movies ?? []
    }

    func searchMovies(searchText: String) async throws -> [Filmler] {
        let all = try await getAllMovies()
        guard !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return all }
        let key = searchText.lowercased()
        return all.filter { ($0.name ?? "").lowercased().contains(key) }
    }

    func insertMovie(
        name: String,
        image: String,
        price: Int,
        category: String,
        rating: Double,
        year: Int,
        director: String,
        description: String,
        orderAmount: Int
    ) async throws {
        let url = baseURL.appendingPathComponent("insertMovie.php")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let params: [String: String] = [
            "name": name,
            "image": image,
            "price": String(price),
            "category": category,
            "rating": String(rating),
            "year": String(year),
            "director": director,
            "description": description,
            "orderAmount": String(orderAmount),
            "userName": userName
        ]

        request.httpBody = formBody(params)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        #if DEBUG
        print("➡️ POST \(url.absoluteString) | params: \(params)")
        #endif

        let (data, response) = try await session.data(for: request)
        try validate(response, data: data)
    }

    func getMovieCart() async throws -> [SepetFilmler] {
        let url = baseURL.appendingPathComponent("getMovieCart.php")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let params = ["userName": userName]
        request.httpBody = formBody(params)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        #if DEBUG
        print("➡️ POST \(url.absoluteString) | params: \(params)")
        #endif

        let (data, response) = try await session.data(for: request)
        try validate(response, data: data)

        let decoded = try JSONDecoder().decode(SepetFilmlerCevap.self, from: data)
        return decoded.movieCart ?? []
    }

    func deleteMovie(cartId: Int) async throws {
        let url = baseURL.appendingPathComponent("deleteMovie.php")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let params: [String: String] = [
            "cartId": String(cartId),
            "userName": userName
        ]

        request.httpBody = formBody(params)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        #if DEBUG
        print("➡️ POST \(url.absoluteString) | params: \(params)")
        #endif

        let (data, response) = try await session.data(for: request)
        try validate(response, data: data)
    }
}
