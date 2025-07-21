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
                locationFilters.contains(event.city)
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
    
    func getPopularEvents() -> [Event] {
        return events.filter { $0.isPopular }
    }
    
    func getLocalEvents(city: String) -> [Event] {
        return events.filter { $0.city == city}
    }
    
    private func loadEvents() {
        let sampleTickets = [
            Tickets(Name: "Early Bird - Steel", description: "This ticket is non-refundable and special standing area", price: 1150000, quota: 100),
            Tickets(Name: "Early Bird - Gold", description: "This ticket is non-refundable and special standing area", price: 1380000, quota: 100),
            Tickets(Name: "Early Bird - Iridium", description: "This ticket is non-refundable and special standing area", price: 1610000, quota: 100),
            Tickets(Name: "Early Bird - Wood", description: "This ticket is non-refundable and special standing area", price: 805000, quota: 100),
            Tickets(Name: "Early Bird - Copper", description: "This ticket is non-refundable and special standing area", price: 977500, quota: 100),
        ]
        
        let concertTickets = [
            Tickets(Name: "Bronze", description: "General admission standing area", price: 500_000, quota: 200),
            Tickets(Name: "Silver", description: "Reserved seating", price: 750_000, quota: 150),
            Tickets(Name: "Gold", description: "Premium reserved seating", price: 1_000_000, quota: 100),
            Tickets(Name: "VIP", description: "Front row with meet & greet", price: 1_500_000, quota: 50)
        ]
        
        let musicalTickets = [
            Tickets(Name: "Balcony", description: "Upper level seating", price: 400_000, quota: 100),
            Tickets(Name: "Orchestra", description: "Main floor seating", price: 800_000, quota: 80),
            Tickets(Name: "Box", description: "Private box seating", price: 1_200_000, quota: 20)
        ]
        
        let festivalTickets = [
            Tickets(Name: "1-Day Pass", description: "Access for one day", price: 350_000, quota: 300),
            Tickets(Name: "3-Day Pass", description: "Access all festival days", price: 900_000, quota: 200),
            Tickets(Name: "VIP Pass", description: "All days + premium perks", price: 1_250_000, quota: 50)
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
                venue: "Ciputra Artpreneur",
                city: "Jakarta",
                location: "Ciputra Artpreneur, RT.18 / RW.4, South Jakarta City, Jakarta, Indonesia, South Jakarta",
                discountPercentage: 0,
                time: "19:00 - 21:00 WIB",
                descriptionTitle: "Stardew Valley: Festival of Seasons heads to Jakarta due to overwhelming demand",
                description: "SOHO LIVE presents a spectacular collaboration with ConcernedApe, the creator and composer of Stardew Valley, bringing to life a unique concert experience titled Festival of Seasons. This enchanting performance features a carefully curated selection of fans' favorite music from the beloved game, transformed into an exquisite showcase by an 11-piece chamber ensemble.Buy the ticket now at ticket.com and feel the magic of Stardew Valley firsthand!",
                tickets: sampleTickets,
                category: "Concert",
                type: "Concert",
                dateAdded: fiveDaysAgo,
                isBookmarked: false,
                isPopular: false
            ),
            
            Event(
                image: "product-wicked-wonders",
                title: "Wicked Wonders",
                date: "14 Jun 2025",
                venue: "Bali International Convention Centre",
                city: "Bali",
                location: "Kawasan Pariwisata Nusa Dua, BTDC Lot N-3, Benoa, Kuta Selatan, Benoa, South Kuta, Nusa Dua, Bali",
                discountPercentage: 0,
                time: "",
                descriptionTitle: "",
                description: "",
                tickets: musicalTickets,
                category: "Musical",
                type: "Musical",
                dateAdded: threeDaysAgo,
                isBookmarked: false,
                isPopular: false
            ),
            
            Event(
                image: "product-13lack-parade",
                title: "13lack Parade",
                date: "18 Jul 2025",
                venue: "Gedung Kesenian ARYO BLITAR",
                city: "Blitar",
                location: "Komplek Gedung Kesenian Aryo, Jl. Kenari, Plosokerep, Kec. Sananwetan, Kota Blitar, Jawa Timur",
                discountPercentage: 10,
                time: "",
                descriptionTitle: "",
                description: "",
                tickets: concertTickets,
                category: "Concert",
                type: "Concert",
                dateAdded: oneDayAgo,
                isBookmarked: false,
                isPopular: false
            ),
            
            Event(
                image: "product-vierratale",
                title: "Vierratale",
                date: "13 Jun 2025",
                venue: "Eldorado Dome",
                city: "Bandung",
                location: "Jl. Dr. Setiabudi No.438, Gudangkahuripan, Kec. Lembang, Kota Bandung, Jawa Barat",
                discountPercentage: 0,
                time: "",
                descriptionTitle: "",
                description: "",
                tickets: festivalTickets,
                category: "Concert",
                type: "Concert",
                dateAdded: fourDaysAgo,
                isBookmarked: false,
                isPopular: true
            ),
            
            Event(
                image: "product-babyface",
                title: "Babyface",
                date: "12 Jul 2025",
                venue: "Balai Sarbini",
                city: "Jakarta",
                location: "Jl. Jend. Sudirman No.1 No.Kav. 50 1, RT.1/RW.4, Karet Semanggi, Kecamatan Setiabudi, Kota Jakarta Selatan",
                discountPercentage: 0,
                time: "",
                descriptionTitle: "",
                description: "",
                tickets: concertTickets,
                category: "Concert",
                type: "Concert",
                dateAdded: twoDaysAgo,
                isBookmarked: false,
                isPopular: true
            ),
            
            Event(
                image: "product-musikal-petualangan-sherina",
                title: "Musikal Petualangan Sherina",
                date: "15 Jul 2025",
                venue: "Ciputra Artpreneur",
                city: "Jakarta",
                location: "Ciputra Artpreneur, RT.18 / RW.4, South Jakarta City, Jakarta, Indonesia, South Jakarta",
                discountPercentage: 10,
                time: "",
                descriptionTitle: "",
                description: "",
                tickets: musicalTickets,
                category: "Musical",
                type: "Musical",
                dateAdded: today,
                isBookmarked: false,
                isPopular: true
            ),
        ]
        
        self.events = allEvents
        self.filteredEvents = allEvents
    }
}
