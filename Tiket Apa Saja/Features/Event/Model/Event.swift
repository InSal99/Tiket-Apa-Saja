//
//  Event.swift
//  Tiket Apa Saja
//
//  Created by Intan Saliya Utomo on 07/07/25.
//

import Foundation

struct Event: Identifiable {
    var id = UUID()
    private var image: String
    private var title: String
    private var date: String
    private var location: String
    private var lowestPrice: Int
    private var discountPercentage: Int
    private var discountPrice: Int
    
    private var time: String
    private var descriptionTitle: String
    private var description: String
    
    private var tickets: [Tickets]
    
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
