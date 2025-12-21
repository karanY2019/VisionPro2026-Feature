//
//  GlobalState.swift
//  Floor
//
//  Created by Ryan Zhang on 2024/12/21.
//

import Foundation

@MainActor
@Observable
class GlobalState {
    static var shared = GlobalState()
}
