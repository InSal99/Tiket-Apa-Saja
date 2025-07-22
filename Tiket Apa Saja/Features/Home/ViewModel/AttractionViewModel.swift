//
//  BestDealAttractionsViewModel.swift
//  Tiket Apa Saja
//
//  Created by Yovita Handayiani on 20/07/25.
//

import Foundation

class AttractionViewModel: ObservableObject {
    @Published var attractions: [Attraction] = []
    
    init() {
        loadAttractions()
    }
    
    func count() -> Int {
        return attractions.count
    }
    
    private func loadAttractions() {
        attractions = [
            Attraction(image: "attraction1"),
            Attraction(image: "attraction2")
        ]
    }
}
