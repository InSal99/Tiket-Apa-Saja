//
//  ChipDocs.swift
//  Tiket Apa Saja
//
//  Created by Yovita Handayiani on 21/07/25.
//

# Chip Component

| Feature / Variation | Preview |
| ------------------- | ------- |
| Body Chip           | ![Body chip with text](preview-placeholder) |
| Filter Chip         | ![Filter chip with icon](preview-placeholder) |
| Location Chip       | ![Location chip with dropdown](preview-placeholder) |

| **Active State** | ![Active chip styling](preview-placeholder) |
| ---------------- | -------------------------------------------- |
| **Inactive State** | ![Inactive chip styling](preview-placeholder) |

## Overview

*A versatile chip component for SwiftUI that supports three distinct types: body chips for text content, filter chips with icons, and location chips with dropdown indicators. The component features customizable active/inactive states with smooth spring animations.*

## Basic Usage

### 1. Import SwiftUI

```swift
import SwiftUI
```

### 2. Add to View

```swift
@State private var appliedBodyChip: String? = nil

Chip(
    text: "Upcoming",
    isActive: .constant(appliedBodyChip == "Upcoming"),
    action: {
        // Handle chip tap
        selectOutsideBodyChip("Upcoming")
    }
)
```

### 3. Configure Chip Type

```swift
Chip(text: "Filter", isActive: .constant(hasOtherFilters || hasLocationFilters),  action: {
    syncTemporaryState()
    showSheetFilter.toggle()
})
.chipType(type: .filter)
```

```swift
Chip(text: "All Location",  isActive: .constant(hasLocationFilters), action: {
    syncTemporaryState()
    showSheetLocation.toggle()
})
.chipType(type: .location)
```

## Chip Types

| Type Name | Value | Description | Use Case |
| --------- | ----- | ----------- | -------- |
| `.body` | `ChipType.body` | Text-based chip with customizable content | Category selection |
| `.filter` | `ChipType.filter` | Icon-based chip with filter symbol | Filters and sorting options in sheet |
| `.location` | `ChipType.location` | Text-based chip with chevron icon | Location filter options in sheet |

### Multiple Chips in HStack
```swift
LazyHStack(spacing: AppSizing.spacing200) {
    Chip(text: "Filter", isActive: .constant(hasOtherFilters || hasLocationFilters),  action: {
        syncTemporaryState()
        showSheetFilter.toggle()
    })
    .chipType(type: .filter)
    Chip(text: "All Location",  isActive: .constant(hasLocationFilters), action: {
        syncTemporaryState()
        showSheetLocation.toggle()
    })
    .chipType(type: .location)

    Chip(text: "Upcoming", isActive: .constant(appliedBodyChip == "Upcoming"), action: {
        selectOutsideBodyChip("Upcoming")
    })
    Chip(text: "Just Announced", isActive: .constant(appliedBodyChip == "Just Announced"), action: {
        selectOutsideBodyChip("Just Announced")
    })
}
```

## Properties Reference

### Core Properties

| Property Name | Type | Required | Description |
| ------------- | ---- | -------- | ----------- |
| `text` | `String` | ✅ | Display text for the chip |
| `isActive` | `Binding<Bool>` | ✅ | Controls active/inactive visual state |
| `action` | `() -> Void` | ✅ | Callback function executed on tap |
| `type` | `ChipType` | ❌ | Chip variant (defaults to `.body`) |

### Visual Properties

| Property Name | Type | Default | Description |
| ------------- | ---- | ------- | ----------- |
| Active Text Color | `Color` | `Color.orange9` | Text color when chip is active |
| Inactive Text Color | `Color` | `Color.gray11` | Text color when chip is inactive |
| Active Border Color | `Color` | `Color.orange10` | Border color when active |
| Inactive Border Color | `Color` | `Color.gray5` | Border color when inactive |
| Active Background | `Color` | `Color.orange4` | Background color when active |
| Inactive Background | `Color` | `Color.clear` | Background color when inactive |

### Spacing Properties

| Property Name | Type | Default | Description |
| ------------- | ---- | ------- | ----------- |
| Horizontal Padding | `CGFloat` | `AppSizing.spacing300` | Internal horizontal padding |
| Vertical Padding | `CGFloat` | `AppSizing.spacing150` | Internal vertical padding |
| Icon Spacing | `CGFloat` | `AppSizing.spacing100` | Spacing between text and icon |
| Border Width | `CGFloat` | `AppSizing.borderWidth25` | Stroke width of chip border |

## Customization Examples

### Custom Colors
```swift
// Note: Colors are currently hardcoded in the component
Chip(text: "Custom", isActive: $isActive, action: {})
// To customize colors, modify the component source code
```

### Custom Animation
```swift
// Animation is built into the component with spring configuration:
// .spring(duration: 0.2, bounce: 0.5)
// Modify component source for different animation styles
```

## Performance Considerations

- **State Management** — Uses `@Binding` for efficient parent-child communication
- **Animation Performance** — Spring animations are optimized for smooth 60fps performance

## Animation Details

| Animation Type | Duration | Interpolator | Description |
| -------------- | -------- | ------------ | ----------- |
| State Change | `200ms` | `Spring(bounce: 0.5)` | Smooth transition between active/inactive states |
| Color Transition | `200ms` | `Spring` | Animated color changes for text, border, and background |
| Scale Effect | `200ms` | `Spring` | Subtle scale animation on state changes |

## Best Practices

| ✅ Do | ❌ Don't |
| ----- | -------- |
| Keep chip text concise (1-3 words) | Use lengthy text that breaks layout |
| Provide meaningful action callbacks | Leave action closures empty |
| Use appropriate chip types for context | Mix chip types inconsistently |
| Handle state changes in parent views | Modify binding values inside action closure |

## Required Assets

| Asset Name | Size | Format | Description |
| ---------- | ---- | ------ | ----------- |
| `icon-filter` | 18x18 points | Vector (PDF/SVG) | Filter icon for filter chips |
| `icon-chevron-down` | 16x16 points | Vector (PDF/SVG) | Dropdown indicator for location chips |

## Dependencies

- **SwiftUI Framework** — Required for View protocol and modifiers
- **AppSizing** — Custom spacing and sizing constants
- **Body2TextStyle()** — Custom text style extension (ensure this is defined)
- **Color Extensions** — Custom color palette (orange9, gray11, etc.)

---

> **⚠️ Note**: This component uses custom color and sizing constants (AppSizing, Color.orange9, etc.) and text styles (Body2TextStyle). Ensure these are defined in your project before using the component. The component is designed for iOS 14+ due to its use of modern SwiftUI features.
