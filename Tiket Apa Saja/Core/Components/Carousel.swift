//
//  TASCarousel.swift
//  Tiket Apa Saja
//
//  Created by Intan Saliya Utomo on 20/07/25.
//

import SwiftUI

struct Carousel: View {
    @State private var currentIndex = 0
    @State private var dragOffset: CGFloat = 0
    @State private var autoScrollTimer: Timer?
    
    let images: [String]
    private let autoScrollInterval: TimeInterval? = 5.0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $currentIndex) {
                ForEach(images.indices, id: \.self) { index in
                    GeometryReader { geometry in
                        let frame = geometry.frame(in: .global)
                        let midX = frame.midX
                        let screenWidth = UIScreen.main.bounds.width
                        let offset = abs(midX - screenWidth / 2)
                        let scale = max(0.95, 1 - offset / screenWidth)
                        
                        Image(images[index])
                            .resizable()
                            .scaledToFill()
                            .frame(height: 192)
                            .clipShape(RoundedRectangle(cornerRadius: AppSizing.borderRadius200))
                            .scaleEffect(scale)
                            .padding(.horizontal, AppSizing.spacing400)
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .gesture(
                DragGesture()
                    .onChanged { value in
                        cancelAutoScroll()
                        dragOffset = value.translation.width
                    }
                    .onEnded { value in
                        withAnimation(.easeInOut(duration: 0.5)) {
                            dragOffset = 0
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            setupAutoScroll()
                        }
                    }
            )
            
            HStack(spacing: AppSizing.spacing150) {
                ForEach(images.indices, id: \.self) { index in
                    Capsule()
                        .fill(index == currentIndex ? .baseWhite : .gray1)
                        .frame(width: index == currentIndex ? 12 : 4, height: 4)
                }
            }
            .padding(.bottom, AppSizing.spacing100)
        }
        .frame(height: 192)
        .onAppear(perform: setupAutoScroll)
        .onDisappear(perform: cancelAutoScroll)
    }
    
    private func setupAutoScroll() {
        guard let interval = autoScrollInterval, images.count > 1 else { return }
        
        autoScrollTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            guard images.count > 1 else { cancelAutoScroll(); return }
            
            withAnimation(.smooth(duration: 0.8)) {
                currentIndex = (currentIndex + 1) % images.count
            }
        }
    }
    
    private func cancelAutoScroll() {
        autoScrollTimer?.invalidate()
        autoScrollTimer = nil
    }
}

#Preview {
    Carousel(images: ["banner1", "banner2", "banner3", "banner4"])
}
