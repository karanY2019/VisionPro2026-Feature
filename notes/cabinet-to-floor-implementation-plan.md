# Cabinet-to-Floor Swapping Feature Implementation Plan

## Overview
Add functionality to select kitchen cabinets and use them as floor materials in the immersive 3D experience, extending the existing floor swapping mechanism.

## Current State Analysis

### Existing Infrastructure
- ✅ Floor swapping mechanism already exists (`loadFloorModel()`)
- ✅ ProductType.cabinet defined but currently disabled in UI
- ✅ Cabinet assets in Asset catalog (cabinet.png, cabinetIcon.png)
- ✅ Materials dictionary system with "baked"/"unbaked" keys
- ✅ RealityKit content bundle loading system

### Missing Components
- ❌ Cabinet items in itemList.json (currently empty)
- ❌ Cabinet models in RealityKit content bundle
- ❌ UI to enable cabinet selection (currently disabled)
- ❌ Cabinet-to-floor mapping logic

## Implementation Steps

### Phase 1: Data & Assets Setup

#### 1.1 Update itemList.json
```json
{
  "productId": 2,
  "type": "cabinet",
  "items": [
    {
      "id": 101,
      "name": "Modern White Cabinet",
      "description": "Sleek white cabinets with minimalist design",
      "thumbnailUrl": "cabinet_white_thumb",
      "asset": "ModernWhiteCabinet",
      "materials": {
        "baked": "WhiteCabinet_floor",
        "unbaked": "WhiteCabinet_floor_clean"
      }
    },
    {
      "id": 102,
      "name": "Dark Wood Cabinet",
      "description": "Rich dark wood cabinet with traditional styling",
      "thumbnailUrl": "cabinet_dark_thumb", 
      "asset": "DarkWoodCabinet",
      "materials": {
        "baked": "DarkWoodCabinet_floor",
        "unbaked": "DarkWoodCabinet_floor_clean"
      }
    }
  ]
}
```

#### 1.2 Create Cabinet Models in RealityKit Content Bundle
- Create cabinet floor models: `WhiteCabinet_floor.usdz`, `DarkWoodCabinet_floor.usdz`
- Create clean versions: `WhiteCabinet_floor_clean.usdz`, `DarkWoodCabinet_floor_clean.usdz`
- Models should be optimized for floor use (flat, textured surfaces)

#### 1.3 Update Assets Catalog
- Add cabinet thumbnail images
- Ensure `cabinetIcon.png` is properly configured

### Phase 2: Model Layer Updates

#### 2.1 Extend AppModel.swift
```swift
// Add cabinet-specific state
@State private var selectedCabinetStyle: CabinetStyle?
@State private var isUsingCabinetAsFloor: Bool = false

// Cabinet selection method
func selectCabinetAsFloor(_ cabinetItem: PItemDetail) {
    currentDetailItem = cabinetItem
    currentFloorAsset = cabinetItem.asset
    isUsingCabinetAsFloor = true
    loadFloorModel()
}

// Reset to regular floor
func resetToRegularFloor() {
    isUsingCabinetAsFloor = false
    // Load default floor or previous selection
}
```

#### 2.2 Update Products.swift (if needed)
- Ensure Cabinet ProductType is properly handled
- Add any cabinet-specific metadata structures

### Phase 3: UI Layer Updates

#### 3.1 Enable Cabinet Tab in FloorView.swift
```swift
// Remove .disabled(true) from cabinet tab
TabButton(title: "Cabinets", type: .cabinet, selectedTab: $selectedTab)
// .disabled(true)  // Remove this line
```

#### 3.2 Update FloorView Logic
```swift
.onChange(of: selectedTab) { oldValue, newValue in
    model.updateCurrentProduct(newValue)
    
    // Handle cabinet selection
    if newValue == .cabinet {
        // Load cabinet items instead of floor items
        model.loadCabinetItems()
    }
}
```

#### 3.3 Update ProductCell/ProductCell2
- Add cabinet-specific styling
- Add "Use as Floor" button for cabinet items
- Handle cabinet selection events

