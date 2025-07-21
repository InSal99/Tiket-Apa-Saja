//
//  EventDetailView.swift
//  edts-assignment-tiket-apa-saja
//
//  Created by Fauzan Sukmapratama on 06/07/25.
//

import SwiftUI

struct EventDetailView: View {
    @Binding var navigationPath: NavigationPath
    @State var isEventBookmarked: Bool = false
    
    var event: Event
    var eventViewModel: EventViewModel = EventViewModel()
    
    var body: some View {
            ScrollView(showsIndicators: false) {
                VStack {
                    ProductImageView(image: event.image)
                    ProductInfoView(title: event.title, date: event.formatEventDate(from: event.eventDate), time: event.time, location: event.city)
                    EventTicketView(tickets: event.tickets)
                    EventDescriptionView()
                    EventLocationView(eventLocation: event.location)
                    EventSimilarView(events: eventViewModel.events)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BadgedIcon(iconName: "chevron-left", showBadge: false, action: { navigationPath.removeLast() })
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    HStack(alignment: .center, spacing: AppSizing.spacing300) {
                        BadgedIcon(iconName: "share", showBadge: false, action: { print("Share Event") })

                        Button {
                            print("Bookmark")
                            withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.8)) {
                                isEventBookmarked.toggle()
                            }
                        } label: {
                            Image(isEventBookmarked ? "bookmark-added" : "bookmark-add")
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 24, height: 24)
                                .foregroundColor(isEventBookmarked ? .orange9 : .gray10)
                        }
                    }
                }
            }
            .background(.gray1)
            .toolbarBackground(.gray1)
            .navigationBarBackButtonHidden(true)
    }
}

struct ProductImageView: View {
    let image: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
        }
    }
}

struct ProductInfoView: View {
    let title: String
    let date: String
    let time: String
    let location: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppSizing.spacing200) {
            Text(title)
                .font(.Title1())
                .foregroundColor(.gray12)
            
            Divider()
                .overlay(.gray4)
                .padding(.vertical, AppSizing.spacing100)
            
            HStack {
                Image("calendar")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 16, height: 16)
                    .foregroundColor(.gray10)
                
                Text(date)
                    .Caption1TextStyle()
                    .foregroundColor(.gray10)
                    .lineLimit(1)
            }
            
            HStack {
                Image("clock")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 16, height: 16)
                    .foregroundColor(.gray10)
                
                Text(time)
                    .Caption1TextStyle()
                    .foregroundColor(.gray10)
                    .lineLimit(1)
            }
            
            HStack {
                Image("marker-pin")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 16, height: 16)
                    .foregroundColor(.gray10)
                
                Text(location)
                    .Caption1TextStyle()
                    .foregroundColor(.gray10)
                    .lineLimit(1)
            }
        }
        .padding(.horizontal, AppSizing.spacing400)
        .padding(.vertical, AppSizing.spacing500)
        .background(.gray2)
    }
}

struct EventTicketView: View {
    let tickets: [Tickets]
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppSizing.spacing200) {
            Text("Find the Best Tickets Price")
                .Subtitle1TextStyle()
                .foregroundColor(.gray12)
                .padding(.bottom, AppSizing.spacing200)
            
            ForEach(tickets) { item in
                TicketCard(ticket: item, detailAction: { print("Show all \(item.Name)  description tapped") }, bookAction: { print("Book tapped") })
            }
            
            RectButton.textOnly(label: "Show All Tickets", size: .small, style: .secondary, isDisabled: false, maxWidth: .infinity, action: { print("Show All Tickets") })
        }
        .padding(.horizontal, AppSizing.spacing400)
        .padding(.vertical, AppSizing.spacing500)
        .background(LinearGradient(gradient: Gradient(colors: [.gray2, .gray1]), startPoint: .top, endPoint: .bottom))
    }
}

struct EventDescriptionView: View {
    @State private var isExpanded = false
    @State private var eventDescription: String = "SOHO LIVE presents a spectacular collaboration with ConcernedApe, the creator and composer of Stardew Valley, bringing to life a unique concert experience titled Festival of Seasons.\n\nThis enchanting performance features a carefully curated selection of fans’ favorite music from the beloved game, transformed into an exquisite showcase by an 11-piece chamber ensemble.\n\nBuy the ticket now at ticket.com and feel the magic of Stardew Valley firsthand!"
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppSizing.spacing200) {
            Text("Description")
                .font(.Subtitle1())
                .foregroundColor(Color.gray12)
                .padding(.bottom, AppSizing.spacing200)
            
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
            
            RectButton.textOnly(label: isExpanded ? "View Less" : "Read More", size: .large, style: .tertiary(), isDisabled: false, action: { withAnimation(Animation.easeIn(duration: 0.2)) { isExpanded.toggle() } })
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, AppSizing.spacing400)
        .padding(.vertical, AppSizing.spacing500)
        .background(.gray2)
    }
}

