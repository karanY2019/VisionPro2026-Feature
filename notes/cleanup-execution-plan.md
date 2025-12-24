# VisionPro APP26 - Cleanup Execution Plan

## Recommended Model Set for SecondImmersiveView
```
3D Models to KEEP:
├── House0912          # Main house structure  
├── Furnitures         # Furniture models
├── HexChangeWallColor # Wall color system
└── skybox            # Environment
```

## CLEANUP TODO LIST

### Phase 1: Remove Duplicate Immersive View
- [ ] Delete ImmersiveView.swift (duplicate of SecondImmersiveView)
- [ ] Update navigation references to use SecondImmersiveView only

### Phase 2: Remove Large Texture Collections (~161MB savings)
- [ ] Delete T02BL_* (32MB total)
- [ ] Delete T04PL_* (31MB total)
- [ ] Delete T05LS_* (32MB total)
- [ ] Delete T06NV_* (32MB total)
- [ ] Delete T07LC_* (34MB total)

### Phase 3: Remove Floor Photo Collections (~37MB savings)
- [ ] Delete Margot_* collection
- [ ] Delete Minori_* collection
- [ ] Delete Silver Creek_* collection
- [ ] Delete Naples_* collection
- [ ] Delete Vicenza_* collection
- [ ] Delete Lavinia_* collection
- [ ] Delete Freya_* collection
- [ ] Delete Burano_* collection
- [ ] Delete Tropea_* collection

### Phase 4: Remove Individual Floor Images (~2.5MB savings)
- [ ] Delete Skyline-1.jpg
- [ ] Delete Seren-1.jpg
- [ ] Delete Rosalind-1.jpg
- [ ] Delete Ophelia-1.jpg
- [ ] Delete GoldenBeach-1.jpg
- [ ] Delete Francisco-1.jpg
- [ ] Delete Cosima-1.jpg
- [ ] Delete Bari-1.jpg
- [ ] Delete Aveline-1.jpg

### Phase 5: Remove Video & Unused Models
- [ ] Delete launch.mov (868KB)
- [ ] Check and remove Royalwood_1226 model (if unused)

### Phase 6: Verify & Test
- [ ] Verify SecondImmersiveView still works
- [ ] Test build time improvement
- [ ] Confirm all essential functionality preserved

---

**Expected Total Savings: ~200MB**
**Expected Build Time Improvement: 70-80% faster**

---

*Generated: 2025-12-21 | Cleanup Execution Plan*
