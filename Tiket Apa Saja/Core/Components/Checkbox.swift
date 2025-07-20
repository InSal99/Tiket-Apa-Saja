//
//  Checkbox.swift
//  Tiket Apa Saja
//
//  Created by Yovita Handayiani on 12/07/25.
//

import SwiftUI

struct Checkbox: View {
    private var label: String = ""
    @Binding private var isSelected: Bool
    private var haveLabel: Bool = false
    
    init(isSelected: Binding<Bool>) {
        self.label = ""
        self._isSelected = isSelected
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 0){
            if haveLabel{
                Text(label)
                    .Body2TextStyle()
                Spacer()
            }
            Button {
                isSelected.toggle()
            } label: {
                if(isSelected == true){
                    Image("icon-check-box")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 24, height: 24)
                        .aspectRatio(1, contentMode: .fill)
                        .foregroundColor(Color.orange9)
                }else if(isSelected == false){
                    Image("icon-check-box-outline-blank")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 24, height: 24)
                        .aspectRatio(1, contentMode: .fill)
                        .foregroundColor(Color.gray11)
                        
                }
            }

        }
        .padding(.vertical, 4)
        .foregroundStyle(Color.gray11)
    }
}

extension Checkbox {
    func showLabel(label: String) -> Checkbox {
        var curr = self
        curr.label = label
        curr.haveLabel = true
        return curr
    }
}

#Preview {
    Checkbox(isSelected: .constant(false)).showLabel(label: "Balikpapan")
}
