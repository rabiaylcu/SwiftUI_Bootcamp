//
//  FilmItem.swift
//  FilmlerApp
//
//  Created by Rabia Yolcu on 25.09.2025.
//

import SwiftUI

struct FilmItem: View {
    var film = Filmler()
    var genislik = 0.0
    var onSepeteEkle: () -> Void = {}
    
    var body: some View {
        VStack(spacing: 8) {
            AsyncImage(url: URL(string: "http://kasimadalan.pe.hu/movies/images/\(film.image!)")) { image in
                image
                    .resizable()
                    .frame(width: genislik, height: genislik * 1.5)
                    .cornerRadius(8)
            } placeholder: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: genislik, height: genislik * 1.5)
            }
            
            HStack {
                Text("\(film.price!) ₺")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(AppColors.mainColor)
                    .padding(.leading, 5)
                
                Spacer()
                
                Button("Sepete Ekle") {
                    onSepeteEkle()
                }
                .font(.system(size: 11))
                .padding(.horizontal, 8)
                .padding(.vertical, 6)
                .foregroundColor(.white)
                .background(AppColors.mainColor)
                .cornerRadius(5)
                .padding(.trailing, 5)
                .buttonStyle(.borderless)
            }
            .padding(.bottom, 8)
        }
        .background(Rectangle().fill(Color.white).shadow(radius: 3))
        .contentShape(Rectangle())
    }
}
