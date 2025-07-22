//
//  TicketCard.swift
//  edts-assignment-tiket-apa-saja
//
//  Created by Fauzan Sukmapratama on 10/07/25.
//

import SwiftUI

struct TicketCard: View {
    let ticket: Tickets
    let detailAction: () -> Void
    let bookAction: () -> Void
    
    var body: some View {
        VStack(spacing: AppSizing.spacing0) {
            VStack(spacing: AppSizing.spacing0) {
                TicketInfo(
                    isSoldOut: ticket.isSoldOut(from: ticket.quota),
                    ticketType: ticket.Name,
                    description: ticket.description,
                    detailAction: detailAction
                )
                
                Divider()
                    .background(.gray6)
                
                TicketFooter(
                    price: ticket.price,
                    isSoldOut: ticket.isSoldOut(from: ticket.quota),
                    bookAction: bookAction
                )
            }
            .background(.gray4)
            
            if ticket.isSoldOut(from: ticket.quota) {
                TicketSold()
                    .background(.gray6)
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
        VStack(alignment: .leading, spacing: AppSizing.spacing200) {
            Text(ticketType)
                .font(.Subtitle2())
                .foregroundColor(isSoldOut ? Color.gray8 : Color.gray12)
                .lineLimit(1)
            
            Text(description)
                .font(.Caption1())
                .foregroundColor(isSoldOut ? Color.gray8 : Color.gray10)
                .lineLimit(1)
            
            RectButton.textOnly(label: "See Detail", size: .small, style: .tertiary(), isDisabled: false, action: detailAction)
        }
        .padding(.horizontal, AppSizing.spacing300)
        .padding(.top, AppSizing.spacing300)
        .padding(.bottom, AppSizing.spacing400)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct TicketFooter: View {
    let price: Int
    let isSoldOut: Bool
    let bookAction: () -> Void
    
    var body: some View {
        HStack {
            Text("IDR " + price.formatted())
                .Subtitle2TextStyle()
                .foregroundColor(isSoldOut ? Color.gray8 : Color.gray12)
                .lineLimit(1)
            
            Spacer()
            
            RectButton.textOnly(label: "Book", size: .small, style: .primary, isDisabled: isSoldOut, action: bookAction)
        }
        .padding(.horizontal, AppSizing.spacing300)
        .padding(.top, AppSizing.spacing200)
        .padding(.bottom, AppSizing.spacing300)
    }
}

struct TicketSold: View {
    var body: some View {
        Text("Sold Out")
            .Label2TextStyle()
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.gray11)
            .lineLimit(1)
            .padding(.horizontal, AppSizing.spacing300)
            .padding(.vertical, AppSizing.spacing200)
    }
}

#Preview {
    TicketCard(
        ticket: Tickets(Name: "Early Bird - Steel", description: "This ticket is non-refundable and special standing area", price: 1500000, quota: 10), detailAction: { print("Show all tapped") },
        bookAction: { print("Book tapped") }
    )
}
