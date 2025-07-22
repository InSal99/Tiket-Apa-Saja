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
                    DotIndicator(
                        index: index,
                        currentIndex: currentIndex,
                        dragOffset: dragOffset,
                        totalImages: images.count
                    )
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
            
            withAnimation(.smooth(duration: 0.5)) {
                currentIndex = (currentIndex + 1) % images.count
            }
        }
    }
    
    private func cancelAutoScroll() {
        autoScrollTimer?.invalidate()
        autoScrollTimer = nil
    }
}

struct DotIndicator: View {
    let index: Int
    let currentIndex: Int
    let dragOffset: CGFloat
    let totalImages: Int
    
    private var dotWidth: CGFloat {
        let isActive = index == currentIndex
        
        guard abs(dragOffset) > 10 else {
            return isActive ? 12 : 4
        }
        
        let screenWidth = UIScreen.main.bounds.width
        let dragProgress = min(1.0, abs(dragOffset) / (screenWidth * 0.4))
        
        let nextIndex: Int
        if dragOffset > 0 {
            nextIndex = currentIndex > 0 ? currentIndex - 1 : totalImages - 1
        } else {
            nextIndex = currentIndex < totalImages - 1 ? currentIndex + 1 : 0
        }
        
        let isNext = index == nextIndex
        
        if isActive {
            return 12 - (dragProgress * 8)
        } else if isNext {
            return 4 + (dragProgress * 8)
        } else {
            return 4
        }
    }
    
    private var dotColor: Color {
        let isActive = index == currentIndex
        
        // Only change color if we're actively dragging
        guard abs(dragOffset) > 10 else {
            return isActive ? .baseWhite : .gray1
        }
        
        let screenWidth = UIScreen.main.bounds.width
        let dragProgress = abs(dragOffset) / (screenWidth * 0.4)
        
        // Determine next index based on drag direction
        let nextIndex: Int
        if dragOffset > 0 {
            nextIndex = currentIndex > 0 ? currentIndex - 1 : totalImages - 1
        } else {
            nextIndex = currentIndex < totalImages - 1 ? currentIndex + 1 : 0
        }
        
        let isNext = index == nextIndex
        
        return (isActive || (isNext && dragProgress > 0.4)) ? .baseWhite : .gray1
    }
    
    var body: some View {
        Capsule()
            .fill(dotColor)
            .frame(width: dotWidth, height: 4)
            .animation(.interactiveSpring(response: 0.4, dampingFraction: 0.8), value: dotWidth)
            .animation(.interactiveSpring(response: 0.4, dampingFraction: 0.8), value: dotColor)
    }
}


