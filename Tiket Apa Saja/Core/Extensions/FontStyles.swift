//
//  Font.swift
//  Tiket Apa Saja
//
//  Created by Yovita Handayiani on 07/07/25.
//

import SwiftUI

extension Font {
    // MARK: - Inter Font
    static func interRegular(size: CGFloat) -> Font {
        return Font.custom("Inter-Regular", size: size)
    }
    
    static func interMedium(size: CGFloat) -> Font {
        return Font.custom("Inter-Medium", size: size)
    }
    
    static func interSemiBold(size: CGFloat) -> Font {
        return Font.custom("Inter-SemiBold", size: size)
    }
    
    static func interBold(size: CGFloat) -> Font {
        return Font.custom("Inter-Bold", size: size)
    }
    
    
    // MARK: - Semantic Typography Styles
    static func Heading1() -> Font {
        return interSemiBold(size: 40)
    }
    static func Heading2() -> Font {
        return interSemiBold(size: 32)
    }
    static func Heading3() -> Font {
        return interSemiBold(size: 24)
    }
    
    static func Title1() -> Font {
        return interSemiBold(size: 20)
    }
    static func Title2() -> Font {
        return interSemiBold(size: 18)
    }
    
    static func Subtitle1() -> Font {
        return interSemiBold(size: 16)
    }
    static func Subtitle2() -> Font {
        return interSemiBold(size: 14)
    }
    static func Subtitle3() -> Font {
        return interSemiBold(size: 12)
    }
    
    static func Body1() -> Font {
        return interRegular(size: 16)
    }
    static func Body2() -> Font {
        return interRegular(size: 14)
    }
    
    static func Caption1() -> Font {
        return interRegular(size: 12)
    }
    static func Caption2() -> Font {
        return interRegular(size: 10)
    }
    
    static func Label1() -> Font {
        return interSemiBold(size: 14)
    }
    static func Label2() -> Font {
        return interSemiBold(size: 12)
    }
    static func Label3() -> Font {
        return interSemiBold(size: 10)
    }
    
}
