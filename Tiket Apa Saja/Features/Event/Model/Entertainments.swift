//
//  Entertainments.swift
//  Tiket Apa Saja
//
//  Created by Yovita Handayiani on 20/07/25.
//
import Foundation

struct Entertainments: Identifiable {
    var id = UUID()
    var image: String
    
    init(image: String) {
        self.image = image
    }
}
