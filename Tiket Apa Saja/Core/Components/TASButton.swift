//
//  Button.swift
//  Tiket Apa Saja
//
//  Created by Intan Saliya Utomo on 07/07/25.
//

import SwiftUI

struct TASButton: View {
    let label: String
    let action: () -> Void
    var leftIcon: String? = nil
    var rightIcon: String? = nil
    var size: ButtonSize = .large
    var style: CustomButtonStyle = .primary
    var isDisabled: Bool = false
    var customForegroundColor: Color? = nil
    var maxWidth: CGFloat? = nil
    
    @State private var isPressed = false
    
    private struct ButtonConstants {
        static let pressedScale: CGFloat = 0.9
        static let animationResponse: Double = 0.4
        static let animationDamping: Double = 0.8
    }
    
    private let animation: Animation = Animation.interactiveSpring(
        response: ButtonConstants.animationResponse,
        dampingFraction: ButtonConstants.animationDamping
    )
    
    var body: some View {
        Button(action: {
            if !isDisabled { action() }
        }) {
            HStack(spacing: AppSizing.spacing0) {
                if let leftIcon = leftIcon {
                    iconView(leftIcon)
                }
                
                Text(label)
                    .font(size.fontStyle)
                    .lineLimit(1)
                    .padding(.horizontal, AppSizing.spacing100)
                
                if let rightIcon = rightIcon {
                    iconView(rightIcon)
                }
            }
            .foregroundColor(isDisabled ? .gray9 : style.foregroundColor(isPressed: isPressed))
            .padding(.vertical, style.verticalPadding())
            .padding(.horizontal, style.horizontalPadding())
            .frame(maxWidth: maxWidth)
            .background(
                RoundedRectangle(cornerRadius: AppSizing.borderRadius150)
                    .fill(isDisabled ? .gray5 : style.backgroundColor(isPressed: isPressed))
            )
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(isDisabled)
        .scaleEffect(isPressed ? ButtonConstants.pressedScale : 1.0)
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
    
    private func iconView(_ iconName: String) -> some View {
        Image(iconName)
            .resizable()
            .renderingMode(.template)
            .frame(width: size.iconSize, height: size.iconSize)
    }
}

enum ButtonSize {
    case small, large
    
    var fontStyle: Font {
        switch self {
        case .small: return .Label2()
        case .large: return .Label1()
        }
    }
    
    var iconSize: CGFloat {
        switch self {
        case .small: return 16
        case .large: return 20
        }
    }
}

enum CustomButtonStyle {
    case primary, secondary, tertiary(Color = .orange9)
    
    func backgroundColor(isPressed: Bool) -> Color {
        switch self {
        case .primary: return isPressed ? .orange8 : .orange9
        case .secondary: return isPressed ? .gray4 : .gray5
        case .tertiary: return .clear
        }
    }
    
    func foregroundColor(isPressed: Bool) -> Color {
        switch self {
        case .primary: return .baseWhite
        case .secondary: return .gray12
        case .tertiary(let color): return isPressed ? color.opacity(0.8) : color
        }
    }
    
    func verticalPadding() -> CGFloat {
        switch self {
        case .tertiary: return AppSizing.spacing0
        default: return AppSizing.spacing200
        }
    }

    func horizontalPadding() -> CGFloat {
        switch self {
        case .tertiary: return AppSizing.spacing0
        default: return AppSizing.spacing300
        }
    }
}

extension TASButton {
    static func withLeftIcon(
        label: String,
        icon: String,
        size: ButtonSize,
        style: CustomButtonStyle,
        isDisabled: Bool,
        maxWidth: CGFloat? = nil,
        action: @escaping () -> Void
    ) -> TASButton {
        TASButton(
            label: label,
            action: action,
            leftIcon: icon,
            size: size,
            style: style,
            isDisabled: isDisabled,
            maxWidth: maxWidth
        )
    }
    
    static func withRightIcon(
        label: String,
        icon: String,
        size: ButtonSize,
        style: CustomButtonStyle,
        isDisabled: Bool,
        maxWidth: CGFloat? = nil,
        action: @escaping () -> Void
    ) -> TASButton {
        TASButton(
            label: label,
            action: action,
            rightIcon: icon,
            size: size,
            style: style,
            isDisabled: isDisabled,
            maxWidth: maxWidth
        )
    }
    
    static func textOnly(
        label: String,
        size: ButtonSize,
        style: CustomButtonStyle,
        isDisabled: Bool,
        maxWidth: CGFloat? = nil,
        action: @escaping () -> Void
    ) -> TASButton {
        TASButton(
            label: label,
            action: action,
            size: size,
            style: style,
            isDisabled: isDisabled,
            maxWidth: maxWidth
        )
    }
}

#Preview {
//    TASButton.textOnly(title: "Tap Me", size: .large, style: .primary, isDisabled: false, action: { })
//    TASButton.withRightIcon(title: "Tap Me", icon: "plus", size: .large, style: .tertiary, isDisabled: false, action: { })
    TASButton.withLeftIcon(label: "Tap Me", icon: "chevron-right", size: .large, style: .primary, isDisabled: false, action: { })
}
