//
//  Entertainment.swift
//  Tiket Apa Saja
//
//  Created by Intan Saliya Utomo on 07/07/25.
//

import SwiftUI

struct Entertainment: Identifiable {
    let id = UUID()
    let logo: String
    var isSubscribed: Bool
    
    init(icon: String, isSubscribed: Bool) {
        self.logo = icon
        self.isSubscribed = isSubscribed
    }
}
