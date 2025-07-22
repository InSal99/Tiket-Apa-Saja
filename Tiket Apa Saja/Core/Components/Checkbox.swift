//
//  Checkbox.swift
//  Tiket Apa Saja
//
//  Created by Yovita Handayiani on 12/07/25.
//

import SwiftUI

struct Checkbox: View {
    var label: String = ""
    var haveLabel: Bool = false
    @Binding var isActive: Bool
    
    init(isActive: Binding<Bool>) {
        self._isActive = isActive
        self.label = ""
        self.haveLabel = false
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: AppSizing.spacing0){
            if haveLabel{
                Text(label)
                    .Body2TextStyle()
                Spacer()
            }
            Button {
                isActive.toggle()
            } label: {
                if(isActive == true){
                    Image("icon-check-box")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 24, height: 24)
                        .aspectRatio(1, contentMode: .fill)
                        .foregroundColor(Color.orange9)
                }else if(isActive == false){
                    Image("icon-check-box-outline-blank")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 24, height: 24)
                        .aspectRatio(1, contentMode: .fill)
                        .foregroundColor(Color.gray11)
                        
                }
            }

        }
        .padding(.vertical, AppSizing.spacing100)
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
    Checkbox(isActive: .constant(false)).showLabel(label: "Balikpapan")
}
