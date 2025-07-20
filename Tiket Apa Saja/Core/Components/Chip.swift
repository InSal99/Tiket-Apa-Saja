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
    
    @Binding var isActive:Bool
    
    init(text: String, isActive: Binding<Bool>, action: @escaping () -> Void) {
        self.text = text
        self.type = .body
        self.action = action
        self._isActive = isActive
    }
    
    var body: some View {
        Button {
            withAnimation (.spring(duration: 0.2, bounce: 0.5)) {
                if type == .body {
                    // Let the parent handle the state change
                } else {
                    isActive.toggle()
                }
            }
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
                }else if(type == .location){
                    HStack(alignment: .center, spacing: 4){
                        Text("All Location")
                            .Body2TextStyle()
                        Image("icon-chevron-down")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 16, height: 16)
                            .aspectRatio(1, contentMode: .fill)
                    }
                }
            }
            .foregroundStyle(isActive ? Color.orange9 : Color.gray11)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .stroke(isActive ? Color.orange10 : Color.gray5, lineWidth: 1)
                    .fill(isActive ? Color.orange4 : Color.clear)
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
    Chip(text: "Upcoming", isActive: .constant(true), action: {}).chipType(type: .location)
}
