//
//  EntertainmentViewModel.swift
//  Tiket Apa Saja
//
//  Created by Intan Saliya Utomo on 07/07/25.
//

import SwiftUI

class EntertainmentViewModel: ObservableObject {
    @Published var entertainments: [Entertainment] = []
    
    init() {
        loadEntertainments()
    }
    
    private func loadEntertainments() {
        entertainments = [
            Entertainment(icon: "banner1", isSubscribed: false),
            Entertainment(icon: "banner1", isSubscribed: true),
            Entertainment(icon: "banner1", isSubscribed: false),
            Entertainment(icon: "banner1", isSubscribed: false)
        ]
    }
    
    func toggleSubscription(for id: UUID) {
        entertainments.indices.forEach { index in
            if entertainments[index].id == id {
                entertainments[index].isSubscribed.toggle()
            }
        }
    }
}
