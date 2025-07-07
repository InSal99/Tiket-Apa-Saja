//
//  TextStyles.swift
//  Tiket Apa Saja
//
//  Created by Yovita Handayiani on 07/07/25.
//

import SwiftUI

extension Text {
    func Heading1TextStyle() -> some View {
        return self
            .font(.Heading1())
            .tracking(-0.25)  // Letter spacing -0.25px
            .lineSpacing(8)   // This needs to be calculated for 48px line height || lineSpacing = desired line height - font size
    }
    func Heading2TextStyle() -> some View {
        return self
            .font(.Heading2())
            .tracking(-0.25)
            .lineSpacing(4)
    }
    func Heading3TextStyle() -> some View {
        return self
            .font(.Heading3())
            .tracking(-0.25)
            .lineSpacing(4)
    }
    
    func Title1TextStyle() -> some View {
        return self
            .font(.Title1())
            .tracking(-0.25)
            .lineSpacing(4)
    }
    func Title2TextStyle() -> some View {
        return self
            .font(.Title2())
            .tracking(0)
            .lineSpacing(6)
    }
    
    func Subtitle1TextStyle() -> some View {
        return self
            .font(.Subtitle1())
            .tracking(0)
            .lineSpacing(4)
    }
    func Subtitle2TextStyle() -> some View {
        return self
            .font(.Subtitle2())
            .tracking(0)
            .lineSpacing(4)
    }
    func Subtitle3TextStyle() -> some View {
        return self
            .font(.Subtitle3())
            .tracking(0)
            .lineSpacing(4)
    }
    
    func Body1TextStyle() -> some View {
        return self
            .font(.Body1())
            .tracking(0)
            .lineSpacing(4)
    }
    func Body2TextStyle() -> some View {
        return self
            .font(.Body2())
            .tracking(0)
            .lineSpacing(4)
    }
    
    func Caption1TextStyle() -> some View {
        return self
            .font(.Caption1())
            .tracking(0)
            .lineSpacing(4)
    }
    func Caption2TextStyle() -> some View {
        return self
            .font(.Caption2())
            .tracking(0)
            .lineSpacing(4)
    }
    
    func Label1TextStyle() -> some View {
        return self
            .font(.Label1())
            .tracking(0)
            .lineSpacing(6)
    }
    func Label2TextStyle() -> some View {
        return self
            .font(.Label2())
            .tracking(0)
            .lineSpacing(4)
    }
    func Label3TextStyle() -> some View {
        return self
            .font(.Label3())
            .tracking(0)
            .lineSpacing(4)
    }
}
