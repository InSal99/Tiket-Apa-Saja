//
//  TicketCard.swift
//  edts-assignment-tiket-apa-saja
//
//  Created by Fauzan Sukmapratama on 10/07/25.
//

import SwiftUI

struct TicketCard: View {
    let ticketType: String
    let description: String
    let price: String
    let isSoldOut: Bool
    let detailAction: () -> Void
    let bookAction: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                TicketInfo(
                    isSoldOut: isSoldOut,
                    ticketType: ticketType,
                    description: description,
                    detailAction: detailAction
                )
                
                Divider()
                    .overlay(Color.gray6)
                
                TicketFooter(
                    price: price,
                    isSoldOut: isSoldOut,
                    bookAction: bookAction
                )
            }
            .background(Color.gray4)
            
            if isSoldOut {
                TicketSold()
                    .background(Color.gray6)
            }
        }
        .cornerRadius(8)
    }
}

struct TicketInfo: View {
    let isSoldOut: Bool
    let ticketType: String
    let description: String
    let detailAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(ticketType)
                .font(.Subtitle2())
                .foregroundColor(isSoldOut ? Color.gray8 : Color.gray12)
                .lineLimit(1)
            
            Text(description)
                .font(.Caption1())
                .foregroundColor(isSoldOut ? Color.gray8 : Color.gray10)
                .lineLimit(1)
            
            Button(action: detailAction) {
                Text("See Detail")
                    .font(.Label2())
                    .foregroundColor(Color.orange9)
            }
        }
        .padding(.horizontal, 12)
        .padding(.top, 12)
        .padding(.bottom, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct TicketFooter: View {
    let price: String
    let isSoldOut: Bool
    let bookAction: () -> Void
    
    var body: some View {
        HStack {
            Text(price)
                .font(.Subtitle2())
                .foregroundColor(isSoldOut ? Color.gray8 : Color.gray12)
                .lineLimit(1)
            
            Spacer()
            
            TASButton.textOnly(label: "Buy Now", size: .small, style: .primary, isDisabled: isSoldOut, action: bookAction)
        }
        .padding(.horizontal, 12)
        .padding(.top, 8)
        .padding(.bottom, 12)
    }
}

struct TicketSold: View {
    var body: some View {
        Text("Sold Out")
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.Label2())
            .foregroundColor(Color.gray11)
            .lineLimit(1)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
    }
}

struct TicketCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TicketCard(
                ticketType: "Early Bird - Steel",
                description: "This ticket is non-refundable and special standing area",
                price: "IDR 1.150.000",
                isSoldOut: false,
                detailAction: { print("Show all tapped") },
                bookAction: { print("Book tapped") }
            )
            .previewDisplayName("Available Ticket")
            
            TicketCard(
                ticketType: "VIP - Gold",
                description: "Exclusive access with premium benefits",
                price: "IDR 2.500.000",
                isSoldOut: true,
                detailAction: { print("Show all tapped") },
                bookAction: { print("Book tapped") }
            )
            .previewDisplayName("Sold Out Ticket")
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
