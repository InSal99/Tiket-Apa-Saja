//
//  Event.swift
//  Tiket Apa Saja
//
//  Created by Intan Saliya Utomo on 07/07/25.
//

import Foundation

struct Event: Identifiable {
    var id = UUID()
    var image: String
    var title: String
    var date: String
    var location: String
    var lowestPrice: Int
    var discountPercentage: Int
    var discountPrice: Int
    
    var time: String
    private var descriptionTitle: String
    var description: String
    
    var tickets: [Tickets]
    
    init(image: String, title: String, date: String, location: String, lowestPrice: Int, discountPercentage: Int, time: String, descriptionTitle: String, description: String, tickets: [Tickets]) {
        self.image = image
        self.title = title
        self.date = date
        self.location = location
        self.lowestPrice = lowestPrice
        self.discountPercentage = discountPercentage
        self.discountPrice = lowestPrice - Int(Double(lowestPrice)*Double(discountPercentage)/100.0)
        self.time = time
        self.descriptionTitle = descriptionTitle
        self.description = description
        self.tickets = tickets
    }
}
