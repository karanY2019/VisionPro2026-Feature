//
//  WhiteDotUI.swift
//  Floor
//
//  Created by Scuuu on 2025/2/2.
//

import SwiftUI

struct WhiteDotUI: View {
    
    var onPress: () -> Void = {}
    
    var body: some View {
        VStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 40, height: 40)
        }
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 40)
        )
        .frame(width: 40, height: 40)
    }
}
