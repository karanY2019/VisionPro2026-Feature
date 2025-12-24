# Cabinet Material Modification MVP - Quick Implementation

## Overview
Instead of creating new cabinet models or using cabinets as floors, modify the existing kitchen cabinets within the house models by changing colors and textures.

## Current Assets Available
- **House Model**: `/Packages/RealityKitContent/Sources/RealityKitContent/RealityKitContent.rkassets/House.usdz`
- **Royalwood Model**: `/Packages/RealityKitContent/Sources/RealityKitContent/RealityKitContent.rkassets/Royalwood_1226.usdz`
- Both models contain kitchen cabinets that can be modified

## Quick MVP Implementation Plan

### Phase 1: Cabinet Entity Detection (30 minutes)

#### 1.1 Find Cabinet Entities in House Models
```swift
func findCabinetEntities(in houseEntity: Entity) -> [Entity] {
    var cabinets: [Entity] = []
    
    // Search for cabinet-related entities
    func searchEntity(_ entity: Entity) {
        let cabinetKeywords = ["cabinet", "kitchen", "cupboard", "upper", "lower"]
        let entityName = entity.name.lowercased()
        
        for keyword in cabinetKeywords {
            if entityName.contains(keyword) {
                cabinets.append(entity)
                break
            }
        }
        
        for child in entity.children {
            searchEntity(child)
        }
    }
    
    searchEntity(houseEntity)
    return cabinets
}
```

#### 1.2 Update SecondImmersiveView.swift
```swift
// Add cabinet detection in RealityView setup
Task {
    if let houseEntity = try? await Entity(named: "House0912", in: realityKitContentBundle) {
        let cabinets = findCabinetEntities(in: houseEntity)
        print("Found \(cabinets.count) cabinet entities")
        
        for cabinet in cabinets {
            print("Cabinet: \(cabinet.name)")
            if let modelComponent = cabinet.components[ModelComponent.self] {
                print("Materials: \(modelComponent.materials.count)")
            }
        }
    }
}
```

### Phase 2: Material Modification System (1 hour)

#### 2.1 Add Cabinet Material State
```swift
// In AppModel.swift
@State private var currentCabinetMaterial: CabinetMaterial = .default
@State private var availableCabinetMaterials: [CabinetMaterial] = [
    .default,
    .whiteMatte,
    .woodGrain,
    .darkWalnut,
    .grayModern
]

// Cabinet material definition
struct CabinetMaterial: Identifiable {
    let id = UUID()
    let name: String
    let color: CGColor
    let texture: String?
    let roughness: Float
    let metallic: Float
}
```

#### 2.2 Create Cabinet Material Modifier
```swift
// In SecondImmersiveView.swift
func updateCabinetMaterials(_ material: CabinetMaterial) {
    guard let houseEntity = rootAnchor.findEntity(named: "houseEntity") else { return }
    
    let cabinets = findCabinetEntities(in: houseEntity)
    
    for cabinet in cabinets {
        if var modelComponent = cabinet.components[ModelComponent.self] {
            var updatedMaterials = modelComponent.materials
            
            for (index, _) in updatedMaterials.enumerated() {
                if var shader = updatedMaterials[index] as? ShaderGraphMaterial {
                    // Update cabinet color
                    try? shader.setParameter(name: "cabinetColor", value: .color(material.color))
                    
                    // Update material properties
                    try? shader.setParameter(name: "roughness", value: .float(material.roughness))
                    try? shader.setParameter(name: "metallic", value: .float(material.metallic))
                    
                    updatedMaterials[index] = shader
                } else {
                    // Fallback to UnlitMaterial for non-shader materials
                    var unlitMaterial = UnlitMaterial()
                    unlitMaterial.color = .init(tint: .init(material.color))
                    updatedMaterials[index] = unlitMaterial
                }
            }
            
            var newModelComponent = modelComponent
            newModelComponent.materials = updatedMaterials
            cabinet.components.set(newModelComponent)
        }
    }
    
    print("Updated \(cabinets.count) cabinet materials to \(material.name)")
}
```

### Phase 3: UI for Cabinet Material Selection (1 hour)

