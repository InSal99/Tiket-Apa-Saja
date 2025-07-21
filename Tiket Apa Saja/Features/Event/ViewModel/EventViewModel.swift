//
//  EventViewModel.swift
//  Tiket Apa Saja
//
//  Created by Intan Saliya Utomo on 07/07/25.
//

import SwiftUI

class EventViewModel: ObservableObject {
    @Published var events: [Event] = []
    @Published var filteredEvents: [Event] = []
    
    private var allEvents: [Event] = []
    
    init() {
        loadEvents()
    }
    
    public func count() -> Int {
        return self.filteredEvents.count
    }
    
    func applyFilters(_ filters: Set<String>) {
        var filtered = allEvents
        
        let categoryFilters = filters.intersection(["Musical", "Concert", "Orchestra"])
        let locationFilters = filters.intersection(["Balikpapan", "Surabaya", "Jakarta", "Semarang", "Bali", "Blitar"])
        let sortFilters = filters.intersection(["Upcoming", "Just Announced", "Lowest Price", "Highest Price"])
        
        if !categoryFilters.isEmpty {
            filtered = filtered.filter { event in
                categoryFilters.contains(event.category)
            }
        }
        
        if !locationFilters.isEmpty {
            filtered = filtered.filter { event in
                locationFilters.contains(event.location)
            }
        }
        
        if sortFilters.contains("Upcoming") {
            filtered = filtered.filter { $0.isUpcoming }
        }
        
        if sortFilters.contains("Just Announced") {
            // Sort by dateAdded (newest first)
            filtered = filtered.sorted { $0.dateAdded > $1.dateAdded }
        } else if sortFilters.contains("Lowest Price") {
            // Sort by lowest price first
            filtered = filtered.sorted { $0.lowestPrice < $1.lowestPrice }
        } else if sortFilters.contains("Highest Price") {
            // Sort by highest price first
            filtered = filtered.sorted { $0.lowestPrice > $1.lowestPrice }
        } else if sortFilters.contains("Upcoming") {
            // Sort upcoming events by date (soonest first)
            filtered = filtered.sorted { $0.eventDate < $1.eventDate }
        }
        
        self.filteredEvents = filtered
        self.events = filtered
    }
    
    private func loadEvents() {
        let sampleTickets = [
            Tickets(Name: "Early Bird - Steel", description: "This ticket is non-refundable and special standing area", price: 1150000, quota: 100),
            Tickets(Name: "Early Bird - Gold", description: "This ticket is non-refundable and special standing area", price: 1380000, quota: 100),
            Tickets(Name: "Early Bird - Iridium", description: "This ticket is non-refundable and special standing area", price: 1610000, quota: 100),
            Tickets(Name: "Early Bird - Wood", description: "This ticket is non-refundable and special standing area", price: 805000, quota: 100),
            Tickets(Name: "Early Bird - Copper", description: "This ticket is non-refundable and special standing area", price: 977500, quota: 100),
        ]
        
        let calendar = Calendar.current
        let today = Date()
        let oneDayAgo = calendar.date(byAdding: .day, value: -1, to: today) ?? today
        let twoDaysAgo = calendar.date(byAdding: .day, value: -2, to: today) ?? today
        let threeDaysAgo = calendar.date(byAdding: .day, value: -3, to: today) ?? today
        let fourDaysAgo = calendar.date(byAdding: .day, value: -4, to: today) ?? today
        let fiveDaysAgo = calendar.date(byAdding: .day, value: -5, to: today) ?? today
        
        allEvents = [
            Event(
                image: "product-stardew-valley-festival-of-seasons",
                title: "Stardew Valley: Festival of Seasons",
                date: "25 Jul 2025",
                location: "Jakarta",
                lowestPrice: 1150000,
                discountPercentage: 0,
                time: "19:00 - 21:00 WIB",
                descriptionTitle: "Stardew Valley: Festival of Seasons heads to Jakarta due to overwhelming demand",
                description: "SOHO LIVE presents a spectacular collaboration with ConcernedApe, the creator and composer of Stardew Valley, bringing to life a unique concert experience titled Festival of Seasons. This enchanting performance features a carefully curated selection of fans' favorite music from the beloved game, transformed into an exquisite showcase by an 11-piece chamber ensemble.Buy the ticket now at ticket.com and feel the magic of Stardew Valley firsthand!",
                tickets: sampleTickets,
                category: "Concert",
                type: "Concert",
                dateAdded: fiveDaysAgo
            ),
            
            Event(
                image: "product-wicked-wonders",
                title: "Wicked Wonders",
                date: "14 Jun 2025",
                location: "Bali",
                lowestPrice: 250000,
                discountPercentage: 0,
                time: "",
                descriptionTitle: "",
                description: "",
                tickets: [],
                category: "Musical",
                type: "Musical",
                dateAdded: threeDaysAgo
            ),
            
            Event(
                image: "product-13lack-parade",
                title: "13lack Parade",
                date: "18 Jul 2025",
                location: "Blitar",
                lowestPrice: 100000,
                discountPercentage: 10,
                time: "",
                descriptionTitle: "",
                description: "",
                tickets: [],
                category: "Concert",
                type: "Concert",
                dateAdded: oneDayAgo
            ),
            
            Event(
                image: "product-vierratale",
                title: "Vierratale",
                date: "13 Jun 2025",
                location: "Bandung",
                lowestPrice: 115000,
                discountPercentage: 0,
                time: "",
                descriptionTitle: "",
                description: "",
                tickets: [],
                category: "Concert",
                type: "Concert",
                dateAdded: fourDaysAgo
            ),
            
            Event(
                image: "product-babyface",
                title: "Babyface",
                date: "12 Jul 2025",
                location: "Jakarta",
                lowestPrice: 1500000,
                discountPercentage: 0,
                time: "",
                descriptionTitle: "",
                description: "",
                tickets: [],
                category: "Concert",
                type: "Concert",
                dateAdded: twoDaysAgo
            ),
            
            Event(
                image: "product-musikal-petualangan-sherina",
                title: "Musikal Petualangan Sherina",
                date: "15 Jul 2025",
                location: "Jakarta",
                lowestPrice: 1000000,
                discountPercentage: 10,
                time: "",
                descriptionTitle: "",
                description: "",
                tickets: [],
                category: "Musical",
                type: "Musical",
                dateAdded: today
            ),
        ]
        
        self.events = allEvents
        self.filteredEvents = allEvents
    }
}

