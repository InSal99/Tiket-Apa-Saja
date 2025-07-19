//
//  TASSearchBar.swift
//  Tiket Apa Saja
//
//  Created by Intan Saliya Utomo on 19/07/25.
//

import SwiftUI

struct TASSearchBar: View {
    @State var text: String = ""
    @State private var isAnimating: Bool = true
    @State private var animatedPlaceholder = ""
    @State private var placeholderIndex: Int = 0
    
    private let placeholders = ["Musical", "Orchestra", "Concert"]
    private let prefix = "Search "
    
    var body: some View {
        HStack(alignment: .center, spacing: AppSizing.spacing200) {
            Image("search")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.gray10)
                .frame(width: 24, height: 24)
            TextField(
                "",
                text: $text,
                prompt: Text(prefix + animatedPlaceholder)
                    .font(.Body2())
                    .foregroundColor(.gray10)
            )
            .font(.Body2())
            .foregroundColor(.gray12)
            .disableAutocorrection(true)
            
            // Clear button (shown only when there's text)
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image("cross-circle-fill")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.gray10)
                        .frame(width: 24, height: 24)
                }
                .buttonStyle(PlainButtonStyle())
                .transition(.scale(scale: 0).animation(.spring(duration: 0.2, bounce: 0.4, blendDuration: 0.8)))
            }
        }
        .padding(.horizontal, AppSizing.spacing400)
        .padding(.vertical, AppSizing.spacing200)
        .background(
            RoundedRectangle(cornerRadius: AppSizing.borderRadiusFull)
                .foregroundColor(.gray2)
        )
        .onAppear {
            startAnimation()
        }
        .onDisappear {
            isAnimating = false
        }
    }
    
    private func startAnimation() {
        var currentIndex = 0
        
        func animateWord(_ word: String, characterIndex: Int = 0) {
            guard characterIndex < word.count else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    currentIndex = (currentIndex + 1) % placeholders.count
                    animateWord(placeholders[currentIndex])
                }
                return
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                animatedPlaceholder = String(word.prefix(characterIndex + 1))
                animateWord(word, characterIndex: characterIndex + 1)
            }
        }
        animateWord(placeholders[currentIndex])
    }
}


#Preview {
    TASSearchBar()
}