//Snappy
//struct Carousel: View {
//    @State private var currentIndex = 0
//    @State private var dragOffset: CGFloat = 0
//    @State private var isDragging = false
//    @State private var autoScrollTimer: Timer?
//    
//    let images: [String]
//    private let autoScrollInterval: TimeInterval? = 5.0
//    
//    var body: some View {
//        ZStack(alignment: .bottom) {
//            TabView(selection: $currentIndex) {
//                ForEach(images.indices, id: \.self) { index in
//                    GeometryReader { geometry in
//                        let frame = geometry.frame(in: .global)
//                        let midX = frame.midX
//                        let screenWidth = UIScreen.main.bounds.width
//                        let offset = abs(midX - screenWidth / 2)
//                        let scale = max(0.95, 1 - offset / screenWidth)
//                        
//                        Image(images[index])
//                            .resizable()
//                            .scaledToFill()
//                            .frame(height: 192)
//                            .clipShape(RoundedRectangle(cornerRadius: AppSizing.borderRadius200))
//                            .scaleEffect(scale)
//                            .animation(.easeInOut(duration: 0.5), value: scale)
//                            .onChange(of: midX) { _, newMidX in
//                                if index == currentIndex {
//                                    let centerOffset = newMidX - screenWidth / 2
//                                    if abs(centerOffset) < screenWidth * 0.8 {
//                                        dragOffset = centerOffset
//                                        isDragging = abs(centerOffset) > 20
//                                    }
//                                }
//                            }
//                    }
//                    .tag(index)
//                }
//            }
//            .tabViewStyle(.page(indexDisplayMode: .never))
//            
//            HStack(spacing: 6) {
//                ForEach(images.indices, id: \.self) { index in
//                    DotIndicator(
//                        index: index,
//                        currentIndex: currentIndex,
//                        dragOffset: isDragging ? dragOffset : 0,
//                        totalImages: images.count
//                    )
//                }
//            }
//            .padding(.bottom, AppSizing.spacing100)
//        }
//        .frame(height: 192)
//        .onAppear(perform: setupAutoScroll)
//        .onDisappear(perform: cancelAutoScroll)
//        .onChange(of: currentIndex) { _, _ in
//            // Reset drag state when index changes
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                dragOffset = 0
//                isDragging = false
//            }
//        }
//    }
//    
//    private func setupAutoScroll() {
//        guard let interval = autoScrollInterval, images.count > 1 else { return }
//        
//        autoScrollTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
//            guard images.count > 1 else { cancelAutoScroll(); return }
//            
//            withAnimation(.smooth(duration: 0.5)) {
//                currentIndex = (currentIndex + 1) % images.count
//            }
//        }
//    }
//    
//    private func cancelAutoScroll() {
//        autoScrollTimer?.invalidate()
//        autoScrollTimer = nil
//    }
//}
//
//struct DotIndicator: View {
//    let index: Int
//    let currentIndex: Int
//    let dragOffset: CGFloat
//    let totalImages: Int
//    
//    private var dotWidth: CGFloat {
//        let isActive = index == currentIndex
//        
//        // Only animate if we're actively dragging
//        guard dragOffset != 0 else {
//            return isActive ? 12 : 4
//        }
//        
//        let dragProgress = min(1.0, abs(dragOffset) / (UIScreen.main.bounds.width * 0.3))
//        let nextIndex = dragOffset < 0 ? min(totalImages - 1, currentIndex + 1) : max(0, currentIndex - 1)
//        let isNext = index == nextIndex
//        
//        if isActive {
//            return 12 - (dragProgress * 8) // Shrink from 12 to 4
//        } else if isNext {
//            return 4 + (dragProgress * 8) // Grow from 4 to 12
//        } else {
//            return 4
//        }
//    }
//    
//    private var dotColor: Color {
//        let isActive = index == currentIndex
//        
//        // Only change color if we're actively dragging
//        guard dragOffset != 0 else {
//            return isActive ? .baseWhite : .gray1
//        }
//        
//        let dragProgress = abs(dragOffset) / (UIScreen.main.bounds.width * 0.3)
//        let nextIndex = dragOffset < 0 ? min(totalImages - 1, currentIndex + 1) : max(0, currentIndex - 1)
//        let isNext = index == nextIndex
//        
//        return (isActive || (isNext && dragProgress > 0.5)) ? .baseWhite : .gray1
//    }
//    
//    var body: some View {
//        Capsule()
//            .fill(dotColor)
//            .frame(width: dotWidth, height: 4)
//            .animation(.easeInOut(duration: 0.5), value: dotWidth)
//            .animation(.easeInOut(duration: 0.5), value: dotColor)
//    }
//}


//struct Carousel: View {
//    @State private var currentIndex = 0
//    @State private var autoScrollTimer: Timer?
//    
//    let images: [String]
//    private let autoScrollInterval: TimeInterval? = 5.0
//    
//    var body: some View {
//        ZStack(alignment: .bottom) {
//            TabView(selection: $currentIndex) {
//                ForEach(images.indices, id: \.self) { index in
//                    GeometryReader { geometry in
//                        let frame = geometry.frame(in: .global)
//                        let midX = frame.midX
//                        let screenWidth = UIScreen.main.bounds.width
//                        let offset = abs(midX - screenWidth / 2)
//                        let scale = max(0.96, 1 - offset / screenWidth)
//                        
//                        Image(images[index])
//                            .resizable()
//                            .scaledToFill()
//                            .frame(height: 192)
//                            .clipped()
//                            .clipShape(RoundedRectangle(cornerRadius: AppSizing.borderRadius200))
//                            .scaleEffect(scale)
//                            .animation(.easeInOut(duration: 0.5), value: scale)
//                    }
//                    .tag(index)
//                }
//            }
//            .tabViewStyle(.page(indexDisplayMode: .never))
//            
//            HStack(spacing: 6) {
//                ForEach(images.indices, id: \.self) { index in
//                    Capsule()
//                        .fill(index == currentIndex ? .baseWhite : .gray1)
//                        .frame(width: index == currentIndex ? 12 : 4, height: 4)
//                }
//            }
//            .padding(.bottom, AppSizing.spacing100)
//        }
//        .frame(height: 192)
//        .onAppear(perform: setupAutoScroll)
//        .onDisappear(perform: cancelAutoScroll)
//    }
//    
//    private func setupAutoScroll() {
//        guard let interval = autoScrollInterval, images.count > 1 else { return }
//        
//        autoScrollTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
//            guard images.count > 1 else { cancelAutoScroll(); return }
//            
//            withAnimation(.smooth(duration: 0.5)) {
//                currentIndex = (currentIndex + 1) % images.count
//            }
//        }
//    }
//    
//    private func cancelAutoScroll() {
//        autoScrollTimer?.invalidate()
//        autoScrollTimer = nil
//    }
//}





