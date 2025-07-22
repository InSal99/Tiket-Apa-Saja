//
//  HomeView.swift
//  Tiket Apa Saja
//
//  Created by Intan Saliya Utomo on 07/07/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var homeViewModel = HomeViewModel()
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
                ScrollView {
                    VStack {
                        HeroCarouselView(promos: homeViewModel.promos)
                        
                        CategoriesTilesView(
                            categories: homeViewModel.categoryViewModel.categories,
                            onCategoryTap: homeViewModel.handleCategorySelection
                        )
                        
                        SectionsView(
                            locationName: homeViewModel.locationName,
                            entertainments: homeViewModel.entertainmentViewModel.entertainments, attractions: homeViewModel.attractionViewModel.attractions, popularEvents: homeViewModel.eventViewModel.getPopularEvents(), localEvents: homeViewModel.handleLocalEvents(),
                            onSubscriptionToggle: homeViewModel.handleSubscriptionToggle
                        )
                    }
                }
            .background(.gray1)
            .onChange(of: homeViewModel.navigateToCategory) {_, category in
                if let category = category, category.label == "Event" {
                    homeViewModel.navigateToCategory = nil
                    navigationPath.append(category)
                }
            }
            .navigationBarHidden(true)
            .safeAreaInset(edge: .top, spacing: AppSizing.spacing0) {
                TopAppBarView(
                    text: $homeViewModel.searchText,
                    locationName: homeViewModel.locationName
                )
                .background(.ultraThinMaterial)
            }
    }
}

struct TopAppBarView: View {
    @Binding var text: String
    let locationName: String
    
    private let locationPrefix: String = "Near To"
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppSizing.spacing0) {
            HStack(alignment: .center, spacing: AppSizing.spacing200) {
                SearchBar(placeholders: ["Musical", "Orchestra", "Concert"], prefix: "Search ")
                
                BadgedIcon(iconName: "product", showBadge: false) {
                    print("Go to Promo Page")
                }
                
                BadgedIcon(iconName: "notifications", showBadge: true) {
                    print("Go to Notification Page")
                }
            }
            .padding(.vertical, AppSizing.spacing200)
            .padding(.horizontal, AppSizing.spacing400)
            
            HStack(alignment: .center, spacing: AppSizing.spacing100) {
                Text(locationPrefix)
                    .font(.Caption1())
                    .foregroundColor(.gray10)
                
                RectButton.withRightIcon(
                    label: locationName,
                    icon: "expand-more",
                    size: .small,
                    style: .tertiary(.gray11),
                    isDisabled: false,
                    action: { print("Choose Location") }
                )
            }
            .padding(.top, AppSizing.spacing150)
            .padding(.horizontal, AppSizing.spacing400)
            .padding(.bottom, AppSizing.borderRadius300)
            
            Divider()
                .frame(height: AppSizing.borderWidth25)
                .background(.gray4)
        }
        .background(.gray3)
    }
}

struct HeroCarouselView: View {
    let promos: [String]
    
    var body: some View {
        Carousel(images: promos)
            .padding(AppSizing.spacing400)
    }
}

struct CategoriesTilesView: View {
    let categories: [Category]
    let onCategoryTap: (Category) -> Void
    
    var body: some View {
        HStack {
            ForEach(categories) { category in
                IconButton(
                    category: category,
                    isDisabled: false,
                    action: { onCategoryTap(category) }
                )
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical, AppSizing.spacing300)
        .padding(.horizontal, AppSizing.spacing400)
    }
}

struct SectionsView: View {
    let locationName: String
    let entertainments: [Entertainment]
    let attractions: [Attraction]
    let popularEvents: [Event]
    let localEvents: [Event]
    let onSubscriptionToggle: (UUID) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppSizing.spacing800) {
            TASSection(
                title: "Popular Events",
                action: { print("See All Popular Events") },
                content: {
                    ForEach(popularEvents) { item in
                        ProductCard(image: item.image, date: item.date, title: item.title, location: item.city, price: item.lowestPrice, haveDiscount: item.discountPercentage != 0, discountPercentage: item.discountPercentage, action: { print(item.title + " Selected") })
                            .size(type: .small)
                    }
                }
            )
            
            TASSection(
                title: "Best Deal Attractions",
                action: { print("See All Best Deal Attractions") },
                content: {
                    ForEach(attractions) { item in
                        Image(item.image)
                    }
                }
            )
            
            TASSection(
                title: "Events in " + locationName,
                action: { print("See All Events in " + locationName) },
                content: {
                    ForEach(localEvents) { item in
                        ProductCard(image: item.image, date: item.date, title: item.title, location: item.city, price: item.lowestPrice, haveDiscount: item.discountPercentage != 0, discountPercentage: item.discountPercentage, action: { print(item.title + " Selected") })
                            .size(type: .small)
                    }
                }
            )
            
            TASSection(
                title: "Entertainments",
                action: { print("See All Entertainments") },
                content: {
                    ForEach(entertainments) { item in
                        EntertainmentCard(
                            entertainment: item,
                            onSubscriptionToggle: { onSubscriptionToggle(item.id) }
                        )
                    }
                }
            )
        }
        .padding(AppSizing.spacing400)
    }
}

struct TASSection<Content: View>: View {
    let title: String
    let action: () -> Void
    let content: Content
    
    init(title: String, action: @escaping () -> Void, @ViewBuilder content: () -> Content) {
        self.title = title
        self.action = action
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppSizing.spacing200) {
            HStack {
                Text(title)
                    .font(.Subtitle1())
                    .foregroundColor(.gray12)
                
                Spacer()
                
                RectButton.withRightIcon(
                    label: "See All",
                    icon: "chevron-right",
                    size: .small,
                    style: .tertiary(),
                    isDisabled: false,
                    action: action
                )
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppSizing.spacing200) {
                    content
                }
            }
            .scrollClipDisabled()
        }
    }
}

#Preview {
    @Previewable @State var navigationPath = NavigationPath()
    return HomeView(navigationPath: $navigationPath)
        .environmentObject(HomeViewModel())
}
