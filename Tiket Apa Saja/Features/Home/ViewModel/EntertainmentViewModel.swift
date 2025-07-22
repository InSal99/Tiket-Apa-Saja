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
            Entertainment(icon: "entertainment1", isSubscribed: false),
            Entertainment(icon: "entertainment2", isSubscribed: true),
            Entertainment(icon: "entertainment3", isSubscribed: false),
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