//struct Carousel: View {
//    @State private var currentIndex = 0
//    @State private var autoScrollTimer: Timer?
//    
//    let images: [String]
//    private let autoScrollInterval: TimeInterval? = 5.0
//    
//    var body: some View {
//        ZStack(alignment: .bottom) {
//            TabView(selection: $currentIndex) {
//                ForEach(images.indices, id: \.self) { index in
//                    Image(images[index])
//                        .resizable()
//                        .scaledToFill()
//                        .frame(height: 192)
//                        .clipped()
//                }
//            }
//            .tabViewStyle(.page(indexDisplayMode: .never))
//            .clipShape(RoundedRectangle(cornerRadius: AppSizing.borderRadius200))
//            
//            HStack(spacing: 6) {
//                ForEach(images.indices, id: \.self) { index in
//                    Capsule()
//                        .fill(index == currentIndex ? .baseWhite : .gray1)
//                        .frame(width: index == currentIndex ? 12 : 4, height: 4)
//                }
//            }
//            .padding(.bottom, AppSizing.spacing100)
//        }
//        .frame(height: 192)
//        .onAppear(perform: setupAutoScroll)
//        .onDisappear(perform: cancelAutoScroll)
//    }
//    
//    private func setupAutoScroll() {
//        guard let interval = autoScrollInterval, images.count > 1 else { return }
//        
//        autoScrollTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
//            guard images.count > 1 else { cancelAutoScroll(); return }
//            
//            withAnimation(.smooth(duration: 0.5)) {
//                currentIndex = (currentIndex + 1) % images.count
//            }
//        }
//    }
//    
//    private func cancelAutoScroll() {
//        autoScrollTimer?.invalidate()
//        autoScrollTimer = nil
//    }
//    
//    private var scrollViewSection: some View {
//        VStack(alignment: .leading, spacing: 10) {
//            Text("GeometryReader with ScrollView:")
//                .font(.headline)
//    
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 15) {
//                    ForEach(0..<10, id: \.self) { index in
//                        scrollCardView(index: index)
//                    }
//                }
//                .padding(.horizontal)
//            }
//            .frame(height: 100)
//        }
//    }
//
//    private func scrollCardView(index: Int) -> some View {
//        GeometryReader { geometry in
//            let frame = geometry.frame(in: .global)
//            let midX = frame.midX
//            let screenWidth = UIScreen.main.bounds.width
//            let offset = abs(midX - screenWidth / 2)
//            let scale = max(0.8, 1 - offset / screenWidth)
//            
//            RoundedRectangle(cornerRadius: 15)
//                .fill(
//                    LinearGradient(
//                        gradient: Gradient(colors: [Color.blue, Color.purple]),
//                        startPoint: .topLeading,
//                        endPoint: .bottomTrailing
//                    )
//                )
//                .scaleEffect(scale)
//                .overlay(
//                    VStack {
//                        Text("Card \(index)")
//                            .font(.headline)
//                            .foregroundColor(.white)
//                        Text("Scale: \(scale, specifier: "%.2f")")
//                            .font(.caption)
//                            .foregroundColor(.white.opacity(0.8))
//                    }
//                )
//        }
//        .frame(width: 120, height: 80)
//    }
//}

#Preview {
    Carousel(images: ["banner1", "banner1", "banner1", "banner1"])
}
