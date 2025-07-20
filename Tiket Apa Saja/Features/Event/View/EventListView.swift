//
//  EventListView.swift
//  Tiket Apa Saja
//
//  Created by Intan Saliya Utomo on 07/07/25.
//

import SwiftUI

struct EventListView: View {
    @StateObject private var viewModel = EventViewModel()
    
    var body: some View {
        NavigationStack {
            LazyVStack {
                ForEach(viewModel.events) { event in
                    ProductCard(image: event.image, date: event.date, title: event.title, location: event.location, price: event.lowestPrice)
                }
            }
            .navigationTitle("Events")
        }
    }
}

#Preview {
    EventListView()
}
