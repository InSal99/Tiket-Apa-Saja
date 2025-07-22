//
//  Category.swift
//  Tiket Apa Saja
//
//  Created by Intan Saliya Utomo on 20/07/25.
//

import SwiftUI

struct Category: Identifiable, Hashable {
    let id = UUID()
    let icon: String
    let label: String
    
    init(icon: String, label: String,) {
        self.icon = icon
        self.label = label
    }
}
