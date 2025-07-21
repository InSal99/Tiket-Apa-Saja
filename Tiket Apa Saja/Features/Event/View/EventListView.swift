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
    
    // Temporary state for sheet selections (before apply)
    @State var selectedFilter: Set<String> = []
    
    // Applied state (what actually affects the UI)
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
            TASButton(label: "Reset", action: {
                // Clear both temporary and applied state
                selectedFilter.removeAll()
                appliedFilter.removeAll()
                activeBodyChip = nil
                appliedBodyChip = nil
                
                // Apply the reset filters to viewModel
                viewModel.applyFilters(appliedFilter)
                
                print("Reset - All filters cleared")
                if showSheetFilter == true{
                    showSheetFilter.toggle()
                }else if showSheetLocation == true {
                    showSheetLocation.toggle()
                }
            }, style: .secondary, maxWidth: .infinity)
            
            TASButton(label: "Apply", action: {
                // Apply the temporary selections to the actual filter state
                appliedFilter = selectedFilter
                appliedBodyChip = activeBodyChip
                
                // Apply filters to viewModel
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
            // Deselect current chip
            activeBodyChip = nil
            selectedFilter.remove(chipName)
        } else {
            // Remove all other body chips from selectedFilter
            bodyChips.forEach { selectedFilter.remove($0) }
            
            // Select new chip
            activeBodyChip = chipName
            selectedFilter.insert(chipName)
        }
    }
    
    private func selectOutsideBodyChip(_ chipName: String) {
        let bodyChips = ["Upcoming", "Just Announced"]
        
        if appliedBodyChip == chipName {
            // Deselect current chip
            appliedBodyChip = nil
            appliedFilter.remove(chipName)
            // Also update temporary state
            activeBodyChip = nil
            selectedFilter.remove(chipName)
        } else {
            // Remove all other body chips from appliedFilter
            bodyChips.forEach {
                appliedFilter.remove($0)
                selectedFilter.remove($0)
            }
            
            // Select new chip
            appliedBodyChip = chipName
            appliedFilter.insert(chipName)
            // Also update temporary state
            activeBodyChip = chipName
            selectedFilter.insert(chipName)
        }
        
        // Apply filters immediately when chip is selected outside
        viewModel.applyFilters(appliedFilter)
    }
    
    // Function to sync temporary state with applied state when sheets open
    private func syncTemporaryState() {
        selectedFilter = appliedFilter
        activeBodyChip = appliedBodyChip
    }

    
    var body: some View {
  //      NavigationStack {
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
                                location: event.location,
                                price: event.lowestPrice,
                                haveDiscount: (event.discountPercentage > 0 ? true : false),
                                discountPercentage: event.discountPercentage,
                                action: {}
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
                        Button {
                            navigationPath.removeLast()
                        } label: {
                            Image("chevron-left")
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 24, height: 24)
                                .foregroundColor(.gray10)
                        }

                        Text("Event")
                            .Subtitle1TextStyle()
                            .foregroundColor(.baseWhite)
                    }
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        print("Search tapped")
                    }) {
                        Image("icon-search")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 24, height: 24)
                            .aspectRatio(1, contentMode: .fill)
                            .foregroundColor(.gray10)
                    }
                }
            }
