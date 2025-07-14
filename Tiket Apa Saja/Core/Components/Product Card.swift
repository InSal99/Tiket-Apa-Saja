//
//  Product Card.swift
//  Tiket Apa Saja
//
//  Created by Yovita Handayiani on 08/07/25.
//

import SwiftUI

struct ProductCard: View {
    var image: String = ""
    
    var date: String = "15 Jul 2025"
    var title: String = "Musikal Petualangan Sherina"
    var location: String = "Jakarta"
    
    var normalPrice: Int = 1000000
    var discountPercentage: Int = 10
    var specialProce: Int = 900000
    
    init(image: String, date: String, title: String, location: String, normalPrice: Int, discountPercentage: Int, specialProce: Int) {
        self.image = image
        self.date = date
        self.title = title
        self.location = location
        self.normalPrice = normalPrice
        self.discountPercentage = discountPercentage
        self.specialProce = specialProce
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
                        .foregroundStyle(AppColor.Gray.gray10)
                    Text(title)
                        .Label2TextStyle()
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(AppColor.Gray.gray10)
                    Text(location)
                        .Caption2TextStyle()
                        .foregroundStyle(AppColor.Gray.gray10)
                }
                
                Price(normalPrice: normalPrice, discountPercentage: discountPercentage,specialProce: specialProce)
            }
            .padding(8)
        }
        .frame(width: 165.5, height: 238)
        .background(.red)
        .clipShape(RoundedRectangle(cornerRadius: 8))

    }
}

#Preview {
    ProductCard(image: "", date: "15 Jul 2025", title: "Musikal Petualangan Sherina", location: "Jakarta", normalPrice: 1000000, discountPercentage: 10, specialProce: 900000)
}
