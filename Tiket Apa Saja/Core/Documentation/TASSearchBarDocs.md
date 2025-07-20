# TASSearchBar Component Documentation

## Overview

`TASSearchBar` is a SwiftUI component that provides an animated search bar with dynamic placeholder text. The component features a typewriter-style animation that cycles through multiple placeholder strings, providing an engaging user experience.

## Features

- **Animated Placeholder Text**: Typewriter-style animation that cycles through multiple placeholder strings
- **Search Icon**: Left-aligned search icon for visual clarity
- **Clear Button**: Animated clear button that appears when text is entered
- **Customizable Prefix**: Optional prefix text that appears before the animated placeholder
- **Search Action**: Optional callback for handling search submissions

## Preview

![HPTL](https://res.cloudinary.com/dr6cm6n5f/image/upload/v1737442931/hometablayout-ezgif.com-video-to-gif-converter_cjljyk.gif)

## Usage

### Basic Implementation

```swift
TASSearchBar(
    placeholders: ["Search products...", "Find brands...", "Look for deals..."],
    prefix: "🔍 "
)
```

### With Search Action

```swift
TASSearchBar(
    placeholders: ["Search products...", "Find brands...", "Look for deals..."],
    onSearchAction: { searchText in
        // Handle search action
        performSearch(with: searchText)
    },
    prefix: ""
)
```

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `placeholders` | `[String]` | Required | Array of placeholder strings to animate through |
| `onSearchAction` | `((String) -> Void)?` | `nil` | Optional callback triggered when search is submitted |
| `prefix` | `String` | Required | Text prefix displayed before the animated placeholder |

## State Properties

| Property | Type | Access | Description |
|----------|------|--------|-------------|
| `text` | `String` | `@State` | The current text input value |
| `isAnimating` | `Bool` | `@State private` | Controls the animation state |
| `animatedPlaceholder` | `String` | `@State private` | The currently displayed animated placeholder text |
| `currentWordIndex` | `Int` | `@State private` | Index of the current placeholder being animated |

## Animation Behavior

1. **Startup**: Animation begins automatically when the view appears
2. **Character Animation**: Each character appears with a 0.1-second delay
3. **Word Cycling**: After completing a word, there's a 1.5-second pause before starting the next
4. **Continuous Loop**: Placeholders cycle continuously until the view disappears
5. **Cleanup**: Animation stops automatically when the view disappears

## Interactive Elements

### Clear Button
- Appears only when text is entered
- Features spring animation with scale transition
- Clears the text field when tapped

### Search Submission
- Triggered by pressing return/enter on the keyboard
- Calls the optional `onSearchAction` callback with the current text

## Example Implementation

```swift
struct ContentView: View {
    var body: some View {
        VStack {
            TASSearchBar(
                placeholders: [
                    "Search for products",
                    "Find your favorite brands",
                    "Discover new items",
                    "Look for deals"
                ],
                onSearchAction: { searchQuery in
                    print("Searching for: \(searchQuery)")
                    // Implement search logic here
                },
                prefix: "🔍 "
            )
            .padding()
            
            Spacer()
        }
    }
}
```
