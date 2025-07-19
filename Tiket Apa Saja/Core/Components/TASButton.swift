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
    
    @State private var isPressed = false
    
    private let scale: CGFloat = 0.9
    private let animationCurve: Animation = .easeInOut(duration: 0.3)
    
    private var iconPosition: IconPosition {
        IconPosition.from(left: leftIcon, right: rightIcon)
    }
    
    var body: some View {
        Button(action: {
            if !isDisabled { action() }
        }) {
            HStack(spacing: AppSizing.spacing0) {
                if (iconPosition == .left), let leftIcon = leftIcon {
                    Image(systemName: leftIcon)
                        .frame(width: size.iconSize, height: size.iconSize)
                }
                
                Text(label)
                    .font(size.fontStyle)
                    .lineLimit(1)
                    .padding(.horizontal, AppSizing.spacing100)
                
                if (iconPosition == .right), let rightIcon = rightIcon {
                    Image(systemName: rightIcon)
                        .frame(width: size.iconSize, height: size.iconSize)
                }
            }
            .foregroundColor(isDisabled ? .gray : style.foregroundColor(isPressed: isPressed))
            .padding(.vertical, AppSizing.spacing200)
            .padding(.horizontal, AppSizing.spacing300)
            .background(
                RoundedRectangle(cornerRadius: AppSizing.borderRadius150)
                    .fill(isDisabled ? Color.gray.opacity(0.3) : style.backgroundColor(isPressed: isPressed))
            )
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(isDisabled)
        .scaleEffect(isPressed ? scale : 1.0)
        .animation(animationCurve, value: isPressed)
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
            isPressed = pressing
        }, perform: {})
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
    case primary, secondary, tertiary, destructive
    
    func backgroundColor(isPressed: Bool) -> Color {
        switch self {
        case .primary: return isPressed ? .orange8 : .orange9
        case .secondary: return isPressed ? .gray4 : .gray5
        case .tertiary: return .clear
        case .destructive: return isPressed ? .red.opacity(0.8) : .red
        }
    }
    
    func foregroundColor(isPressed: Bool) -> Color {
        switch self {
        case .primary, .destructive: return .baseWhite
        case .secondary: return .gray12
        case .tertiary: return isPressed ? .orange8 : .orange9
        }
    }
}

private enum IconPosition {
    case left, right, none
    static func from(left: String?, right: String?) -> IconPosition {
        if left != nil { return .left }
        else if right != nil { return .right }
        else { return .none }
    }
}

extension TASButton {
    static func withLeftIcon(
        label: String,
        icon: String,
        size: ButtonSize,
        style: CustomButtonStyle,
        isDisabled: Bool,
        action: @escaping () -> Void
    ) -> TASButton {
        TASButton(
            label: label,
            action: action,
            leftIcon: icon,
            size: size,
            style: style,
            isDisabled: isDisabled
        )
    }
    
    static func withRightIcon(
        label: String,
        icon: String,
        size: ButtonSize,
        style: CustomButtonStyle,
        isDisabled: Bool,
        action: @escaping () -> Void
    ) -> TASButton {
        TASButton(
            label: label,
            action: action,
            rightIcon: icon,
            size: size,
            style: style,
            isDisabled: isDisabled
        )
    }
    
    static func textOnly(
        label: String,
        size: ButtonSize,
        style: CustomButtonStyle,
        isDisabled: Bool,
        action: @escaping () -> Void
    ) -> TASButton {
        TASButton(
            label: label,
            action: action,
            size: size,
            style: style,
            isDisabled: isDisabled
        )
    }
}

#Preview {
//    TASButton.textOnly(title: "Tap Me", size: .large, style: .primary, isDisabled: false, action: { })
//    TASButton.withRightIcon(title: "Tap Me", icon: "plus", size: .large, style: .tertiary, isDisabled: false, action: { })
    TASButton.withLeftIcon(label: "Tap Me", icon: "plus", size: .large, style: .primary, isDisabled: false, action: { })
}
