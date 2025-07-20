//
//  User.swift
//  Tiket Apa Saja
//
//  Created by Yovita Handayiani on 20/07/25.
//
import Foundation

struct User: Identifiable {
    var id = UUID()
    private var eventsInLocation: [Event]
    private var location: String
}
