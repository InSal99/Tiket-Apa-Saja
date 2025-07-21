//
//  Product Card.swift
//  Tiket Apa Saja
//
//  Created by Yovita Handayiani on 08/07/25.
//

import SwiftUI

enum ProductCardSize {
    case small
    case large
}

struct ProductCard: View {
    private var image: String = ""
    
    private var date: String = "15 Jul 2025"
    private var title: String = "Musikal Petualangan Sherina"
    private var location: String = "Jakarta"
    
    private var price: Int = 1000000
    private var discountPercentage: Int? = nil
    private var priceBeforeDiscount: Int = 0
    
    private var haveDiscount: Bool = false
    
    private var isLarge: Bool = true
    
    var action: (() -> Void)
    
    init(image: String, date: String, title: String, location: String, price: Int, haveDiscount: Bool, discountPercentage: Int, action: @escaping (() -> Void)) {
        self.image = image
        self.date = date
        self.title = title
        self.location = location
        self.price = price
        self.action = action
        self.haveDiscount = haveDiscount
        self.discountPercentage = discountPercentage
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack(alignment: .leading, spacing: AppSizing.spacing0){
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: isLarge ? 166 : 152, height: isLarge ? 108 : 98)
                VStack(alignment: .leading, spacing: isLarge ? AppSizing.spacing400 : AppSizing.spacing300){
                    VStack(alignment: .leading, spacing: AppSizing.spacing100){
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
                    }.frame(minHeight: 68, alignment: .topLeading)
                    if haveDiscount{
                        Price(price: price).haveDiscount(discountPercentage: discountPercentage ?? 0)
                    }else if !haveDiscount{
                        Price(price: price)
                    }
                }
                .padding(AppSizing.spacing200)
            }
            .frame(width: isLarge ? 166 : 152, height: isLarge ? 238 : 220)
            .background(Color.gray4)
            .clipShape(RoundedRectangle(cornerRadius: AppSizing.borderRadius200))
        }
    }
}

extension ProductCard {
    func size(type: ProductCardSize) -> ProductCard {
        var curr = self
        if type == .large {
            curr.isLarge = true
        } else if type == .small {
            curr.isLarge = false
        }
        return curr
    }
}

#Preview {
    ProductCard(image: "product-musikal-petualangan-sherina", date: "15 Jul 2025", title: "Musikal Petualangan Sherina", location: "Jakarta", price: 1000000, haveDiscount: true, discountPercentage: 10, action: {}).size(type: .small)
}
