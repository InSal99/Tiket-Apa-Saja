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
    
    func getEvent(by id: UUID) -> Event? {
        return events.first { $0.id == id }
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
            Tickets(
                Name: "Early Bird - Steel",
                description: "Non-refundable standing area ticket with basic amenities. Includes access to main event area but no seating. Food and drinks available for purchase.",
                price: 1_150_000,
                quota: 250
            ),
            Tickets(
                Name: "Early Bird - Gold",
                description: "Non-refundable ticket with access to premium standing area closer to stage. Includes complimentary welcome drink and event merchandise.",
                price: 1_380_000,
                quota: 0
            ),
            Tickets(
                Name: "Early Bird - Iridium",
                description: "Non-refundable VIP experience with exclusive standing area, fast-track entry, premium bar access, and dedicated restrooms. Includes limited edition event merchandise.",
                price: 1_610_000,
                quota: 0
            ),
            Tickets(
                Name: "Early Bird - Wood",
                description: "Budget-friendly standing area ticket with basic amenities. Perfect for students and those looking for affordable access to the event.",
                price: 805_000,
                quota: 500
            ),
            Tickets(
                Name: "Early Bird - Copper",
                description: "Mid-range standing ticket with good viewing angles. Includes access to standard food and beverage vendors and general restroom facilities.",
                price: 977_500,
                quota: 300
            )
        ]

        let concertTickets = [
            Tickets(
                Name: "Bronze - General Admission",
                description: "Access to general standing area with basic facilities. First-come, first-served space with multiple viewing screens. Includes access to standard food vendors and restrooms.",
                price: 500_000,
                quota: 1000
            ),
            Tickets(
                Name: "Silver - Reserved Seating",
                description: "Assigned seating in mid-level sections with good viewing angles. Includes dedicated entry lane and access to premium food vendors. Seat cushions available for rent.",
                price: 750_000,
                quota: 500
            ),
            Tickets(
                Name: "Gold - Premium Reserved",
                description: "Premium seating in lower sections with excellent sightlines. Includes fast-track entry, complimentary program, and access to exclusive lounge area with private bars.",
                price: 1_000_000,
                quota: 0
            ),
            Tickets(
                Name: "VIP - Ultimate Experience",
                description: "Best seats in house with meet-and-greet opportunity (subject to artist availability). Includes premium parking, exclusive merchandise, backstage tour, and gourmet catering. Limited availability.",
                price: 1_500_000,
                quota: 50
            ),
            Tickets(
                Name: "Platinum - Backstage Access",
                description: "Front row seats with guaranteed artist meet-and-greet, soundcheck viewing, and after-show party access. Includes all VIP amenities plus personal concierge service.",
                price: 2_500_000,
                quota: 20
            )
        ]

        let musicalTickets = [
            Tickets(
                Name: "Balcony",
                description: "Upper level seating with elevated view of the stage. Perfect for enjoying the full spectacle of the production. Some seats may have partial obstructions - please check seating chart.",
                price: 400_000,
                quota: 300
            ),
            Tickets(
                Name: "Orchestra - Standard",
                description: "Main floor seating with good sightlines to the stage. Center sections offer the best audio experience. Comfortable padded seats with ample legroom.",
                price: 800_000,
                quota: 200
            ),
            Tickets(
                Name: "Orchestra - Premium",
                description: "Prime main floor seating in center sections. Includes program booklet and coat check service. Ideal for the best overall theater experience.",
                price: 1_100_000,
                quota: 150
            ),
            Tickets(
                Name: "Box Seats",
                description: "Private box seating for 4-6 persons with personalized service. Includes complimentary champagne and snacks, private restroom access, and the most exclusive viewing experience.",
                price: 1_200_000,
                quota: 0
            ),
            Tickets(
                Name: "Opening Night Gala",
                description: "Premium orchestra seating for opening night performance. Includes post-show reception with cast members, gourmet catering, and souvenir program.",
                price: 1_800_000,
                quota: 100
            )
        ]

        let festivalTickets = [
            Tickets(
                Name: "1-Day General Pass",
                description: "Access to all general areas for one festival day. Includes entry to all main stages, food markets, and standard facilities. Does not include camping or premium areas.",
                price: 350_000,
                quota: 5000
            ),
            Tickets(
                Name: "3-Day General Pass",
                description: "Full weekend access to general festival areas. Best value for experiencing the complete festival lineup across multiple days. Includes re-entry privileges.",
                price: 900_000,
                quota: 0
            ),
            Tickets(
                Name: "VIP Weekend Pass",
                description: "3-day access with premium amenities: dedicated viewing areas at main stages, fast-lane entry, VIP lounge with complimentary drinks, premium restrooms, and charging stations.",
                price: 1_250_000,
                quota: 500
            ),
            Tickets(
                Name: "Platinum Experience",
                description: "Ultimate festival package with backstage access, artist meet-and-greet opportunities (subject to availability), gourmet catering, and luxury rest areas. Includes all VIP perks plus exclusive merchandise.",
                price: 2_000_000,
                quota: 100
            ),
            Tickets(
                Name: "Family Package (2 Adults + 2 Kids)",
                description: "Special discounted package for families. Includes 3-day general access for two adults and two children (ages 6-12). Children under 6 enter free with adult.",
                price: 1_500_000,
                quota: 200
            )
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
                time: "20:00 - 22:30 WITA",
                descriptionTitle: "Broadway-style musical extravaganza",
                description: "Experience the magic of Wicked Wonders, a Broadway-style musical that will transport you to a world of fantasy and wonder. Featuring an all-star cast, breathtaking sets, and unforgettable musical numbers, this is a theatrical experience you won't want to miss.",
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
                time: "19:30 - 22:00 WIB",
                descriptionTitle: "Alternative rock concert experience",
                description: "13lack Parade brings their unique blend of alternative rock to Blitar for one night only. Featuring special guests and a spectacular light show, this concert promises to be an unforgettable experience for music lovers.",
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
                time: "10:00 - 23:00 WIB",
                descriptionTitle: "Annual music and arts festival",
                description: "Vierratale returns for its 5th year, bringing together the best in music, art, and culture. With multiple stages featuring international and local artists, food trucks, art installations, and more, this is Bandung's premier cultural event.",
                tickets: festivalTickets,
                category: "Festival",
                type: "Festival",
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
                time: "20:00 - 22:00 WIB",
                descriptionTitle: "Legendary R&B artist live in concert",
                description: "Multi-Grammy award winner Babyface brings his timeless hits to Jakarta for a special one-night-only performance. Experience the smooth vocals and masterful songwriting that made him an R&B legend.",
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
                time: "15:00 - 17:30 WIB",
                descriptionTitle: "Beloved Indonesian musical returns",
                description: "The critically acclaimed musical adaptation of the beloved Indonesian film returns with a brand new production. Featuring an all-star cast and updated musical arrangements, this is a must-see for fans of Indonesian musical theater.",
                tickets: musicalTickets,
                category: "Musical",
                type: "Musical",
                dateAdded: today,
                isBookmarked: false,
                isPopular: true
            )
        ]
        
        self.events = allEvents
        self.filteredEvents = allEvents
    }
}
