//
//  Checkbox.swift
//  Tiket Apa Saja
//
//  Created by Yovita Handayiani on 12/07/25.
//

import SwiftUI

enum CheckboxType{
    case check
    case uncheck
}

struct Checkbox: View {
    var label: String = "Label"
    var type: CheckboxType = .uncheck
    
    init(label: String, type: CheckboxType) {
        self.label = label
        self.type = type
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 0){
            Text(label)
                .Body2TextStyle()
            Spacer()
            if(type == .check){
                Image(systemName: "checkmark.square")
            }else if(type == .uncheck){
                Image(systemName: "square")
            }
        }
        .padding(.vertical, 4)
        .foregroundStyle(Color.gray10)
    }
}

#Preview {
    Checkbox(label: "Balikpapan", type: .uncheck)
}