//class EventViewModel: ObservableObject {
//    @Published var events: [Event] = []
//    
//    init() {
//        loadEvents()
//    }
//    
//    public func count() -> Int{
//        return self.events.count
//    }
//    
//    private func loadEvents() {
//        let sampleTickets = [
//            Tickets(Name: "Early Bird - Steel", description: "This ticket is non-refundable and special standing area", price: 1150000, quota: 100),
//            Tickets(Name: "Early Bird - Gold", description: "This ticket is non-refundable and special standing area", price: 1380000, quota: 100),
//            Tickets(Name: "Early Bird - Iridium", description: "This ticket is non-refundable and special standing area", price: 1610000, quota: 100),
//            Tickets(Name: "Early Bird - Wood", description: "This ticket is non-refundable and special standing area", price: 805000, quota: 100),
//            Tickets(Name: "Early Bird - Copper", description: "This ticket is non-refundable and special standing area", price: 977500, quota: 100),
//        ]
//        
//        events = [
//            Event(image: "product-stardew-valley-festival-of-seasons", title: "Stardew Valley: Festival of Seasons", date: "25 Jul 2025", location: "Jakarta", lowestPrice: 1150000, discountPercentage: 0, time: "19:00 - 21:00 WIB", descriptionTitle: "Stardew Valley: Festival of Seasons heads to Jakarta due to overwhelming demand", description: "SOHO LIVE presents a spectacular collaboration with ConcernedApe, the creator and composer of Stardew Valley, bringing to life a unique concert experience titled Festival of Seasons. This enchanting performance features a carefully curated selection of fans’ favorite music from the beloved game, transformed into an exquisite showcase by an 11-piece chamber ensemble.Buy the ticket now at ticket.com and feel the magic of Stardew Valley firsthand!", tickets: sampleTickets),
//            
//            Event(image: "product-wicked-wonders", title: "Wicked Wonders", date: "14 Jun 2025", location: "Bali", lowestPrice: 250000, discountPercentage: 0, time: "", descriptionTitle: "", description: "", tickets: []),
//            
//            Event(image: "product-13lack-parade", title: "13lack Parade", date: "18 Jul - 20 Jul 2025", location: "Blitar", lowestPrice: 100000, discountPercentage: 10, time: "", descriptionTitle: "", description: "", tickets: []),
//            
//            Event(image: "product-vierratale", title: "Vierratale", date: "13 Jun 2025", location: "Bandung", lowestPrice: 115000, discountPercentage: 0, time: "", descriptionTitle: "", description: "", tickets: []),
//            
//            Event(image: "product-babyface", title: "Babyface", date: "12 Jul 2025", location: "Jakarta", lowestPrice: 1500000, discountPercentage: 0, time: "", descriptionTitle: "", description: "", tickets: []),
//            
//            Event(image: "product-musikal-petualangan-sherina", title: "Musikal Petualangan Sherina", date: "15 Jul 2025", location: "Jakarta", lowestPrice: 1000000, discountPercentage: 10, time: "", descriptionTitle: "", description: "", tickets: []),
//        ]
//    }
//}
