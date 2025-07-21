//
//  SearchBar.swift
//  Tiket Apa Saja
//
//  Created by Intan Saliya Utomo on 21/07/25.
//

import SwiftUI

struct SearchBar: View {
    @State var text: String = ""
    @State private var isAnimating: Bool = true
    @State private var animatedPlaceholder = ""
    @State private var currentWordIndex: Int = 0
    
    let placeholders: [String]
    let onSearchAction: ((String) -> Void)? = nil
    let prefix: String
    
    private struct SearchBarConstants {
        static let iconSize: CGFloat = 24
        static let characterDelay: Double = 0.1
        static let wordPause: Double = 1.5
        static let clearButtonAnimationDuration: Double = 0.2
        static let clearButtonBounce: Double = 0.4
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: AppSizing.spacing200) {
            Image("search")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.gray10)
                .frame(width: SearchBarConstants.iconSize, height: SearchBarConstants.iconSize)
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
            .onSubmit {
                onSearchAction?(text)
            }
            
            // Clear button (shown only when there's text)
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image("cross-circle-fill")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.gray10)
                        .frame(width: SearchBarConstants.iconSize, height: SearchBarConstants.iconSize)
                }
                .buttonStyle(PlainButtonStyle())
                .transition(.scale.animation(.spring(duration: SearchBarConstants.clearButtonAnimationDuration, bounce: SearchBarConstants.clearButtonBounce)))
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
        guard !placeholders.isEmpty else { return }
        isAnimating = true
        currentWordIndex = 0
        animateCurrentWord()
    }
    
    private func animateCurrentWord() {
        guard isAnimating && currentWordIndex < placeholders.count else { return }
        
        let currentWord = placeholders[currentWordIndex]
        animatedPlaceholder = ""
        animateWord(currentWord, characterIndex: 0)
    }
    
    private func animateWord(_ word: String, characterIndex: Int) {
        guard isAnimating else { return }
        
        guard characterIndex < word.count else {
            DispatchQueue.main.asyncAfter(deadline: .now() + SearchBarConstants.wordPause) {
                guard self.isAnimating else { return }
                self.currentWordIndex = (self.currentWordIndex + 1) % self.placeholders.count
                self.animateCurrentWord()
            }
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + SearchBarConstants.characterDelay) {
            guard self.isAnimating else { return }
            self.animatedPlaceholder = String(word.prefix(characterIndex + 1))
            self.animateWord(word, characterIndex: characterIndex + 1)
        }
    }
}

#Preview {
    SearchBar(placeholders: ["Musical", "Orchestra", "Concert"], prefix: "Search ")
}
