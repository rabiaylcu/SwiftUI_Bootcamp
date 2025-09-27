//
//  Anasayfa.swift
//  FilmlerApp
//
//  Created by Rabia Yolcu on 25.09.2025.
//

import SwiftUI

struct Anasayfa: View {
    @StateObject private var viewModel = AnasayfaViewModel()
    @State private var searchText = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    private let twoCols: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        GeometryReader { geometry in
            let ekranGenislik = geometry.size.width
            let itemGenislik = (ekranGenislik - 50) / 2

            NavigationStack {
                ScrollView {
                    LazyVGrid(columns: twoCols, spacing: 20) {
                        ForEach(viewModel.filmlerListesi) { film in
                            FilmGridCell(
                                film: film,
                                width: itemGenislik,
                                onAddToCart: {
                                    await viewModel.filmSepeteEkle(film: film)
                                    await viewModel.sepetSayisiniGuncelle()
                                    alertMessage = "Film sepete eklendi!"
                                    showAlert = true
                                }
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                }
                .navigationTitle("Filmler")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        CartButton(itemCount: viewModel.sepetItemSayisi)
                    }
                }
                .searchable(text: $searchText, prompt: "Film Ara")
                .foregroundColor(AppColors.white)
                .onChange(of: searchText) { _, newValue in
                    Task { await viewModel.filmAra(searchText: newValue) }
                }
                .onAppear {
                    Task { await viewModel.filmleriYukle() }
                }
                .alert("Başarılı", isPresented: $showAlert) {
                    Button("Tamam", role: .cancel) { }
                } message: {
                    Text(alertMessage)
                }
            }
            .tint(.black)
        }
    }
}

private struct FilmGridCell: View {
    let film: Filmler
    let width: CGFloat
    let onAddToCart: () async -> Void

    var body: some View {
        NavigationLink(destination: DetaySayfa(passedFilm: film)) {
            FilmItem(film: film, genislik: width) {
                Task { await onAddToCart() }
            }
        }
        .buttonStyle(.plain)
    }
}

private struct CartButton: View {
    let itemCount: Int

    var body: some View {
        ZStack {
            NavigationLink(destination: SepetSayfa()) {
                Image(systemName: "cart")
                    .font(.system(size: 24))
                    .foregroundColor(AppColors.white)
            }
            if itemCount > 0 {
                Text("\(itemCount)")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(4)
                    .background(Color.red)
                    .clipShape(Circle())
                    .offset(x: 12, y: -12)
                    .accessibilityLabel("\(itemCount) ürün sepette")
            }
        }
    }
}

#Preview {
    Anasayfa()
}
