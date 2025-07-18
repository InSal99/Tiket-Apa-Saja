//
//  EventDetailView.swift
//  edts-assignment-tiket-apa-saja
//
//  Created by Fauzan Sukmapratama on 06/07/25.
//

import SwiftUI

struct EventDetailView: View {
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    ProductImageView()
                    ProductInfoView()
                    TicketView()
                    EventDescriptionView()
                }
                .background(Color.gray1)
            }
        }
    }
}

/// Product Image
struct ProductImageView: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image("Hero")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
        }
    }
}

/// Product Info
struct ProductInfoView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Stardew Valley: Festival of Seasons")
                .font(.Title1())
                .foregroundColor(Color.gray12)
            
            Divider()
                .overlay(Color.gray4)
                .padding(.vertical, 4)
            
            
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(Color.gray12)
                    .font(.system(size: 16))
                
                Text("Wednesday, 04 June 2025")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color.gray12)
                    .lineLimit(1)
            }
            
            HStack {
                Image(systemName: "clock")
                    .foregroundColor(Color.gray12)
                    .font(.system(size: 16))
                
                Text("19:00 - 21:00 WIB")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color.gray12)
                    .lineLimit(1)
            }
            
            HStack {
                Image(systemName: "map")
                    .foregroundColor(Color.gray12)
                    .font(.system(size: 16))
                
                Text("Ciputra Artpreneur, Jakarta Selatan")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color.gray12)
                    .lineLimit(1)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
        .background(Color.gray2)
    }
}

/// Ticket Section
struct TicketView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Find the Best Tickets Price")
                // .font(.system(size: 18, weight: .bold))
                .font(.Subtitle1())
                .foregroundColor(Color.gray12)
                .padding(.bottom, 8)
            
            TicketCard(
                ticketType: "Early Bird - Steel",
                description: "This ticket is non-refundable and special standing area",
                price: "IDR 1.150.000",
                isSoldOut: false,
                detailAction: { print("Show all tapped") },
                bookAction: { print("Book tapped") }
            )
            
            TicketCard(
                ticketType: "Early Bird - Gold",
                description: "This ticket is non-refundable and special standing area",
                price: "IDR 1.380.000",
                isSoldOut: false,
                detailAction: { print("Show all tapped") },
                bookAction: { print("Book tapped") }
            )
            
            TicketCard(
                ticketType: "Early Bird - Iridium",
                description: "This ticket is non-refundable and special standing area",
                price: "IDR 1.610.000",
                isSoldOut: false,
                detailAction: { print("Show all tapped") },
                bookAction: { print("Book tapped") }
            )
            
            TicketCard(
                ticketType: "Early Bird - Wood",
                description: "This ticket is non-refundable and special standing area",
                price: "IDR 2.500.000",
                isSoldOut: true,
                detailAction: { print("Show all tapped") },
                bookAction: { print("Book tapped") }
            )
            
            TicketCard(
                ticketType: "Early Bird - Copper",
                description: "This ticket is non-refundable and special standing area",
                price: "IDR 2.500.000",
                isSoldOut: true,
                detailAction: { print("Show all tapped") },
                bookAction: { print("Book tapped") }
            )
            
            Button(action: {}) {
                Text("Show All Tickets")
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Color.gray12)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color.gray5)
                    .cornerRadius(8)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
        .background(LinearGradient(gradient: Gradient(colors: [Color.gray2, Color.gray1]), startPoint: .top, endPoint: .bottom))
    }
}

/// Description Section
struct EventDescriptionView: View {
    @State private var isExpanded = false
    @State private var productDescription: String = "SOHO LIVE presents a spectacular collaboration with ConcernedApe, the creator and composer of Stardew Valley, bringing to life a unique concert experience titled Festival of Seasons. This enchanting performance features a carefully curated selection of fans’ favorite music from the beloved game, transformed into an exquisite showcase by an 11-piece chamber ensemble."
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Deskripsi")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(Color.gray12)
                .padding(.bottom, 8)
            
            Text(productDescription)
                .font(.system(size: 14))
                .foregroundColor(Color.gray10)
                .lineLimit(isExpanded ? nil : 3)
            
            Button(action: {
                withAnimation(Animation.timingCurve(1, -0.4, 0.35, 0.95, duration: 1)) {
                    isExpanded.toggle()
                }
            }) {
                Text(isExpanded ? "View Less" : "Read More")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color(red: 0.97, green: 0.42, blue: 0.08))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
        .background(Color.gray2)
    }
}

#Preview {
    EventDetailView()
}
