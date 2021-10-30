//
//  AppDelegate.swift
//  Dogedex
//
//  Created by rafael.rollo on 28/10/21.
//

import UIKit
import AlamofireImage

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        configureAlamofireSharedImageDownloader()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

// MARK: - AlamofireImage's cache customization
extension AppDelegate {
    
    private func urlCacheConfiguration() -> URLCache {
        let configuration = ImageDownloader.defaultURLCache()
        configuration.memoryCapacity = .zero
        return configuration
    }
    
    private func customSessionConfiguration() -> URLSessionConfiguration {
        let configuration = ImageDownloader.defaultURLSessionConfiguration()
        configuration.urlCache = urlCacheConfiguration()
        return configuration
    }
    
    /// Provide custom ImageDownloader cache configuration.
    ///
    ///     The AlamofireImage documentation advises to:
    ///
    ///     "If you do not use image filters, it is advised to set the memory capacity
    ///     of the URLCache to zero. Otherwise, you will be storing the original image
    ///     data in both the URLCache's in-memory store as well as the AlamofireImage
    ///     in-memory store."
    ///
    ///     .. so, this extension provides a custom ImageDownloader configuration in order to avoid the related issue.
    ///
    ///     With the default provided configurations were observed a memory usage superior of 500MB on scrolling in
    ///     a bunch for past pictures and accessing the HD version in the detailed apod scene. After the creation of the
    ///     customized one, backed only by Alamofire's auto purging in-memory cache, the memory usage was reduced
    ///     for numbers about 100 to 150MB even when scrolling deeply.
    ///
    /// [See docs](https://github.com/Alamofire/AlamofireImage#setting-ideal-capacity-limits)
    ///
    private func configureAlamofireSharedImageDownloader() {
        let customImageDownloader = ImageDownloader(
            configuration: customSessionConfiguration(),
            downloadPrioritization: .fifo,
            maximumActiveDownloads: 3,
            imageCache: AutoPurgingImageCache(
                memoryCapacity: 120_000_000,
                preferredMemoryUsageAfterPurge: 60_000_000
            )
        )
        
        UIImageView.af.sharedImageDownloader = customImageDownloader
        
        debugPrint("AlamofireImageConfiguration: Using the custom shared image downloader configuration")
    }
    
}
