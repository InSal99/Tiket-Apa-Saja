//
//  TASIconButton.swift
//  Tiket Apa Saja
//
//  Created by Intan Saliya Utomo on 20/07/25.
//

import SwiftUI

struct TASIconButton: View {
    let category: Category
    var isDisabled: Bool
    var action: () -> Void
    
    @State private var isPressed = false
    
    private struct ButtonConstants {
        static let pressedScale: CGFloat = 0.9
        static let animationResponse: Double = 0.4
        static let animationDamping: Double = 0.8
        static let iconSize: CGFloat = 24
    }
    
    private let animation: Animation = Animation.interactiveSpring(
        response: ButtonConstants.animationResponse,
        dampingFraction: ButtonConstants.animationDamping
    )
    
    var body: some View {
        Button(action: {
            if !isDisabled { action() }
        }) {
            VStack(alignment: .center, spacing: AppSizing.spacing150) {
                Image(category.icon)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: ButtonConstants.iconSize, height: ButtonConstants.iconSize)
                    .foregroundColor(isDisabled ? .gray9 : .orange10)
                    .padding(AppSizing.spacing400)
                    .background(Circle().fill(isDisabled ? .gray5 : .gray4))
                    .scaleEffect(isPressed ? ButtonConstants.pressedScale : 1.0)
                Text(category.label)
                    .font(.Label3())
                    .foregroundColor(isDisabled ? .gray5 : .gray12)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(isDisabled)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    withAnimation(animation) {
                        isPressed = true
                    }
                }
                .onEnded { _ in
                    withAnimation(animation) {
                        isPressed = false
                    }
                }
        )
    }
}

#Preview {
    TASIconButton(category: Category(icon: "cat-travel", label: "Travel"), isDisabled: false, action: {})
}
