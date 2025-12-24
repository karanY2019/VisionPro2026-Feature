//
//  ConfigManager.swift
//  Floor
//
//  Created by Vision Pro Developer on 2025/1/1.
//

import Foundation

/// Central configuration manager for handling development vs production environments
struct AppConfiguration {
    
    // MARK: - Environment Detection
    /// Automatically detects if app is running in development mode
    static let isDevelopment: Bool = {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }()
    
    // MARK: - Network Configuration
    /// Base URL for API calls
    static var baseURL: String {
        if isDevelopment {
            return "http://localhost:3000/api"  // Local development server
        } else {
            return "https://api.yourproduction.com"  // Production API
        }
    }
    
    /// Base URL for analytics tracking
    static var analyticsBaseURL: String {
        if isDevelopment {
            return "http://localhost:3001/analytics"  // Local analytics
        } else {
            return "https://analytics.yourproduction.com"  // Production analytics
        }
    }
    
    // MARK: - Feature Flags
    /// Enable mock data for development testing
    static var enableMockData: Bool {
        return isDevelopment  // Mock data only in development
    }
    
    /// Enable analytics tracking
    static var enableAnalytics: Bool {
        return !isDevelopment  // Analytics only in production
    }
    
    /// Enable debug logging
    static var enableDebugLogging: Bool {
        return isDevelopment  // Detailed logging only in development
    }
    
    /// Enable crash reporting
    static var enableCrashReporting: Bool {
        return !isDevelopment  // Crash reporting only in production
    }
    
    /// Enable network request logging
    static var enableNetworkLogging: Bool {
        return isDevelopment  // Network logging only in development
    }
    
    // MARK: - Content Configuration
    /// Enable video content in launch sequence
    static var enableLaunchVideo: Bool {
        // Can be controlled by feature flag for testing
        return isDevelopment ? false : true  // Disable video in dev for faster testing
    }
    
    /// Timeout for network requests (seconds)
    static var networkTimeoutInterval: TimeInterval {
        return isDevelopment ? 30.0 : 10.0  // Longer timeout in development
    }
    
    // MARK: - Logging Configuration
    /// Log level for different environments
    static var logLevel: String {
        return isDevelopment ? "debug" : "error"
    }
    
    /// Enable console output
    static var enableConsoleOutput: Bool {
        return isDevelopment
    }
    
    // MARK: - User Interface Configuration
    /// Show development settings in app
    static var showDevelopmentSettings: Bool {
        return isDevelopment  // Only show dev settings in development
    }
    
    /// Enable experimental features
    static var enableExperimentalFeatures: Bool {
        return isDevelopment  // Only enable in development for testing
    }
    
    // MARK: - Cache Configuration
    /// Cache duration for API responses (seconds)
    static var apiCacheDuration: TimeInterval {
        return isDevelopment ? 60.0 : 300.0  // Shorter cache in development
    }
    
    /// Enable image caching
    static var enableImageCaching: Bool {
        return !isDevelopment  // Full caching in production, minimal in dev
    }
    
    // MARK: - Debug Helpers
    /// Print configuration summary to console
    static func printConfiguration() {
        if isDevelopment {
            print("🔧 DEVELOPMENT MODE CONFIGURATION")
            print("   Base URL: \(baseURL)")
            print("   Analytics: \(enableAnalytics ? "ENABLED" : "DISABLED")")
            print("   Mock Data: \(enableMockData ? "ENABLED" : "DISABLED")")
            print("   Debug Logging: \(enableDebugLogging ? "ENABLED" : "DISABLED")")
            print("   Network Logging: \(enableNetworkLogging ? "ENABLED" : "DISABLED")")
            print("   Launch Video: \(enableLaunchVideo ? "ENABLED" : "DISABLED")")
            print("   Show Dev Settings: \(showDevelopmentSettings ? "ENABLED" : "DISABLED")")
        } else {
            print("🚀 PRODUCTION MODE CONFIGURATION")
            print("   Base URL: \(baseURL)")
            print("   Analytics: \(enableAnalytics ? "ENABLED" : "DISABLED")")
            print("   Mock Data: \(enableMockData ? "ENABLED" : "DISABLED")")
            print("   Crash Reporting: \(enableCrashReporting ? "ENABLED" : "DISABLED")")
        }
    }
    
    // MARK: - Environment Validation
    /// Validate that required configuration is present
    static func validateConfiguration() -> Bool {
        guard !baseURL.isEmpty else {
            print("❌ Configuration Error: Base URL is empty")
            return false
        }
        
        guard baseURL.hasPrefix("http://") || baseURL.hasPrefix("https://") else {
            print("❌ Configuration Error: Base URL must start with http:// or https://")
            return false
        }
        
        return true
    }
    
    // MARK: - Development Helpers
    /// Get development mode description
    static var developmentModeDescription: String {
        return isDevelopment ? "Development (Local Testing)" : "Production (Live Environment)"
    }
    
    /// Get build configuration description
    static var buildConfiguration: String {
        #if DEBUG
        return "Debug"
        #elseif RELEASE
        return "Release"
        #elseif PROFILE
        return "Profile"
        #else
        return "Unknown"
        #endif
    }
}
