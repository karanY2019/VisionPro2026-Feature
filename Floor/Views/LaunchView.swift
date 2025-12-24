//
//  LaunchView.swift
//  Floor
//
//  Created by Ryan Zhang on 2025/3/5.
//

import Foundation
import SwiftUI
import RealityKit
import ARKit
import AVKit

fileprivate let launchViewAttachmentID = "launchViewAttachment"

@MainActor
struct LaunchSpace: View {
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    
    @State private var arKitSession = ARKitSession()
    @State private var currentDeviceAnchor: DeviceAnchor?
    
    // Video functionality disabled - set to true to skip video
    @State private var videoSkipped = true
    @State private var isLaunching = false
    
    @Environment(AppModel.self) private var model
    
    var body: some View {
        RealityView { content in
            
        } update: { content in
            // Video functionality completely commented out
            // App now waits for user to click Start button
        }
        
        // Add Start button overlay
        VStack {
            Spacer()
            
            VStack(spacing: 20) {
                Text("Welcome to Floor")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("Tap Start to begin your journey")
                    .font(.title2)
                    .foregroundColor(.white.opacity(0.8))
                
                Button(action: {
                    handleStartButtonTap()
                }) {
                    if isLaunching {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.2)
                    } else {
                        Text("START")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
                .frame(width: 200, height: 60)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(isLaunching ? Color.gray.opacity(0.8) : Color.blue.opacity(0.8))
                        .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
                )
                .buttonStyle(PlainButtonStyle())
                .disabled(isLaunching)
                .padding(.top, 20)
            }
            .padding(40)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.black.opacity(0.3))
                    .blur(radius: 10)
            )
            
            Spacer()
        }
        .padding()
        
        // Disable automatic launch - wait for user interaction
        .task {
            // Only check if already launched, don't auto-launch
            guard !model.hasLaunched else {
                print("🔄 App already launched, skipping...")
                return
            }
            print("⏳ LaunchView: Waiting for user to tap Start button...")
        }
    }
    
    private func handleStartButtonTap() {
        print("🚀 Start button tapped by user")
        isLaunching = true
        
        // Set hasLaunched to true immediately
        model.hasLaunched = true
        print("✅ LaunchView: Set hasLaunched to true")
        
        // Open main window
        print("🪟 LaunchView: Opening MainWindow...")
        openWindow(id: "MainWindow")
        print("✅ LaunchView: MainWindow opened")
        
        // Note: Not dismissing immersive space to avoid kernel conflicts
        // The user can close it manually or it will close when app transitions
        print("ℹ️ LaunchView: Immersive space will remain open for user control")
    }
    
    func run(function: () async -> Void, withFrequency hz: UInt64) async {
        while true {
            if Task.isCancelled {
                return
            }
            
            // Sleep for 1 s / hz before calling the function.
            let nanoSecondsToSleep: UInt64 = NSEC_PER_SEC / hz
            do {
                try await Task.sleep(nanoseconds: nanoSecondsToSleep)
            } catch {
                // Sleep fails when the Task is cancelled. Exit the loop.
                return
            }
            
            await function()
        }
    }
}
