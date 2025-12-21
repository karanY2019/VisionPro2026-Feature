//
//  Router.swift
//  Floor
//
//  Created by Ryan Zhang on 2024/12/29.
//

import Foundation

enum Router: String, Identifiable, CaseIterable, Equatable {
    case category, floor, stairs, door, cabinet, detail, virtualHome
    var id: Self { self }
    var name: String { rawValue.capitalized }
}

enum AccountPath: String, Identifiable, CaseIterable, Equatable {
    case login, register, forgetpwd, registerSuccess, account
    var id: Self { self }
    var name: String { rawValue.capitalized }
}

enum QueryDetailPath: String, Identifiable, CaseIterable, Equatable {
    case normal, userCenter
    var id: Self { self }
    var name: String { rawValue.capitalized }
}

enum BizTab: Int, Identifiable, CaseIterable, Equatable {
    case home, profile
    var id: Self { self }
}
