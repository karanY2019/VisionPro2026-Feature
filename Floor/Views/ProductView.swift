//
//  ProductView.swift
//  Floor
//
//  Created by Ryan Zhang on 2024/12/29.
//

import SwiftUI

struct ProductView: View {
    
    var type: Router = .floor
    
    var body: some View {
        ZStack {
            if type == .floor {
                FloorView()
            }
        }
    }
}

#Preview {
    ProductView()
}
