//
//  ContentView.swift
//  Tiket Apa Saja
//
//  Created by Intan Saliya Utomo on 03/07/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: BottomAppBar.Tab = .home
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack(spacing: AppSizing.spacing0) {
                TabView(selection: $selectedTab) {
                    HomeView(navigationPath: $navigationPath)
                        .tag(BottomAppBar.Tab.home)
                    HomeView(navigationPath: $navigationPath)
                        .tag(BottomAppBar.Tab.tickets)
                    HomeView(navigationPath: $navigationPath)
                        .tag(BottomAppBar.Tab.profile)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .background(.gray3)
                
                BottomAppBar(selectedTab: $selectedTab)
            }
            .padding(.bottom, AppSizing.spacing500)
            .ignoresSafeArea()
            .navigationDestination(for: Category.self) { category in
                if category.label == "Event" {
                    EventListView(navigationPath: $navigationPath)
                }
            }
        }
    }
}

struct BottomAppBar: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
            HStack {
                ForEach(Tab.allCases, id: \.self) { tab in
                    TabItem(
                        tab: tab,
                        isSelected: selectedTab == tab,
                        action: { selectedTab = tab }
                    )
                }
            }
            .padding(.vertical, AppSizing.spacing200)
            .background(Color.gray3)
    }
    
    enum Tab: Int, CaseIterable {
        case home, tickets, profile
        
        var title: String {
            switch self {
            case .home: return "Home"
            case .tickets: return "My Ticket"
            case .profile: return "Profile"
            }
        }
        
        var icon: String {
            switch self {
            case .home: return "menu-home"
            case .tickets: return "menu-ticket"
            case .profile: return "menu-person"
            }
        }
        
        func logMessage() {
            print("Welcome to \(title) Page")
        }
    }
}

struct TabItem: View {
    let tab: BottomAppBar.Tab
    let isSelected: Bool
    let action: () -> Void
    
    @State private var isPressed = false
    private let animation = Animation.interactiveSpring(response: 0.4, dampingFraction: 0.8)
    
    var body: some View {
        Button(action: performAction) {
            VStack(spacing: 4) {
                Image(tab.icon)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
                    .scaleEffect(isPressed ? 0.8 : 1.0)
                
                Text(tab.title)
                    .font(.Label3())
            }
            .foregroundColor(isSelected ? .orange9 : .gray10)
        }
        .frame(maxWidth: .infinity)
        .buttonStyle(.plain)
    }
    
    private func performAction() {
        withAnimation(animation) {
            isPressed = true
        }
        action()
        tab.logMessage()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(animation) {
                isPressed = false
            }
        }
    }
}

#Preview {
    ContentView()
}
