//
//  Chip.swift
//  Tiket Apa Saja
//
//  Created by Yovita Handayiani on 08/07/25.
//

import SwiftUI

enum ChipType{
    case filter
    case location
    case body
}

struct Chip: View {
    var text: String = "Upcoming"
    var type: ChipType = .location
    
    init(text: String, type: ChipType) {
        self.text = text
        self.type = type
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            if(type == .body){
                Text(text)
                    .Body2TextStyle()
            }else if(type == .filter){
                Image(systemName: "line.3.horizontal.decrease")
            }else if(type == .location){
                HStack(alignment: .center, spacing: 4){
                    Text("All Location")
                        .Body2TextStyle()
                    Image(systemName: "chevron.down")
                }
            }
        }
        .foregroundStyle(AppColor.Gray.gray10)
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(
            Capsule()
                .stroke(AppColor.Gray.gray5, lineWidth: 1)
        )
        .clipShape(Capsule())
        
        
    }
}

#Preview {
    Chip(text: "Upcoming", type: .location)
}
