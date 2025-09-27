//
//  SepetSayfa.swift
//  FilmlerApp
//
//  Created by Rabia Yolcu on 25.09.2025.
//

import SwiftUI

struct GroupedSepetItem: Identifiable, Hashable {
    let key: String
    let name: String
    let image: String?
    let unitPrice: Int
    let totalAmount: Int
    let anyCartId: Int?
    let allCartIds: [Int]
    var id: String { key }
    let category: String?
    let rating: Double?
    let year: Int?
    let director: String?
    let description: String?
}

struct SepetSayfa: View {
    @StateObject private var viewModel = SepetSayfaViewModel()
    
    private var groupedItems: [GroupedSepetItem] {
        let groups = Dictionary(grouping: viewModel.sepetFilmlerListesi) { film in
            let name = film.name ?? ""
            let price = film.price ?? 0
            return "\(name)#\(price)"
        }
        
        return groups.map { (key, items) in
            let first = items.first
            return GroupedSepetItem(
                key: key,
                name: first?.name ?? "",
                image: first?.image,
                unitPrice: first?.price ?? 0,
                totalAmount: items.reduce(0) { $0 + ( $1.orderAmount ?? 0 ) },
                anyCartId: first?.cartId,
                allCartIds: items.compactMap { $0.cartId },
                category: first?.category ?? "",
                rating: first?.rating ?? 0,
                year:first?.year ?? 0,
                director: first?.director ?? "",
                description: first?.description ?? ""
            )
        }
        .sorted { $0.name < $1.name }
    }
    
    private var toplamFiyat: Int {
        groupedItems.reduce(0) { $0 + ($1.unitPrice * $1.totalAmount) }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.sepetFilmlerListesi.isEmpty {
                    Text("Sepet Boş!")
                        .foregroundStyle(AppColors.textColor)
                        .font(.title2)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach(groupedItems) { item in
                            ZStack {
                                NavigationLink(destination: DetaySayfa(passedFilm: filmFromGroupedItem(item))) {
                                    EmptyView()
                                }
                                .opacity(0)
                                
                                SepetFilmItem(
                                    grouped: item,
                                    onIncrease: {
                                        Task {
                                            if let cid = item.anyCartId {
                                                await viewModel.miktarArtir(cartId: cid)
                                            }
                                        }
                                    },
                                    onDecrease: {
                                        Task {
                                            if let cid = item.anyCartId {
                                                await viewModel.miktarAzalt(cartId: cid)
                                            }
                                        }
                                    }
                                )
                            }
                        }
                        .onDelete(perform: deleteGrouped)
                    }
                    
                    VStack(spacing: 20) {
                        HStack {
                            Text("Toplam:")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text("₺\(toplamFiyat)")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(AppColors.mainColor)
                        }
                        .padding(.horizontal, 20)
                        
                        Button("SEPETİ ONAYLA") {
                            print("Sepet onaylandı!")
                        }
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(AppColors.mainColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                    }
                }
            }
            .navigationTitle("Sepet")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                Task { await viewModel.sepetFilmleriYukle() }
            }
        }
    }
    
    private func deleteGrouped(at offsets: IndexSet) {
        let snapshot = groupedItems

        let cartIds: [Int] = offsets.reduce(into: [Int]()) { acc, idx in
            guard snapshot.indices.contains(idx) else { return }
            acc.append(contentsOf: snapshot[idx].allCartIds)
        }

        withAnimation(.easeInOut) {
            viewModel.removeLocally(cartIds: cartIds)
        }

        Task {
            for cid in cartIds {
                await viewModel.filmSilWithoutReload(cartId: cid)
            }
            await viewModel.sepetFilmleriYukle()
        }
    }
    
    private func filmFromGroupedItem(_ item: GroupedSepetItem) -> Filmler {
        let film = Filmler()
        film.id = item.anyCartId
        film.name = item.name
        film.image = item.image
        film.price = item.unitPrice
        film.category = item.category
        film.rating = item.rating
        film.year = item.year
        film.director = item.director
        film.description = item.description
        return film
    }
}

#Preview {
    SepetSayfa()
}
