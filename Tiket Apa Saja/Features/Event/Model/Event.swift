//
//  Event.swift
//  Tiket Apa Saja
//
//  Created by Intan Saliya Utomo on 07/07/25.
//

import Foundation

struct Event: Identifiable {
    internal var id = UUID()
    private var title: String
    private var date: String
    private var location: String
    private var lowestPrice: Int
    private var discountPercentage: Int
    private var discountPrice: Int
    
    init(title: String, date: String, location: String, lowestPrice: Int, discountPercentage: Int) {
        self.title = title
        self.date = date
        self.location = location
        self.lowestPrice = lowestPrice
        self.discountPercentage = discountPercentage
        self.discountPrice = lowestPrice-Int(lowestPrice*(discountPercentage/100))
    }
}
