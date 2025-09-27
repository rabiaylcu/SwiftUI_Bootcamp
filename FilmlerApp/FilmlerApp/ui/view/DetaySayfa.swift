//
//  DetaySayfa.swift
//  FilmlerApp
//
//  Created by Rabia Yolcu on 25.09.2025.
//

import SwiftUI

private let imageBaseURL = "http://kasimadalan.pe.hu/movies/images/"

struct DetaySayfa: View {
    
    var passedFilm: Filmler?

    @StateObject private var viewModel = DetaySayfaViewModel()
    @State private var adet = 1
    @State private var showSuccess = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 16) {
            // Yükleniyor
            if viewModel.isLoading {
                ProgressView("Yükleniyor…")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            // Hata
            else if let error = viewModel.errorMessage {
                VStack(spacing: 12) {
                    Text(error)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.red)
                    Button("Tekrar Dene") {
                        Task { await viewModel.loadFilm(passed: passedFilm) }
                    }
                    .buttonStyle(.borderedProminent)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            // İçerik
            else if let film = viewModel.film {
                ScrollView {
                    VStack(spacing: 24) {
                     
                        AsyncImage(url: URL(string: imageBaseURL + (film.image ?? ""))) { phase in
                            switch phase {
                            case .success(let img):
                                img.resizable()
                                    .frame(width: 200, height: 280)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            case .empty:
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 200, height: 280)
                            case .failure:
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.gray.opacity(0.2))
                                    .overlay(Image(systemName: "photo").font(.largeTitle))
                                    .frame(width: 200, height: 280)
                            @unknown default:
                                Color.gray.frame(width: 200, height: 280)
                            }
                        }
                        .frame(maxWidth: .infinity)

                        VStack(spacing: 10) {
                            Text(film.name ?? "Bilinmeyen Film")
                                .font(.title)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)

                            if let director = film.director, !director.isEmpty {
                                Text("Yönetmen: \(director)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }

                            if let year = film.year {
                                Text("Yıl: \(year)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }

                            HStack(spacing: 6) {
                                Image(systemName: "star.fill").foregroundColor(.yellow)
                                Text(String(format: "%.1f", film.rating ?? 0.0))
                                    .font(.subheadline)
                            }

                            if let desc = film.description, !desc.isEmpty {
                                Text(desc)
                                    .font(.body)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                            }

                            Text("\(film.price ?? 0) ₺")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(AppColors.mainColor)
                        }

                        HStack(spacing: 20) {
                            Button("-") { if adet > 1 { adet -= 1 } }
                                .frame(width: 40, height: 40)
                                .background(AppColors.mainColor)
                                .foregroundColor(.white)
                                .clipShape(Circle())

                            Text("\(adet)")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .frame(width: 50)
                                .monospacedDigit()

                            Button("+") { adet += 1 }
                                .frame(width: 40, height: 40)
                                .background(AppColors.mainColor)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                        }

                        // Sepete Ekle
                        Button("Sepete Ekle") {
                            Task {
                                if let film = viewModel.film {
                                    await viewModel.sepeteEkle(film: film, orderAmount: adet)
                                    if viewModel.errorMessage == nil { showSuccess = true }
                                }
                            }
                        }
                        .buttonStyle(CustomButtonStyle())
                        .disabled({ if let f = viewModel.film { return !viewModel.canAddToCart(film: f) } else { return true } }())
                        .opacity({ if let f = viewModel.film { return viewModel.canAddToCart(film: f) ? 1 : 0.5 } else { return 0.5 } }())
                    }
                    .padding(.vertical, 12)
                }
            }
            else {
                Text("Film bulunamadı.")
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .padding()
        .navigationTitle(viewModel.film?.name ?? "Detay")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadFilm(passed: passedFilm)
        }
        .alert("Başarılı", isPresented: $showSuccess) {
            Button("Tamam", role: .cancel) { dismiss() }
        } message: {
            Text("Film sepete eklendi!")
        }
    }
}

#Preview {
    DetaySayfa(passedFilm: nil)
}
