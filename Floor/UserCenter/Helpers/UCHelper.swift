//
//  UCHelper.swift
//  Floor
//
//  Created by Ryan Zhang on 2025/6/27.
//

import Foundation

class UCHelper {
    
    /// 验证字符串是否符合要求：长度在4-20之间，且只包含数字或字母
    /// - Parameter string: 要验证的字符串
    /// - Returns: 是否符合要求
    static func validateUserName(_ string: String) -> Bool {
        // 检查长度是否在4-20之间
        guard string.count >= 4 && string.count <= 20 else {
            return false
        }
        
        // 检查是否只包含数字或字母（不区分大小写）
        let pattern = "^[a-zA-Z0-9]+$"
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: string.utf16.count)
        
        return regex?.firstMatch(in: string, range: range) != nil
    }
    
    static func validateGeneralName(_ string: String) -> Bool {
        // 检查长度是否大于等于1
        guard string.count >= 1 else {
            return false
        }
        
        // 检查是否只包含英文字母（不区分大小写）
        let pattern = "^[a-zA-Z]+$"
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: string.utf16.count)
        
        return regex?.firstMatch(in: string, range: range) != nil
    }
    
    static func validateEmailFormat(_ string: String) -> Bool {
        if string.isEmpty {
            return true
        }
        // 邮箱格式验证：xxxx@yyy.com
        let emailPattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"
        let regex = try? NSRegularExpression(pattern: emailPattern)
        let range = NSRange(location: 0, length: string.utf16.count)
        
        return regex?.firstMatch(in: string, range: range) != nil
    }
    
}
