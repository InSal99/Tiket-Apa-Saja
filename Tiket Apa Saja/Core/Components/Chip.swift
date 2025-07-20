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
    var type: ChipType = .body
    var action: (() -> Void)
    
    init(text: String, action: @escaping () -> Void) {
        self.text = text
        self.type = .body
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack(alignment: .leading, spacing: 0){
                if(type == .body){
                    Text(text)
                        .Body2TextStyle()
                }else if(type == .filter){
                    Image("icon-filter")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 18, height: 18)
                        .aspectRatio(1, contentMode: .fill)
                        .foregroundColor(Color.gray11)
                }else if(type == .location){
                    HStack(alignment: .center, spacing: 4){
                        Text("All Location")
                            .Body2TextStyle()
                        Image("icon-chevron-down")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 16, height: 16)
                            .aspectRatio(1, contentMode: .fill)
                            .foregroundColor(Color.gray11)
                    }
                }
            }
            .foregroundStyle(Color.gray11)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .stroke(Color.gray5, lineWidth: 1)
            )
            .clipShape(Capsule())
        }
    }
}

extension Chip {
    func chipType(type: ChipType) -> Chip {
        var curr = self
        curr.type = type
        return curr
    }
}

#Preview {
    Chip(text: "Upcoming", action: {}).chipType(type: .location)
}
