//
//  BestDealAttractionsViewModel.swift
//  Tiket Apa Saja
//
//  Created by Yovita Handayiani on 20/07/25.
//

import Foundation

class BestDealAttractionsViewModel: ObservableObject {
    @Published var attractions: [BestDealAttractions] = []
    
    init() {
        loadAttractions()
    }
    
    func count() -> Int {
        return attractions.count
    }
    
    private func loadAttractions() {
        attractions = [
            BestDealAttractions(image: "attraction1"),
            BestDealAttractions(image: "attraction2"),
            BestDealAttractions(image: "attraction3")
        ]
    }
}
