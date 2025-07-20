//
//  User.swift
//  Tiket Apa Saja
//
//  Created by Yovita Handayiani on 20/07/25.
//
import Foundation

struct User: Identifiable {
    var id = UUID()
    var eventsInLocation: [Event]
    var location: String
}
