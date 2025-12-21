//
//  ToggleImmersiveSpaceButton.swift
//  Floor
//
//  Created by Ryan Zhang on 2024/12/21.
//

import SwiftUI

struct ToggleImmersiveSpaceButton: View {

    @Environment(AppModel.self) private var appModel

    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissWindow) private var dismissWindow
    @Environment(\.openWindow) private var openWindow

//    var onImmersiveSpaceOpened: () -> Void = {}
    
    var body: some View {
        Button {
            Task { @MainActor in
                switch appModel.immersiveSpaceState {
                    case .open:
                        appModel.immersiveSpaceState = .inTransition
                        await dismissImmersiveSpace()
//                        appModel.virtualHomeViewVisible = true
                        // Don't set immersiveSpaceState to .closed because there
                        // are multiple paths to ImmersiveView.onDisappear().
                        // Only set .closed in ImmersiveView.onDisappear().

                    case .closed:
                        appModel.immersiveSpaceState = .inTransition
                    switch await openImmersiveSpace(id: appModel.currentImmersiveSpaceID) {
                            case .opened:
                                // Don't set immersiveSpaceState to .open because there
                                // may be multiple paths to ImmersiveView.onAppear().
                                // Only set .open in ImmersiveView.onAppear().
//                                onImmersiveSpaceOpened()
                            dismissWindow(id: "MainWindow")
                            appModel.isMainWindowVisible = false
                            openWindow(id: "ImmersiveSpaceMainWindow")


                                break

                            case .userCancelled, .error:
                                // On error, we need to mark the immersive space
                                // as closed because it failed to open.
                                fallthrough
                            @unknown default:
                                // On unknown response, assume space did not open.
                                appModel.immersiveSpaceState = .closed
                        }

                    case .inTransition:
                        // This case should not ever happen because button is disabled for this case.
                        break
                }
            }
        } label: {
//            Text(appModel.immersiveSpaceState == .open ? "Hide Immersive Space" : "Show Immersive Space")
            
            Text(appModel.immersiveSpaceState == .open ? "Exit Virtual Home" :"Enter Virtual Home")
                .font(.system(size: 20))
                .bold()
                .foregroundColor(.black)
                .frame(width: 260, height: 60)
                .background(
                    Color(red: 0.84, green: 0.84, blue: 0)
                )
                .cornerRadius(40)
        }
        .buttonStyle(.plain)
        .padding(.bottom, -20)
        .disabled(appModel.immersiveSpaceState == .inTransition)
        .animation(.none, value: 0)
        .fontWeight(.semibold)
    }
}
