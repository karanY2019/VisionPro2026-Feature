//
//  LocationPickerView.swift
//  Floor
//
//  Created by Ryan Zhang on 2025/6/20.
//

import SwiftUI

// MARK: - Location Picker View
struct LocationPickerView: View {
    let locations: [String]
    @Binding var selectedLocation: String
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            List(locations, id: \.self) { location in
                Button(action: {
                    selectedLocation = location
                    isPresented = false
                }) {
                    HStack {
                        Text(location)
                            .foregroundColor(.primary)
                        Spacer()
                        if location == selectedLocation {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            .navigationTitle("Select Location")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: Button("Cancel") {
                    isPresented = false
                }
            )
        }
    }
}
