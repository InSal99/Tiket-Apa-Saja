//
//  Tickets.swift
//  Tiket Apa Saja
//
//  Created by Yovita Handayiani on 20/07/25.
//

import Foundation

struct Tickets: Identifiable, Hashable {
    var id = UUID()
    var Name: String
    var description: String
    var price: Int
    var quota: Int
    
    init(Name: String, description: String, price: Int, quota: Int) {
        self.Name = Name
        self.description = description
        self.price = price
        self.quota = quota
    }
    
    func isSoldOut(from quota: Int) -> Bool {
        return quota == 0
    }
}