//        }
        .sheet(isPresented: $showSheetFilter) {
            ZStack {
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
        .sheet(isPresented: $showSheetLocation) {
            ZStack {
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
        .navigationBarBackButtonHidden(true)
    }
}

//struct EventListView: View {
//    @StateObject private var viewModel = EventViewModel()
//    @State var showSheetFilter: Bool = false
//    @State var showSheetLocation: Bool = false
//    @State var isSelectedCheckbox: Bool = false
//    @State var selectedFilter: Set<String> = []
//    
//    @State private var activeBodyChip: String? = nil
//    
//    private var hasLocationFilters: Bool {
//        let locationFilters = ["Balikpapan", "Surabaya", "Jakarta", "Semarang", "Bali", "Blitar"]
//        return locationFilters.contains { selectedFilter.contains($0) }
//    }
//
//    private var hasOtherFilters: Bool {
//        let categoryFilters = ["Musical", "Concert", "Orchestra"]
//        let typeFilters = ["Musical", "Concert", "Orchestra"]
//        let sortFilters = ["Upcoming", "Just Announced", "Lowest Price", "Highest Price"]
//        
//        return categoryFilters.contains { selectedFilter.contains($0) } ||
//               typeFilters.contains { selectedFilter.contains($0) } ||
//               sortFilters.contains { selectedFilter.contains($0) }
//    }
//    
//    private let columns = [
//        GridItem(.flexible()),
//        GridItem(.flexible())
//    ]
//    
//    fileprivate func footer2Btn() -> some View {
//        return HStack(spacing: 8){
//            TASButton
//                .textOnly(label: "Reset", size: .large, style: .secondary, isDisabled: false, action: {
//                    selectedFilter.removeAll()
//                    activeBodyChip = nil
//                    print("Reset - Selected locations: \(selectedFilter)")
//                    if showSheetFilter == true{
//                        showSheetFilter.toggle()
//                    }else if showSheetLocation == true {
//                        showSheetLocation.toggle()
//                    }
//                })
//            
//            TASButton
//                .textOnly(label: "Apply", size: .large, style: .primary, isDisabled: false, action: {
//                    print("Apply - Selected locations: \(selectedFilter)")
//                    if showSheetFilter == true{
//                        showSheetFilter.toggle()
//                    }else if showSheetLocation == true {
//                        showSheetLocation.toggle()
//                    }
//                })
//        }
//        .padding(.horizontal, 16)
//        .padding(.top, 16)
//        .padding(.bottom, 12)
//    }
//    
//    private func filterBinding(for location: String) -> Binding<Bool> {
//        Binding(
//            get: { selectedFilter.contains(location) },
//            set: { _ in
//                if selectedFilter.contains(location) {
//                    selectedFilter.remove(location)
//                } else {
//                    selectedFilter.insert(location)
//                }
//            }
//        )
//    }
//    
//    private func selectBodyChip(_ chipName: String) {
//        let bodyChips = ["Upcoming", "Just Announced", "Lowest Price", "Highest Price"]
//        
//        if activeBodyChip == chipName {
//            // Deselect current chip
//            activeBodyChip = nil
//            selectedFilter.remove(chipName)
//        } else {
//            // Remove all other body chips from selectedLocations
//            bodyChips.forEach { selectedFilter.remove($0) }
//            
//            // Select new chip
//            activeBodyChip = chipName
//            selectedFilter.insert(chipName)
//        }
//    }
//
//    
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 0){
//                ScrollView(.horizontal, showsIndicators: false) {
//                    LazyHStack(spacing: AppSizing.spacing200) {
//                        Chip(text: "Filter", isActive: .constant(hasOtherFilters || hasLocationFilters),  action: {
//                            showSheetFilter.toggle()
//                        })
//                        .chipType(type: .filter)
//                        Chip(text: "Location",  isActive: .constant(hasLocationFilters), action: {
//                            showSheetLocation.toggle()
//                        })
//                        .chipType(type: .location)
//                        
//                        Chip(text: "Upcoming", isActive: .constant(activeBodyChip == "Upcoming"), action: {
//                            selectBodyChip("Upcoming")
//                        })
//                        Chip(text: "Just Announced", isActive: .constant(activeBodyChip == "Just Announced"), action: {
//                            selectBodyChip("Just Announced")
//                        })
//                    }
//                }
//                .padding(.vertical, 12)
//                .padding(.horizontal, 16)
//                .frame(height: 54)
//                ScrollView {
//                    LazyVGrid(columns: columns, spacing: 16) {
//                        ForEach(viewModel.events) { event in
//                            ProductCard(
//                                image: event.image,
//                                date: event.date,
//                                title: event.title,
//                                location: event.location,
//                                price: event.lowestPrice,
//                                haveDiscount: (event.discountPercentage > 0 ? true : false),
//                                discountPercentage: event.discountPercentage,
//                                action: {}
//                            )
//                        }
//                    }
//                    .padding(.horizontal, 16)
//                }
//            }
//            .background(Color.gray2)
//            .toolbarBackground(Color.gray3, for: .navigationBar)
//            .toolbarBackground(.visible, for: .navigationBar)
//            .toolbar {
//                ToolbarItemGroup(placement: .navigationBarLeading) {
//                    Text("Event")
//                        .Subtitle1TextStyle()
//                        .foregroundColor(.white)
//                }
//                
//                ToolbarItemGroup(placement: .navigationBarTrailing) {
//                    Button(action: {
//                        print("Search tapped")
//                    }) {
//                        Image("icon-search")
//                            .resizable()
//                            .renderingMode(.template)
//                            .frame(width: 24, height: 24)
//                            .aspectRatio(1, contentMode: .fill)
//                            .foregroundColor(Color.gray10)
//                    }
//                }
//            }
//        }
//        .sheet(isPresented: $showSheetFilter) {
//            ZStack {
//                Color.gray3.ignoresSafeArea()
//                
//                VStack(spacing: 12){
//                    HStack(spacing: 0){
//                        Text("Filter")
//                            .Subtitle1TextStyle()
//                            .foregroundStyle(Color.gray12)
//                            .padding(.horizontal, 16)
//                            .padding(.vertical, 8)
//                        Spacer()
//                    }
//                    
//                    ScrollView(.vertical, showsIndicators: false){
//                        VStack(alignment: .leading, spacing: 24){
//                            VStack(alignment: .leading, spacing: 12){
//                                Text("Sort By")
//                                    .Subtitle2TextStyle()
//                                    .foregroundStyle(Color.gray12)
//                                
//                                VStack(alignment: .leading, spacing: 8){
//                                    HStack(alignment: .top, spacing: 8){
//                                        Chip(text: "Upcoming", isActive: .constant(activeBodyChip == "Upcoming"), action: {
//                                            selectBodyChip("Upcoming")
//                                        })
//                                        Chip(text: "Just Announced", isActive: .constant(activeBodyChip == "Just Announced"), action: {
//                                            selectBodyChip("Just Announced")
//                                        })
//                                    }
//                                    HStack(alignment: .top, spacing: 8){
//                                        Chip(text: "Lowest Price", isActive: .constant(activeBodyChip == "Lowest Price"), action: {
//                                            selectBodyChip("Lowest Price")
//                                        })
//                                        Chip(text: "Highest Price", isActive: .constant(activeBodyChip == "Highest Price"), action: {
//                                            selectBodyChip("Highest Price")
//                                        })
//                                    }
//                                }
//                            }.padding(.horizontal, 16)
//                            
//                            VStack(alignment: .leading, spacing: 12){
//                                Text("Location")
//                                    .Subtitle2TextStyle()
//                                    .foregroundStyle(Color.gray12)
//                                
//                                VStack(alignment: .leading, spacing: 0){
//                                    Checkbox(isActive: filterBinding(for: "Balikpapan")).showLabel(label: "Balikpapan")
//                                    Checkbox(isActive: filterBinding(for: "Surabaya")).showLabel(label: "Surabaya")
//                                    Checkbox(isActive: filterBinding(for: "Jakarta")).showLabel(label: "Jakarta")
//                                    Checkbox(isActive: filterBinding(for: "Semarang")).showLabel(label: "Semarang")
//                                    Checkbox(isActive: filterBinding(for: "Bali")).showLabel(label: "Bali")
//                                    Checkbox(isActive: filterBinding(for: "Blitar")).showLabel(label: "Blitar")
//                                }
//                            }.padding(.horizontal, 16)
//                            
//                            VStack(alignment: .leading, spacing: 12){
//                                Text("Category")
//                                    .Subtitle2TextStyle()
//                                    .foregroundStyle(Color.gray12)
//                                
//                                VStack(alignment: .leading, spacing: 0){
//                                    Checkbox(isActive: filterBinding(for: "Musical")).showLabel(label: "Musical")
//                                    Checkbox(isActive: filterBinding(for: "Concert")).showLabel(label: "Concert")
//                                    Checkbox(isActive: filterBinding(for: "Orchestra")).showLabel(label: "Orchestra")
//                                }
//                            }.padding(.horizontal, 16)
//                            
//                            VStack(alignment: .leading, spacing: 12){
//                                Text("Type")
//                                    .Subtitle2TextStyle()
//                                    .foregroundStyle(Color.gray12)
//                                
//                                VStack(alignment: .leading, spacing: 0){
//                                    Checkbox(isActive: filterBinding(for: "Musical")).showLabel(label: "Musical")
//                                    Checkbox(isActive: filterBinding(for: "Concert")).showLabel(label: "Concert")
//                                    Checkbox(isActive: filterBinding(for: "Orchestra")).showLabel(label: "Orchestra")
//                                }
//                            }.padding(.horizontal, 16)
//                        }
//                    }
//                    footer2Btn()
//                }
//                .padding(.top, 20)
//            }
//            .presentationDetents([.large])
//            .presentationDragIndicator(.visible)
//            .presentationCornerRadius(16)
//        }
//        .sheet(isPresented: $showSheetLocation) {
//            ZStack {
//                Color.gray3.ignoresSafeArea()
//                
//                VStack(spacing: 0){
//                    VStack(alignment: .leading, spacing: 12){
//                        Text("All Location")
//                            .Subtitle1TextStyle()
//                            .foregroundStyle(Color.gray12)
//                            .padding(.horizontal, 16)
//                            .padding(.top, 8)
//                        
//                        VStack(alignment: .leading, spacing: 0){
//                            Checkbox(isActive: filterBinding(for: "Balikpapan")).showLabel(label: "Balikpapan")
//                            Checkbox(isActive: filterBinding(for: "Surabaya")).showLabel(label: "Surabaya")
//                            Checkbox(isActive: filterBinding(for: "Jakarta")).showLabel(label: "Jakarta")
//                            Checkbox(isActive: filterBinding(for: "Semarang")).showLabel(label: "Semarang")
//                            Checkbox(isActive: filterBinding(for: "Bali")).showLabel(label: "Bali")
//                            Checkbox(isActive: filterBinding(for: "Blitar")).showLabel(label: "Blitar")
//                        }
//                        .padding(.horizontal, 16)
//                    }
//                    Spacer()
//                    footer2Btn()
//                }
//                .padding(.top, 20)
//                
//            }
//            .presentationDetents([.fraction(0.5)])
//            .presentationDragIndicator(.visible)
//            .presentationCornerRadius(16)
//        }
//    }
//}

#Preview {
    @Previewable @State var navigationPath = NavigationPath()
    let viewModel = EventViewModel()
    NavigationStack(path: $navigationPath) {
        EventListView(navigationPath: $navigationPath)
            .environmentObject(viewModel)
    }
}
