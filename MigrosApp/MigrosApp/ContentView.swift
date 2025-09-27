//
//  ContentView.swift
//  MigrosApp
//
//  Created by Rabia Yolcu on 14.09.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var currentBannerIndex = 0
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    headerView
                    searchBarView
                    scrollableBannerView
                    serviceGridView
                    servicesSection
                    
                    Spacer()
                        .frame(height: 70)
                }
            }
            .background(Color(.white))
            .ignoresSafeArea(edges: .top)
            
            VStack {
                Spacer()
                bottomBarView
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
    
    private var headerView: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color.clear)
                .frame(height: 60)
            
            HStack {
                Spacer()
                
                Text("MiGROS")
                    .font(.system(size: 30, weight: .heavy))
                    .foregroundColor(.orange)
                
                Spacer()
                
                ZStack(alignment: .topTrailing) {
                    Button(action: {}) {
                        Image(systemName: "bell.fill")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.black)
                            .padding(10) // ikona biraz boşluk
                            .background(
                                Circle()
                                    .fill(Color.gray.opacity(0.15))
                            )
                    }
                    
                    Circle()
                        .fill(.orange)
                        .frame(width: 10, height: 10)
                        .offset(x: -4, y: 1)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 10)
        }
        .background(Color.white)
    }

    
    private var searchBarView: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .font(.system(size: 16))
            
            Text("Ürün, yemek veya hizmet ara")
                .font(.system(size: 16))
                .foregroundColor(.gray)
            
            Spacer()
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color(.gray.opacity(0.1)))
        .cornerRadius(25)
        .padding(.horizontal, 20)
        .padding(.bottom, 15)
        .background(Color.white)
    }
    
    private var scrollableBannerView: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentBannerIndex) {
                Image("img17")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: 140)
                    .clipped()
                    .tag(0)
                
                Image("img16")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: 160)
                    .clipped()
                    .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 130)
        }
        .padding(.horizontal, 10)
        .padding(.bottom, 20)
    }
    
    private var serviceGridView: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 3), spacing: 10) {
            ServiceCard(imageName: "img19")
            ServiceCard(imageName: "img20")
            ServiceCard(imageName: "img21")
            
            ServiceCard(imageName: "img5")
            ServiceCard(imageName: "img6")
            ServiceCard(imageName: "img22")
            
            ServiceCard(imageName: "img8")
            ServiceCard(imageName: "img9")
            ServiceCard(imageName: "img10")
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
    
    private var servicesSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Hizmetler")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                Spacer()
            }
            .padding(.horizontal, 25)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 4), spacing: 8) {
                ServiceItem(title: "Tıkla Gel Al", imageName: "img11")
                ServiceItem(title: "UniMoney", imageName: "img12")
                ServiceItem(title: "Hızlı Yemek", imageName: "img23")
                ServiceItem(title: "MAYA", imageName: "img14")
            }
            .padding(.horizontal, 20)
        }
    }
    
    private var bottomBarView: some View {
        VStack(spacing: 0) {
            ZStack {
                Capsule()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 2)
                    .padding(.horizontal, 1)
                
                VStack(spacing: 4) {
                    ZStack {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 70, height: 60)
                            .shadow(color: .blue.opacity(0.3), radius: 4, x: 0, y: 2)
                        
                        Image(systemName: "qrcode")
                            .foregroundColor(.white)
                            .font(.system(size: 35, weight: .medium))
                    }
                    
                    Text("QR ile Öde")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.blue)
                }
            }
            .padding(.vertical, 11)
            .background(Color.white)
        }
    }
}

struct ServiceCard: View {
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 95)
            .clipped()
            .cornerRadius(12)
            .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 1)
    }
}

struct ServiceItem: View {
    let title: String
    let imageName: String
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(.systemGray6))
                    .frame(height: 60)
                
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 75)
            }
            
            Text(title)
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
    }
}

#Preview {
    ContentView()
}
