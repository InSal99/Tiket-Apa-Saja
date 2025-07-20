//
//  BestDealAttractions.swift
//  Tiket Apa Saja
//
//  Created by Yovita Handayiani on 20/07/25.
//
import Foundation

struct BestDealAttractions: Identifiable {
    var id = UUID()
    private var image: String
    
    init(image: String) {
        self.image = image
    }
}
