//
//  SepetFilmItem.swift
//  FilmlerApp
//
//  Created by Rabia Yolcu on 25.09.2025.
//

import SwiftUI

fileprivate struct DisplaySepetFilm {
    let name: String
    let imageName: String?
    let unitPrice: Int
    let amount: Int
    var subtotal: Int { unitPrice * amount }
    var imageURL: URL? {
        guard let imageName else { return nil }
        return URL(string: "http://kasimadalan.pe.hu/movies/images/\(imageName)")
    }
}

struct SepetFilmItem: View {
    private let model: DisplaySepetFilm
    
    var onIncrease: () -> Void = {}
    var onDecrease: () -> Void = {}
    
    // MARK: - Item
    init(
        sepetFilm: SepetFilmler = SepetFilmler(),
        onIncrease: @escaping () -> Void = {},
        onDecrease: @escaping () -> Void = {}
    ) {
        let name = sepetFilm.name ?? ""
        let image = sepetFilm.image
        let unitPrice = sepetFilm.price ?? 0
        let amount = sepetFilm.orderAmount ?? 0
        self.model = DisplaySepetFilm(name: name, imageName: image, unitPrice: unitPrice, amount: amount)
        self.onIncrease = onIncrease
        self.onDecrease = onDecrease
    }
    
    // MARK: - Grup
    init(
        grouped: GroupedSepetItem,
        onIncrease: @escaping () -> Void = {},
        onDecrease: @escaping () -> Void = {}
    ) {
        self.model = DisplaySepetFilm(
            name: grouped.name,
            imageName: grouped.image,
            unitPrice: grouped.unitPrice,
            amount: grouped.totalAmount
        )
        self.onIncrease = onIncrease
        self.onDecrease = onDecrease
    }

    var body: some View {
        HStack(spacing: 15) {
            AsyncImage(url: model.imageURL) { image in
                image
                    .resizable()
                    .frame(width: 80, height: 112)
                    .cornerRadius(8)
            } placeholder: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 80, height: 112)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(model.name)
                    .font(.headline)
                    .foregroundStyle(AppColors.textColor)
                
                HStack(spacing: 15) {
                    Button("-") { onDecrease() }
                        .frame(width: 30, height: 30)
                        .background(AppColors.mainColor)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .disabled(model.amount <= 1)
                        .buttonStyle(.borderless)

                    Text("Adet: \(model.amount)")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .monospacedDigit()
                    
                    Button("+") { onIncrease() }
                        .frame(width: 30, height: 30)
                        .background(AppColors.mainColor)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .buttonStyle(.borderless) 
                }
                
                Text("\(model.subtotal) ₺")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(AppColors.mainColor)
            }
            
            Spacer()
        }
        .padding(8)
        .contentShape(Rectangle())
    }
}
