//
//  CategoryViewModel.swift
//  Tiket Apa Saja
//
//  Created by Intan Saliya Utomo on 20/07/25.
//

import SwiftUI

class CategoryViewModel: ObservableObject {
    @Published var categories: [Category] = []
    
    init() {
        loadCategories()
    }
    
    private func loadCategories() {
        categories = [
            Category(icon: "cat-entertainment", label: "Event"),
            Category(icon: "cat-attraction", label: "Attraction"),
            Category(icon: "cat-travel", label: "Travel"),
            Category(icon: "cat-education", label: "Entertainment")
        ]
    }
    
    func selectCategory(_ category: Category) {
        print("\(category.label) Selected")
    }
}
