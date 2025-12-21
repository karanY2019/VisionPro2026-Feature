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
    
    @State private var videoHasCompleted = false
    
    @Environment(AppModel.self) private var model
    
    var body: some View {
        RealityView { content in
            
        } update: { content in
            guard !videoHasCompleted else { return }

            let titleVideoEntity = Entity()
            let titlePlayer = AVPlayer(url: Bundle.main.url(forResource: "launch", withExtension: "mov")!)
            let titlePlayerComponent = VideoPlayerComponent(avPlayer: titlePlayer)
            titleVideoEntity.components.set(titlePlayerComponent)
            
            #if !targetEnvironment(simulator)
            guard let currentDeviceTransform = currentDeviceAnchor?.originFromAnchorTransform else {
                return
            }
            let videoPosition = SIMD3(.init(x: currentDeviceTransform.columns.3.x,
                                            y: currentDeviceTransform.columns.3.y - 0.09),
                                      currentDeviceTransform.columns.3.z - 1.5)
            titleVideoEntity.setPosition(videoPosition, relativeTo: nil)
            #else
            titleVideoEntity.setPosition(.init(x: 0, y: 1.5, z: -1.5), relativeTo: nil)
             #endif
            
            content.add(titleVideoEntity)
            
            titlePlayer.play()
            debugPrint("[Launch] Played!")
        }
        .task {
            guard !model.hasLaunched else{
                await completeLaunch()
                return
            }
            let worldTracker = WorldTrackingProvider()
            if WorldTrackingProvider.isSupported {
                do {
                    try await arKitSession.run([worldTracker])
                    var timeWaited = 0.0
                    while timeWaited < 3.0, worldTracker.state != .running {
                        try? await Task.sleep(for: .seconds(0.1))
                        timeWaited += 0.1
                    }
                    currentDeviceAnchor = worldTracker.queryDeviceAnchor(atTimestamp: CACurrentMediaTime())
                    if currentDeviceAnchor == nil {
                        await completeLaunch()
                    }
                } catch {
                    print("ARKit session error \(error)")
                    await completeLaunch()
                }
            }
        }
        .onAppear {
             NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime,
                                                    object: nil,
                                                    queue: .main) { _ in
                 Task { @MainActor in
                     try? await Task.sleep(for: .seconds(0.1))
                     videoHasCompleted = true
                 }
                 print("launch video completed")
             }
         }
        .onChange(of: videoHasCompleted) { oldValue, newValue in
            guard oldValue != newValue else { return }
            Task {
                await completeLaunch()
            }
        }
    }
    
    private func completeLaunch() async {
        model.hasLaunched = true
        // open main window
        openWindow(id: "MainWindow")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            Task {
                if model.launchSpaceState == .open {
                    await dismissImmersiveSpace()
                }
            }
        }
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
