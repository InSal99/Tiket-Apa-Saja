//
//  Product Card.swift
//  Tiket Apa Saja
//
//  Created by Yovita Handayiani on 08/07/25.
//

import SwiftUI

struct ProductCard: View {
    private var image: String = ""
    
    private var date: String = "15 Jul 2025"
    private var title: String = "Musikal Petualangan Sherina"
    private var location: String = "Jakarta"
    
    private var price: Int = 1000000
    private var discountPercentage: Int? = nil
    private var priceBeforeDiscount: Int = 0
    
    private var haveDiscount: Bool = false
    
    init(image: String, date: String, title: String, location: String, price: Int) {
        self.image = image
        self.date = date
        self.title = title
        self.location = location
        self.price = price
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 165.5, height: 108)
            VStack(alignment: .leading, spacing: 16){
                VStack(alignment: .leading, spacing: 4){
                    Text(date)
                        .Caption2TextStyle()
                        .foregroundStyle(Color.gray10)
                    Text(title)
                        .Label2TextStyle()
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .foregroundStyle(Color.gray12)
                    Text(location)
                        .Caption2TextStyle()
                        .foregroundStyle(Color.gray10)
                }.frame(minHeight: 68)
                if haveDiscount{
                    Price(price: price).haveDiscount(discountPercentage: discountPercentage ?? 0)
                }else if !haveDiscount{
                    Price(price: price)
                }
            }
            .padding(8)
        }
        .frame(width: 165.5, height: 238)
        .background(Color.gray4)
        .clipShape(RoundedRectangle(cornerRadius: 8))

    }
}

extension ProductCard {
    func haveDiscount(discountPercentage: Int?) -> ProductCard {
        var curr = self
        curr.discountPercentage = discountPercentage
        curr.haveDiscount = true
        return curr
    }
}

#Preview {
    ProductCard(image: "product-musikal-petualangan-sherina", date: "15 Jul 2025", title: "Musikal Petualangan Sherina", location: "Jakarta", price: 1000000)
        .haveDiscount(discountPercentage: 20)
}
