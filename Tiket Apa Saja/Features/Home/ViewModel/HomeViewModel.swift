//
//  HomeViewModel.swift
//  Tiket Apa Saja
//
//  Created by Intan Saliya Utomo on 07/07/25.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    let categoryViewModel = CategoryViewModel()
    let entertainmentViewModel = EntertainmentViewModel()
    let eventViewModel = EventViewModel()
    let attractionViewModel = AttractionViewModel()
    
    @Published var navigateToCategory: Category? = nil
    @Published var searchText: String = ""
    
    let locationName: String = "Jakarta"
    let promos: [String] = ["banner1", "banner1", "banner1", "banner1", "banner1"]
    
    func handleCategorySelection(_ category: Category) {
        categoryViewModel.selectCategory(category)
        navigateToCategory = category
    }
    
    func handleSubscriptionToggle(_ id: UUID) {
        entertainmentViewModel.toggleSubscription(for: id)
    }
    
    func handleLocalEvents() -> [Event] {
        eventViewModel.getLocalEvents(city: locationName)
    }
}
