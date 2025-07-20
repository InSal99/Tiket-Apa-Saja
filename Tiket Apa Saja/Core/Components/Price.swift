//
//  Price.swift
//  Tiket Apa Saja
//
//  Created by Yovita Handayiani on 08/07/25.
//

import SwiftUI

struct Price: View {
    private var price: Int = 1000000
    private var discountPercentage: Int = 10
    private var priceBeforeDiscount: Int = 0
    private var haveDiscount: Bool = false
    
    init(price: Int) {
        self.price = price
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing:0){
            Text("IDR \(price)")
                .Label2TextStyle()
                .foregroundStyle(Color.gray12)
            if haveDiscount{
                HStack(spacing: 4){
                    Text("IDR \(priceBeforeDiscount)")
                        .Caption2TextStyle()
                        .strikethrough()
                        .foregroundStyle(Color.gray9)
                    Text("\(discountPercentage)%")
                        .Label3TextStyle()
                        .foregroundStyle(Color.orange9)
                }
            }
        }
        .frame(minHeight: 30, alignment: .bottomLeading)
    }
}

extension Price {
    func haveDiscount(discountPercentage: Int) -> Price {
        var curr = self
        curr.priceBeforeDiscount = curr.price
        curr.discountPercentage = discountPercentage
        curr.price = curr.price - Int(Double(curr.price)*Double(discountPercentage)/100.0)
        curr.haveDiscount = true
        return curr
    }
}


#Preview {
    Price(price: 1000000).haveDiscount(discountPercentage: 10)
}
