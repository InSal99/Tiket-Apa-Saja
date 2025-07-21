//
//  EventDetailView.swift
//  edts-assignment-tiket-apa-saja
//
//  Created by Fauzan Sukmapratama on 06/07/25.
//

import SwiftUI

// MARK: - Data Model

/// A data structure to hold information about an event.
/// Used for the "You may also like" section.
struct EventData {
    let image: String
    let date: String
    let title: String
    let location: String
    let originalPrice: String
    let discountedPrice: String
    let discountPercentage: String
}

// MARK: - Main View

/// The primary view that constructs the entire event detail screen.
/// It arranges all the smaller component views within a `ScrollView`.
struct EventDetailView: View {
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    ProductImageView()
                    ProductInfoView()
                    EventTicketView()
                    EventDescriptionView()
                    EventLocationView()
                    EventSimilarView()
                }
                .background(Color.gray1)
            }
            .ignoresSafeArea(.all, edges: [.top, .bottom])
        }
    }
}


// MARK: - UI Components

/// Displays the main hero image for the event.
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

/// Displays core information about the event, such as title, date, time, and location.
struct ProductInfoView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: AppSizing.spacing200) {
            Text("Stardew Valley: Festival of Seasons")
                .font(.Title1())
                .foregroundColor(Color.gray12)
            
            Divider()
                .overlay(Color.gray4)
                .padding(.vertical, 4)
            
            
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(Color.gray10)
                    .font(.system(size: 16))
                
                Text("Wednesday, 04 June 2025")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color.gray10)
                    .lineLimit(1)
            }
            
            HStack {
                Image(systemName: "clock")
                    .foregroundColor(Color.gray10)
                    .font(.system(size: 16))
                
                Text("19:00 - 21:00 WIB")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color.gray10)
                    .lineLimit(1)
            }
            
            HStack {
                Image(systemName: "map")
                    .foregroundColor(Color.gray10)
                    .font(.system(size: 16))
                
                Text("Ciputra Artpreneur, Jakarta Selatan")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color.gray10)
                    .lineLimit(1)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, AppSizing.spacing400)
        .padding(.vertical, AppSizing.spacing500)
        .background(Color.gray2)
    }
}


/// The section that lists available event tickets using `TicketCard` views.
struct EventTicketView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Find the Best Tickets Price")
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

/// An expandable view that shows the event's description.
/// Includes a "Read More" / "View Less" button to toggle the text's line limit.
struct EventDescriptionView: View {
    @State private var isExpanded = false
    @State private var eventDescription: String = "SOHO LIVE presents a spectacular collaboration with ConcernedApe, the creator and composer of Stardew Valley, bringing to life a unique concert experience titled Festival of Seasons.\n\nThis enchanting performance features a carefully curated selection of fans’ favorite music from the beloved game, transformed into an exquisite showcase by an 11-piece chamber ensemble.\n\nBuy the ticket now at ticket.com and feel the magic of Stardew Valley firsthand!"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Description")
                .font(.Subtitle1())
                .foregroundColor(Color.gray12)
                .padding(.bottom, 8)
            
            ZStack(alignment: .bottomLeading) {
                
                Text(eventDescription)
                    .font(.Body2())
                    .foregroundColor(Color.gray10)
                    .lineLimit(isExpanded ? nil : 8)
                    .fixedSize(horizontal: false, vertical: true)
                    .clipped()
                    .animation(.none, value: isExpanded)
                
                if !isExpanded {
                    VStack {
                        Spacer()
                        
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: Color.gray2.opacity(0), location: 0.0),
                                .init(color: Color.gray2, location: 1.0)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 56)
                        .allowsHitTesting(false)
                    }
                }
            }
            
            Button(action: {
                withAnimation(Animation.easeIn(duration: 0.2)) {
                    isExpanded.toggle()
                }
            }) {
                Text(isExpanded ? "View Less" : "Read More")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color.orange9)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
        .background(Color.gray2)
    }
}

/// Displays the event's location with a map image and a button to view the location.
struct EventLocationView: View {
    @State private var eventLocation: String = "Ciputra Artpreneur, RT. 18 / RW. 4, South Jakarta, Jakarta, Indonesia"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Location")
                .font(.Subtitle1())
                .foregroundColor(Color.gray12)
                .padding(.bottom, 8)
            
            VStack(spacing: 0) {
                Image("Map")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                
                VStack(alignment: .leading, spacing: AppSizing.spacing300) {
                    HStack(alignment: .top) {
                        Image(systemName: "map")
                            .foregroundColor(Color.gray11)
                            .font(.system(size: 16))
                        
                        Text(eventLocation)
                            .font(.Body2())
                            .foregroundColor(Color.gray11)
                            .lineLimit(2)
                    }
                    
                    Button(action: {}) {
                        Text("View Location")
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(Color.gray12)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(Color.gray5)
                            .cornerRadius(8)
                    }
                }
                .padding(AppSizing.spacing400)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray3)
            }
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
        .background(Color.gray2)
    }
}

/// A section that displays a horizontal list of similar or recommended events.
struct EventSimilarView: View {
    
    let similarEvents = [
        EventData(
            image: "event-image-1",
            date: "25 Jul 2025",
            title: "Wicked Wonders: A Cabaret Night at Ash Nuanu",
            location: "Jakarta",
            originalPrice: "IDR 176.000",
            discountedPrice: "IDR 160.000",
            discountPercentage: "10%"
        ),
        EventData(
            image: "event-image-2",
            date: "28 Jul 2025",
            title: "Friday Tunes with Vierratale",
            location: "Bandung",
            originalPrice: "IDR 250.000",
            discountedPrice: "IDR 200.000",
            discountPercentage: "20%"
        ),
        EventData(
            image: "event-image-3",
            date: "02 Aug 2025",
            title: "13 Black Parade Rumble Ground",
            location: "Surabaya",
            originalPrice: "IDR 300.000",
            discountedPrice: "IDR 270.000",
            discountPercentage: "10%"
        )
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("You may also like")
                .font(.Subtitle1())
                .foregroundColor(Color.gray12)
                .padding(.horizontal, 16)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 8) {
                    ForEach(similarEvents.indices, id: \.self) { index in
                        EventCardView(event: similarEvents[index])
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 16)
        .background(Color.gray2)
    }
}

/// A reusable card designed to display a summary of an event.
/// Used within the `EventSimilarView` horizontal scroll list.
struct EventCardView: View {
    let event: EventData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(event.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
            
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(event.date)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color.gray10)
                    
                    Text(event.title)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color.gray12)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text(event.location)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color.gray10)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(event.discountedPrice)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color.gray12)
                    
                    HStack(spacing: 4) {
                        Text(event.originalPrice)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(Color.gray9)
                            .strikethrough()
                        
                        Text(event.discountPercentage)
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(Color.orange9)
                    }
                }
            }
            .padding(12)
        }
        .frame(width: 152)
        .background(Color.gray3)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}


// MARK: - Preview

#Preview {
    EventDetailView()
}
