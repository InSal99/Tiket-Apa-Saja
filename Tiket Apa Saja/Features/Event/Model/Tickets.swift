//
//  Tickets.swift
//  Tiket Apa Saja
//
//  Created by Yovita Handayiani on 20/07/25.
//

import Foundation

struct Tickets: Identifiable {
    var id = UUID()
    private var Name: String
    private var description: String
    private var price: Int
    private var quota: Int
    
    init(Name: String, description: String, price: Int, quota: Int) {
        self.Name = Name
        self.description = description
        self.price = price
        self.quota = quota
    }
}
