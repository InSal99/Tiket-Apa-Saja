//
//  TASEntertainmentCard.swift
//  Tiket Apa Saja
//
//  Created by Intan Saliya Utomo on 20/07/25.
//

import SwiftUI

struct EntertainmentCard: View {
    @State var entertainment: Entertainment
    let onSubscriptionToggle: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .center, spacing: AppSizing.spacing200) {
            Image(entertainment.logo)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .padding(AppSizing.spacing300)
            
            RectButton.textOnly(label: entertainment.isSubscribed ? "Subscribed" : "Subscribe", size: .large, style: .secondary, isDisabled: entertainment.isSubscribed ? true : false, maxWidth: .infinity, action: { entertainment.isSubscribed.toggle() })
        }
        .padding(AppSizing.spacing200)
        .frame(width: 140)
        .background(
            RoundedRectangle(cornerRadius: AppSizing.borderRadius200)
                .fill(.gray4)
        )
    }
}

#Preview {
    EntertainmentCard(entertainment: Entertainment(icon: "banner1", isSubscribed: false), onSubscriptionToggle: {})
}
