//
//  EntertainmentsViewModel.swift
//  Tiket Apa Saja
//
//  Created by Yovita Handayiani on 20/07/25.
//
import Foundation

class EntertainmentsViewModel: ObservableObject {
    @Published var entertainments: [Entertainments] = []
    
    init() {
        loadEntertainments()
    }
    
    func count() -> Int {
        return entertainments.count
    }
    
    private func loadEntertainments() {
        entertainments = [
            Entertainments(image: "entertainment1"),
            Entertainments(image: "entertainment2"),
            Entertainments(image: "entertainment3")
        ]
    }
}
