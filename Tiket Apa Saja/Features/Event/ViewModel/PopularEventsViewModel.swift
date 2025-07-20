//
//  PopularEventsViewModel.swift
//  Tiket Apa Saja
//
//  Created by Yovita Handayiani on 20/07/25.
//

import Foundation

class PopularEventsViewModel: ObservableObject {
    @Published var popularEvents: [PopularEvents] = []
    
    init() {
        loadPopularEvents()
    }
    
    func count() -> Int {
        return popularEvents.count
    }
    
    private func loadPopularEvents() {
        popularEvents = []
    }
}
