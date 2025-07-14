//
//  EventViewModel.swift
//  Tiket Apa Saja
//
//  Created by Intan Saliya Utomo on 07/07/25.
//

import SwiftUI

class EventViewModel: ObservableObject {
    @Published var events: [Event] = []
    
    init() {
        loadEvents()
    }
    
    public func count() -> Int{
        return self.events.count
    }
    
    private func loadEvents() {
        events = [
            Event(title: "Stardew Valley: Festival of Seasons", date: "25 Jul 2025", location: "Jakarta", lowestPrice: 1150000, discountPercentage: 0),
            
            Event(title: "Stardew Valley: Festival of Seasons", date: "25 Jul 2025", location: "Jakarta", lowestPrice: 1150000, discountPercentage: 0)3,
            ]
    }
}
