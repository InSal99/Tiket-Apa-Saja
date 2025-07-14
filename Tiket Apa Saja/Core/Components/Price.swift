//
//  Price.swift
//  Tiket Apa Saja
//
//  Created by Yovita Handayiani on 08/07/25.
//

import SwiftUI

struct Price: View {
    var normalPrice: Int = 1000000
    var discountPercentage: Int = 10
    var specialProce: Int = 900000
    
    init(normalPrice: Int, discountPercentage: Int, specialProce: Int) {
        self.normalPrice = normalPrice
        self.discountPercentage = discountPercentage
        self.specialProce = specialProce
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing:0){
            Text("IDR \(specialProce)")
                .Label2TextStyle()
                .foregroundStyle(AppColor.Gray.gray10)
            HStack(spacing: 4){
                Text("IDR \(normalPrice)")
                    .Caption2TextStyle()
                    .strikethrough()
                    .foregroundStyle(AppColor.Gray.gray9)
                Text("\(discountPercentage)%")
                    .Label3TextStyle()
                    .foregroundStyle(AppColor.Orange.orange9)
            }
        }
    }
}

#Preview {
    Price(normalPrice: 1000000, discountPercentage: 10, specialProce: 900000)
}
