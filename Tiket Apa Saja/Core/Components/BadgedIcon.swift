//
//  TASBadgedIcon.swift
//  Tiket Apa Saja
//
//  Created by Intan Saliya Utomo on 20/07/25.
//

import SwiftUI

struct BadgedIcon: View {
    var iconName: String
    var showBadge: Bool
    var action: () -> Void
    
    @State private var isPressed = false
    
    private let scale: CGFloat = 0.9
    private let animation: Animation = Animation.interactiveSpring(response: 0.4, dampingFraction: 0.8)
    
    var body: some View {
        Button(action: action) {
            ZStack(alignment: .topTrailing) {
                Image(iconName)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
                    .foregroundColor(.gray10)
                
                if showBadge {
                    Circle()
                        .fill(.orange10)
                        .frame(width: 8, height: 8)
                        .offset(x: -2, y: 2)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(isPressed ? scale : 1.0)
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
    BadgedIcon(iconName: "notifications", showBadge: false, action: {})
}
