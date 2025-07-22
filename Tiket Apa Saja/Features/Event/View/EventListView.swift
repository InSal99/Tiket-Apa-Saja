//
//  EventListView.swift
//  Tiket Apa Saja
//
//  Created by Intan Saliya Utomo on 07/07/25.
//

import SwiftUI

struct EventListView: View {
    @StateObject private var viewModel = EventViewModel()
    @State var showSheetFilter: Bool = false
    @State var showSheetLocation: Bool = false
    @State var isSelectedCheckbox: Bool = false
    @State var selectedFilter: Set<String> = []
    @State var appliedFilter: Set<String> = []
    @State private var activeBodyChip: String? = nil
    @State private var appliedBodyChip: String? = nil
    
    @Binding var navigationPath: NavigationPath
    
    private var hasLocationFilters: Bool {
        let locationFilters = ["Balikpapan", "Surabaya", "Jakarta", "Semarang", "Bali", "Blitar"]
        return locationFilters.contains { appliedFilter.contains($0) }
    }
    
    private var hasOtherFilters: Bool {
        let categoryFilters = ["Musical", "Concert", "Orchestra"]
        let typeFilters = ["Musical", "Concert", "Orchestra"]
        let sortFilters = ["Upcoming", "Just Announced", "Lowest Price", "Highest Price"]
        
        return categoryFilters.contains { appliedFilter.contains($0) } ||
        typeFilters.contains { appliedFilter.contains($0) } ||
        sortFilters.contains { appliedFilter.contains($0) }
    }
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    fileprivate func footer2Btn() -> some View {
        return HStack(spacing: AppSizing.spacing200){
            RectButton(label: "Reset", action: {
                selectedFilter.removeAll()
                appliedFilter.removeAll()
                activeBodyChip = nil
                appliedBodyChip = nil
                
                viewModel.applyFilters(appliedFilter)
                
                print("Reset - All filters cleared")
                if showSheetFilter == true{
                    showSheetFilter.toggle()
                }else if showSheetLocation == true {
                    showSheetLocation.toggle()
                }
            }, style: .secondary, maxWidth: .infinity)
            
            RectButton(label: "Apply", action: {
                appliedFilter = selectedFilter
                appliedBodyChip = activeBodyChip
                
                viewModel.applyFilters(appliedFilter)
                
                print("Apply - Applied filters: \(appliedFilter)")
                if showSheetFilter == true{
                    showSheetFilter.toggle()
                }else if showSheetLocation == true {
                    showSheetLocation.toggle()
                }
            }, maxWidth: .infinity)
            
        }
        .padding(.horizontal, AppSizing.spacing400)
        .padding(.top, AppSizing.spacing400)
        .padding(.bottom, AppSizing.spacing300)
        .overlay{
            Path { path in
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 0))
            }
            .stroke(Color.gray4, lineWidth: AppSizing.borderWidth25)
        }
    }
    
    private func filterBinding(for location: String) -> Binding<Bool> {
        Binding(
            get: { selectedFilter.contains(location) },
            set: { _ in
                if selectedFilter.contains(location) {
                    selectedFilter.remove(location)
                } else {
                    selectedFilter.insert(location)
                }
            }
        )
    }
    
    private func selectBodyChip(_ chipName: String) {
        let bodyChips = ["Upcoming", "Just Announced", "Lowest Price", "Highest Price"]
        
        if activeBodyChip == chipName {
            activeBodyChip = nil
            selectedFilter.remove(chipName)
        } else {
            bodyChips.forEach { selectedFilter.remove($0) }
            
            activeBodyChip = chipName
            selectedFilter.insert(chipName)
        }
    }
    
    private func selectOutsideBodyChip(_ chipName: String) {
        let bodyChips = ["Upcoming", "Just Announced"]
        
        if appliedBodyChip == chipName {
            appliedBodyChip = nil
            appliedFilter.remove(chipName)
            activeBodyChip = nil
            selectedFilter.remove(chipName)
        } else {
            bodyChips.forEach {
                appliedFilter.remove($0)
                selectedFilter.remove($0)
            }
            
            appliedBodyChip = chipName
            appliedFilter.insert(chipName)
            activeBodyChip = chipName
            selectedFilter.insert(chipName)
        }
        viewModel.applyFilters(appliedFilter)
    }
    
    private func syncTemporaryState() {
        selectedFilter = appliedFilter
        activeBodyChip = appliedBodyChip
    }
    
    
    fileprivate func filterSheet() -> some View {
        return ZStack {
            Color.gray3.ignoresSafeArea()
            
            VStack(spacing: AppSizing.spacing300){
                HStack(spacing: AppSizing.spacing0){
                    Text("Filter")
                        .Subtitle1TextStyle()
                        .foregroundStyle(Color.gray12)
                        .padding(.horizontal, AppSizing.spacing400)
                        .padding(.vertical, AppSizing.spacing200)
                    Spacer()
                }
                
                ScrollView(.vertical, showsIndicators: false){
                    VStack(alignment: .leading, spacing: AppSizing.spacing600){
                        VStack(alignment: .leading, spacing: AppSizing.spacing300){
                            Text("Sort By")
                                .Subtitle2TextStyle()
                                .foregroundStyle(Color.gray12)
                            
                            VStack(alignment: .leading, spacing: AppSizing.spacing200){
                                HStack(alignment: .top, spacing: AppSizing.spacing200){
                                    Chip(text: "Upcoming", isActive: .constant(activeBodyChip == "Upcoming"), action: {
                                        selectBodyChip("Upcoming")
                                    })
                                    Chip(text: "Just Announced", isActive: .constant(activeBodyChip == "Just Announced"), action: {
                                        selectBodyChip("Just Announced")
                                    })
                                }
                                HStack(alignment: .top, spacing: AppSizing.spacing200){
                                    Chip(text: "Lowest Price", isActive: .constant(activeBodyChip == "Lowest Price"), action: {
                                        selectBodyChip("Lowest Price")
                                    })
                                    Chip(text: "Highest Price", isActive: .constant(activeBodyChip == "Highest Price"), action: {
                                        selectBodyChip("Highest Price")
                                    })
                                }
                            }
                        }.padding(.horizontal, AppSizing.spacing400)
                        
                        VStack(alignment: .leading, spacing: AppSizing.spacing300){
                            Text("Location")
                                .Subtitle2TextStyle()
                                .foregroundStyle(Color.gray12)
                            
                            VStack(alignment: .leading, spacing: AppSizing.spacing0){
                                Checkbox(isActive: filterBinding(for: "Balikpapan")).showLabel(label: "Balikpapan")
                                Checkbox(isActive: filterBinding(for: "Surabaya")).showLabel(label: "Surabaya")
                                Checkbox(isActive: filterBinding(for: "Jakarta")).showLabel(label: "Jakarta")
                                Checkbox(isActive: filterBinding(for: "Semarang")).showLabel(label: "Semarang")
                                Checkbox(isActive: filterBinding(for: "Bali")).showLabel(label: "Bali")
                                Checkbox(isActive: filterBinding(for: "Blitar")).showLabel(label: "Blitar")
                            }
                        }.padding(.horizontal, AppSizing.spacing400)
                        
                        VStack(alignment: .leading, spacing: AppSizing.spacing300){
                            Text("Category")
                                .Subtitle2TextStyle()
                                .foregroundStyle(Color.gray12)
                            
                            VStack(alignment: .leading, spacing: AppSizing.spacing0){
                                Checkbox(isActive: filterBinding(for: "Musical")).showLabel(label: "Musical")
                                Checkbox(isActive: filterBinding(for: "Concert")).showLabel(label: "Concert")
                                Checkbox(isActive: filterBinding(for: "Orchestra")).showLabel(label: "Orchestra")
                            }
                        }.padding(.horizontal, AppSizing.spacing400)
                        
                        VStack(alignment: .leading, spacing: AppSizing.spacing300){
                            Text("Type")
                                .Subtitle2TextStyle()
                                .foregroundStyle(Color.gray12)
                            
                            VStack(alignment: .leading, spacing: AppSizing.spacing0){
                                Checkbox(isActive: filterBinding(for: "Musical")).showLabel(label: "Musical")
                                Checkbox(isActive: filterBinding(for: "Concert")).showLabel(label: "Concert")
                                Checkbox(isActive: filterBinding(for: "Orchestra")).showLabel(label: "Orchestra")
                            }
                        }.padding(.horizontal, AppSizing.spacing400)
                    }
                }
                footer2Btn()
            }
            .padding(.top, AppSizing.spacing500)
        }
        .presentationDetents([.fraction(0.5), .fraction(0.999)])
        .presentationDragIndicator(.visible)
        .presentationCornerRadius(AppSizing.borderRadius400)
    }
    
    fileprivate func locationSheet() -> some View {
        return ZStack {
            Color.gray3.ignoresSafeArea()
            
            VStack(spacing: AppSizing.spacing0){
                VStack(alignment: .leading, spacing: AppSizing.spacing300){
                    Text("All Location")
                        .Subtitle1TextStyle()
                        .foregroundStyle(Color.gray12)
                        .padding(.horizontal, AppSizing.spacing400)
                        .padding(.top, AppSizing.spacing200)
                    
                    VStack(alignment: .leading, spacing: AppSizing.spacing0){
                        Checkbox(isActive: filterBinding(for: "Balikpapan")).showLabel(label: "Balikpapan")
                        Checkbox(isActive: filterBinding(for: "Surabaya")).showLabel(label: "Surabaya")
                        Checkbox(isActive: filterBinding(for: "Jakarta")).showLabel(label: "Jakarta")
                        Checkbox(isActive: filterBinding(for: "Semarang")).showLabel(label: "Semarang")
                        Checkbox(isActive: filterBinding(for: "Bali")).showLabel(label: "Bali")
                        Checkbox(isActive: filterBinding(for: "Blitar")).showLabel(label: "Blitar")
                    }
                    .padding(.horizontal, AppSizing.spacing400)
                }
                Spacer()
                footer2Btn()
            }
            .padding(.top, AppSizing.spacing500)
            
        }
        .presentationDetents([.fraction(0.5)])
        .presentationDragIndicator(.visible)
        .presentationCornerRadius(AppSizing.borderRadius400)
    }
    
    var body: some View {
        VStack(spacing: AppSizing.spacing0){
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: AppSizing.spacing200) {
                    Chip(text: "Filter", isActive: .constant(hasOtherFilters || hasLocationFilters),  action: {
                        syncTemporaryState()
                        showSheetFilter.toggle()
                    })
                    .chipType(type: .filter)
                    Chip(text: "All Location",  isActive: .constant(hasLocationFilters), action: {
                        syncTemporaryState()
                        showSheetLocation.toggle()
                    })
                    .chipType(type: .location)
                    
                    Chip(text: "Upcoming", isActive: .constant(appliedBodyChip == "Upcoming"), action: {
                        selectOutsideBodyChip("Upcoming")
                    })
                    Chip(text: "Just Announced", isActive: .constant(appliedBodyChip == "Just Announced"), action: {
                        selectOutsideBodyChip("Just Announced")
                    })
                }
            }
            .padding(.vertical, AppSizing.spacing300)
            .padding(.horizontal, AppSizing.spacing400)
            .frame(height: 54)
            ScrollView {
                LazyVGrid(columns: columns, spacing: AppSizing.spacing300) {
                    ForEach(viewModel.events) { event in
                        ProductCard(
                            image: event.image,
                            date: event.date,
                            title: event.title,
                            location: event.city,
                            price: event.lowestPrice,
                            haveDiscount: event.discountPercentage > 0,
                            discountPercentage: event.discountPercentage,
                            action: {
                                print("Go to \(event.title) detail")
                                navigationPath.append(event)
                            }
                        )
                    }
                }
                .padding(.horizontal, AppSizing.spacing400)
                .padding(.vertical, AppSizing.spacing400)
            }
        }
        .background(Color.gray2)
        .toolbarBackground(Color.gray3, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                HStack(alignment: .center, spacing: AppSizing.spacing200) {
                    BadgedIcon(iconName: "chevron-left", showBadge: false, action: { navigationPath.removeLast() })
                    
                    Text("Event")
                        .Subtitle1TextStyle()
                        .foregroundColor(.baseWhite)
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                BadgedIcon(iconName: "icon-search", showBadge: false, action: { print("Search tapped") })
            }
        }
        .sheet(isPresented: $showSheetFilter) {
            filterSheet()
        }
        .sheet(isPresented: $showSheetLocation) {
            locationSheet()
        }
        .navigationDestination(for: Event.self, destination: { event in
            EventDetailView(navigationPath: $navigationPath, event: event)
        })
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    @Previewable @State var navigationPath = NavigationPath()
    let viewModel = EventViewModel()
    NavigationStack(path: $navigationPath) {
        EventListView(navigationPath: $navigationPath)
            .environmentObject(viewModel)
    }
}
