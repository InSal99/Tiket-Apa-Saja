//
//  Event.swift
//  Tiket Apa Saja
//
//  Created by Intan Saliya Utomo on 07/07/25.
//

import Foundation

struct Event: Identifiable, Hashable {
    var id = UUID()
    var image: String
    var title: String
    var date: String
    var venue: String
    var city: String
    var location: String
    var lowestPrice: Int
    var discountPercentage: Int
    var discountPrice: Int
    var isBookmarked: Bool
    var isPopular: Bool
    
    var time: String
    private var descriptionTitle: String
    var description: String
    
    var tickets: [Tickets]
    
    var category: String
    var type: String
    var dateAdded: Date

    var eventDate: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.date(from: date) ?? Date()
    }
    
    var isUpcoming: Bool {
        return eventDate > Date()
    }
    
    init(image: String, title: String, date: String, venue: String, city: String, location: String, discountPercentage: Int, time: String, descriptionTitle: String, description: String, tickets: [Tickets], category: String, type: String, dateAdded: Date = Date(), isBookmarked: Bool, isPopular:Bool) {
        self.image = image
        self.title = title
        self.date = date
        self.venue = venue
        self.city = city
        self.location = location
        self.lowestPrice = tickets.min(by: { $0.price < $1.price })?.price ?? 0
        self.discountPercentage = discountPercentage
        self.discountPrice = lowestPrice - Int(Double(lowestPrice)*Double(discountPercentage)/100.0)
        self.time = time
        self.descriptionTitle = descriptionTitle
        self.description = description
        self.tickets = tickets
        self.category = category
        self.type = type
        self.dateAdded = dateAdded
        self.isBookmarked = isBookmarked
        self.isPopular = isPopular
    }
    
    func formatEventDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMMM yyyy"
        return formatter.string(from: date)
    }
}