#### 3.1 Create Cabinet Material Selector View
```swift
struct CabinetMaterialSelector: View {
    @Environment(AppModel.self) private var appModel
    let materials: [CabinetMaterial]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(materials) { material in
                    VStack {
                        Circle()
                            .fill(Color(cgColor: material.color))
                            .frame(width: 60, height: 60)
                            .overlay(
                                Circle()
                                    .stroke(appModel.currentCabinetMaterial.id == material.id ? 
                                           Color.white : Color.clear, lineWidth: 3)
                            )
                        
                        Text(material.name)
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                    .onTapGesture {
                        appModel.currentCabinetMaterial = material
                        // Update immersive view
                        NotificationCenter.default.post(
                            name: .cabinetMaterialChanged, 
                            object: material
                        )
                    }
                }
            }
            .padding()
        }
    }
}
```

#### 3.2 Add Cabinet Material Attachment to Immersive View
```swift
// In SecondImmersiveView.swift RealityView attachments:
Attachment(id: "CabinetMaterialSelector") {
    CabinetMaterialSelector(materials: appModel.availableCabinetMaterials)
        .glassBackgroundEffect(displayMode: .always)
        .frame(width: 300, height: 100)
}
```

### Phase 4: Integration with Existing System (30 minutes)

#### 4.1 Add Observer for Material Changes
```swift
// In SecondImmersiveView.swift
.onReceive(NotificationCenter.default.publisher(for: .cabinetMaterialChanged)) { notification in
    if let material = notification.object as? CabinetMaterial {
        updateCabinetMaterials(material)
    }
}
```

#### 4.2 Add Cabinet Material to AppModel
```swift
// In AppModel.swift
.onChange(of: currentCabinetMaterial) { newMaterial in
    NotificationCenter.default.post(
        name: .cabinetMaterialChanged,
        object: newMaterial
    )
}
```

## Implementation Steps

### Step 1: Entity Detection (15 minutes)
1. Add cabinet search function to SecondImmersiveView.swift
2. Test by loading house model and printing cabinet entity names
3. Verify material components are accessible

### Step 2: Basic Material Update (30 minutes)
1. Create simple color modification function
2. Test updating cabinet materials with solid colors
3. Verify changes appear in immersive view

### Step 3: UI Creation (45 minutes)
1. Create CabinetMaterialSelector view
2. Add predefined cabinet materials (white, wood, dark, etc.)
3. Add selector attachment to immersive view

### Step 4: Integration (30 minutes)
1. Connect UI to material update system
2. Add state management in AppModel
3. Test end-to-end functionality

## Technical Considerations

### Material Parameter Names
Different house models may use different shader parameter names:
- `cabinetColor`
- `baseColor`
- `diffuseColor`
- `albedoColor`

### Fallback Strategy
1. Try common parameter names for shader materials
2. Fall back to UnlitMaterial for simple color changes
3. Log any parameter names that work for future reference

### Performance
- Only update materials when user selects new cabinet style
- Cache material objects to avoid recreation
- Update only cabinet entities, not entire house

## Expected Results

### User Experience
1. User enters immersive view with existing house
2. Sees cabinet material selector floating nearby
3. Can tap different materials to instantly change cabinet colors/textures
4. Changes apply immediately to all cabinets in the house
5. Can switch between different cabinet styles (white, wood grain, dark walnut, etc.)

### Technical Benefits
- **No new 3D models needed**: Uses existing optimized assets
- **Instant application**: Material changes are immediate
- **Performance efficient**: Only shader parameter updates
- **Flexible**: Easy to add new cabinet materials
- **Realistic use case**: Modifying existing kitchen cabinets

## Next Steps After MVP

### Enhanced Materials
1. Add texture mapping for wood grain patterns
2. Include cabinet hardware (handles, knobs) modification
3. Add different cabinet styles (modern, traditional, etc.)

### Advanced Features
1. Per-cabinet selection (upper vs lower cabinets)
2. Cabinet door vs drawer differentiation
3. Save/load cabinet material preferences

## Time Estimate
**Total Implementation Time: 2-3 hours**

This is significantly faster than the cabinet-to-floor approach because:
- Uses existing 3D models
- Simple material parameter changes
- No model loading/unloading
- Direct integration with existing house models

This approach provides immediate value with minimal development effort and creates a more realistic user experience for cabinet customization.
