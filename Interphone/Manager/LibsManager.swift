//
//  LibsManager.swift
//  Ramen
//
//  Created by Duc Do on 2/20/20.
//  Copyright © 2020 goodcreate. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Kingfisher
import NVActivityIndicatorView
import KafkaRefresh

// The manager class for configuring all libraries used in app.
class LibsManager {
    /// The default singleton instance.
    static let shared = LibsManager()
    
    func setupLibs(with window: UIWindow? = nil) {
        let libsManager = LibsManager.shared
//        libsManager.setupCocoaLumberjack()
        libsManager.setupKafkaRefresh()
        libsManager.setupKeyboardManager()
        libsManager.setupActivityView()
    }
    
    func setupKafkaRefresh() {
        if let defaults = KafkaRefreshDefaults.standard() {
            defaults.headDefaultStyle = .animatableRing
            defaults.footDefaultStyle = .animatableRing
            defaults.themeColor = Color.primary
        }
    }
    
    func setupActivityView() {
        NVActivityIndicatorView.DEFAULT_TYPE = .ballRotateChase
        NVActivityIndicatorView.DEFAULT_COLOR = Color.primary
    }
    
    func setupKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    func setupKingfisher() {
        // Set maximum disk cache size for default cache. Default value is 0, which means no limit.
        ImageCache.default.diskStorage.config.sizeLimit = UInt(500 * 1024 * 1024) // 500 MB
        
        // Set longest time duration of the cache being stored in disk. Default value is 1 week
        ImageCache.default.diskStorage.config.expiration = .days(7) // 1 week
        
        // Set timeout duration for default image downloader. Default value is 15 sec.
        ImageDownloader.default.downloadTimeout = 15.0 // 15 sec
    }
    
//    func setupCocoaLumberjack() {
//        DDLog.add(DDOSLogger.sharedInstance)
//        //        DDLog.add(DDASLLogger.sharedInstance) // ASL = Apple System Logs
//
//        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
//        fileLogger.rollingFrequency = TimeInterval(60*60*24)  // 24 hours
//        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
//        DDLog.add(fileLogger)
//    }
}

extension LibsManager {
    
    /// Clear cached images
    ///
    /// - Parameter handler: Closure after removed cache
    func clearImageCache(completion handler: (() -> Void)?) {
        ImageCache.default.clearMemoryCache()
        ImageCache.default.clearDiskCache {
            handler?()
        }
    }
}