### Phase 4: Immersive View Integration

#### 4.1 Update SecondImmersiveView.swift
```swift
// Add cabinet-specific loading in loadFloorModel()
private func loadFloorModel() {
    Task {
        // Check if current selection is a cabinet
        if appModel.isUsingCabinetAsFloor,
           let cabinetAsset = appModel.currentDetailItem?.asset {
            loadCabinetModel(cabinetAsset)
        } else {
            loadRegularFloorModel()
        }
    }
}

private func loadCabinetModel(_ cabinetAsset: String) {
    if let newCabinetEntity = try? await Entity(named: cabinetAsset, in: realityKitContentBundle) {
        // Remove existing floor
        if let oldFloor = floorEntity {
            rootAnchor.removeChild(oldFloor)
            oldFloor.removeFromParent()
            oldFloor.components.removeAll()
        }
        
        // Add new cabinet-as-floor
        newCabinetEntity.transform.rotation = simd_quatf(angle: .pi * 115 / 180, axis: [0, 1, 0])
        rootAnchor.addChild(newCabinetEntity)
        floorEntity = newCabinetEntity
    }
}
```

#### 4.2 Add Cabinet Floor Indicator
- Show visual indicator when cabinet is being used as floor
- Add toggle to switch back to regular floors

### Phase 5: User Experience Enhancements

#### 5.1 Add Preview Functionality
- Show preview of cabinet as floor before applying
- Add smooth transition animations

#### 5.2 Cabinet-to-Floor Gallery
- Create dedicated view showing all cabinets available as floors
- Add filtering and search capabilities

#### 5.3 Integration with Existing Features
- Ensure cabinet floors work with wall color changes
- Maintain furniture toggle functionality
- Preserve teleportation and UI positioning

### Phase 6: Analytics & Testing

#### 6.1 Add Analytics Events
```swift
// Track cabinet-to-floor usage
TrackEvents.cabinetFloorSelected.record(
    username: username,
    pagePath: "immersive_space",
    trackData: ["cabinetName": cabinetName]
)
```

#### 6.2 Testing Strategy
- Test cabinet loading performance
- Verify visual quality of cabinet floors
- Test transition between cabinet and regular floors
- Validate memory usage with multiple cabinet models

## Technical Considerations

### Performance Optimization
- Lazy loading of cabinet models
- Texture compression for cabinet floor materials
- Memory management for unused cabinet assets

### Visual Quality
- Ensure cabinet textures work well as floor materials
- Maintain consistent lighting and shading
- Optimize UV mapping for floor application

### User Interface
- Clear indication when cabinet is active as floor
- Easy switching between cabinet and regular floors
- Consistent with existing floor selection UX

## File Modifications Summary

### Files to Create/Modify:
1. **Models:**
   - `AppModel.swift` - Add cabinet state and methods
   - `Products.swift` - Update if needed for cabinet metadata

2. **Views:**
   - `FloorView.swift` - Enable cabinet tab, add cabinet handling
   - `ProductCell.swift` - Add cabinet-specific UI
   - `SecondImmersiveView.swift` - Add cabinet floor loading

3. **Resources:**
   - `itemList.json` - Add cabinet items
   - RealityKit Content Bundle - Add cabinet floor models
   - Assets.xcassets - Add cabinet thumbnails

4. **Configuration:**
   - Enable cabinet tab functionality
   - Update routing logic for cabinet selection

## Success Metrics
- Users can successfully select cabinet styles from FloorView
- Selected cabinets render properly as floor materials in immersive view
- Smooth transitions between cabinet and regular floor modes
- No performance degradation with cabinet models loaded
- Intuitive user experience for cabinet-to-floor swapping

## Timeline Estimate
- **Phase 1-2:** 2-3 days (Data setup, model creation)
- **Phase 3:** 1-2 days (UI updates)
- **Phase 4:** 2-3 days (Immersive view integration)
- **Phase 5:** 1-2 days (UX enhancements)
- **Phase 6:** 1 day (Testing, analytics)

**Total estimated effort: 7-11 days**