struct EventLocationView: View {
    let eventLocation: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppSizing.spacing200) {
            Text("Location")
                .Subtitle2TextStyle()
                .foregroundColor(.gray12)
                .padding(.bottom, AppSizing.spacing200)
            
            VStack(spacing: AppSizing.spacing0) {
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
                            .Body2TextStyle()
                            .foregroundColor(Color.gray11)
                            .lineLimit(2)
                    }
                    
                    RectButton.textOnly(
                        label: "View Location",
                        size: .small,
                        style: .secondary,
                        isDisabled: false,
                        maxWidth: .infinity,
                        action: {
                            openLocationInMaps(location: eventLocation)
                            print("View \(eventLocation) in Google Maps")
                        }
                    )
                }
                .padding(AppSizing.spacing400)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.gray3)
            }
            .clipShape(RoundedRectangle(cornerRadius: AppSizing.borderRadius200, style: .continuous))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, AppSizing.spacing400)
        .padding(.vertical, AppSizing.spacing500)
        .background(.gray2)
    }
    
    func openLocationInMaps(location: String) {
        let encodedLocation = location.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let googleMapsURL = "https://www.google.com/maps/search/?api=1&query=\(encodedLocation)"
        let appleMapsURL = "http://maps.apple.com/?q=\(encodedLocation)"
        
        if let url = URL(string: googleMapsURL),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else if let url = URL(string: appleMapsURL) {
            // Fallback to Apple Maps if Google Maps isn't available
            UIApplication.shared.open(url)
        }
    }
}

struct EventSimilarView: View {
    let events: [Event]
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppSizing.spacing400) {
            Text("You may also like")
                .Subtitle1TextStyle()
                .foregroundColor(.gray12)
                .padding(.horizontal, AppSizing.spacing400)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: AppSizing.spacing200) {
                    ForEach(events) { item in
                        ProductCard(image: item.image, date: item.date, title: item.title, location: item.city, price: item.lowestPrice, haveDiscount: item.discountPercentage != 0, discountPercentage: item.discountPercentage, action: { print(item.title) })
                    }
                }
                .padding(.horizontal, AppSizing.spacing400)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, AppSizing.spacing400)
        .background(.gray2)
    }
}

#Preview {
    @Previewable @State var navigationPath = NavigationPath()
    let viewModel = EventViewModel()
    NavigationStack(path: $navigationPath) {
        EventDetailView(navigationPath: $navigationPath, event: Event(
            image: "product-stardew-valley-festival-of-seasons",
            title: "Stardew Valley: Festival of Seasons",
            date: "25 Jul 2025",
            venue: "Ciputra Artpreneur",
            city: "Jakarta",
            location: "Ciputra Artpreneur, RT.18 / RW.4, South Jakarta City, Jakarta, Indonesia, South Jakarta",
            discountPercentage: 0,
            time: "19:00 - 21:00 WIB",
            descriptionTitle: "Stardew Valley: Festival of Seasons heads to Jakarta due to overwhelming demand",
            description: "SOHO LIVE presents a spectacular collaboration with ConcernedApe, the creator and composer of Stardew Valley, bringing to life a unique concert experience titled Festival of Seasons. This enchanting performance features a carefully curated selection of fans' favorite music from the beloved game, transformed into an exquisite showcase by an 11-piece chamber ensemble.Buy the ticket now at ticket.com and feel the magic of Stardew Valley firsthand!",
            tickets: [
                Tickets(Name: "Early Bird - Steel", description: "This ticket is non-refundable and special standing area", price: 1150000, quota: 100),
                Tickets(Name: "Early Bird - Gold", description: "This ticket is non-refundable and special standing area", price: 1380000, quota: 100),
                Tickets(Name: "Early Bird - Iridium", description: "This ticket is non-refundable and special standing area", price: 1610000, quota: 100),
                Tickets(Name: "Early Bird - Wood", description: "This ticket is non-refundable and special standing area", price: 805000, quota: 100),
                Tickets(Name: "Early Bird - Copper", description: "This ticket is non-refundable and special standing area", price: 977500, quota: 100),
            ],
            category: "Concert",
            type: "Concert",
            dateAdded: Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date(), isBookmarked: false, isPopular: false
        ))
        .environmentObject(viewModel)
    }
}
