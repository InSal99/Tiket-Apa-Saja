# TASBadgedIcon Component Documentation

## Overview

`TASBadgedIcon` is a SwiftUI component that provides an interactive icon button with an optional indicator badge. The component features smooth press animations and visual feedback, making it perfect for navigation bars, toolbars, and action buttons that need to display notification states.

## Features

- **Interactive Icon Button**: Responsive button with smooth press animations
- **Optional Badge**: Toggleable notification badge with customizable visibility
- **Press Animation**: Spring-based scale animation for tactile feedback
- **Customizable Icon**: Support for any custom image asset
- **Action Handler**: Custom action callback for button interactions

## Preview

| Type | Preview |
|---------|---------|
| **With Badge** | ![HPTL](https://res.cloudinary.com/dpdbzlnhr/image/upload/c_scale,w_50/v1753068376/icon-with-badge_llqd1r.png) |
| **Without Badge** | ![HPTL](https://res.cloudinary.com/dpdbzlnhr/image/upload/c_scale,w_50/v1753068376/icon-without-badge_ju64sn.png) |

## Usage

### Basic Implementation

```swift
TASBadgedIcon(
    iconName: "bell",
    showBadge: true,
    action: {
        print("Icon tapped!")
    }
)
```

### Without Badge

```swift
TASBadgedIcon(
    iconName: "settings",
    showBadge: false,
    action: {
        navigateToSettings()
    }
)
```

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `iconName` | `String` | Yes | Name of the image asset to display |
| `showBadge` | `Bool` | Yes | Whether to show the notification badge |
| `action` | `() -> Void` | Yes | Callback function executed when the icon is tapped |

## State Properties

| Property | Type | Access | Description |
|----------|------|--------|-------------|
| `isPressed` | `Bool` | `@State private` | Tracks the pressed state for animation |

## Animation Behavior

1. **Scale Animation**: Smooth spring animation scales the icon to 0.9 when pressed
2. **Release Animation**: Returns to original size with the same spring animation

## Interactive States

### Normal State
- Full scale (1.0)
- Standard icon color
- Badge visible if `showBadge` is true

### Pressed State
- Reduced scale (0.9)
- Maintains color and badge visibility
- Smooth transition animation
