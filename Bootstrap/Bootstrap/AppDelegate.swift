//
//  AppDelegate.swift
//  Bootstrap
//
//  Created by Ash Furrow on 2014-08-07.
//  Copyright (c) 2014 Artsy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        // There are device specific tests, so we need to be tight on the devices running tests

        let version = NSProcessInfo.processInfo().operatingSystemVersion
        let minVersion = NSOperatingSystemVersion(majorVersion: 9, minorVersion: 3, patchVersion: 0)
        assert(NSProcessInfo.processInfo().isOperatingSystemAtLeastVersion(minVersion),
                 "The tests should be run at least on iOS 9.3, not \(version.majorVersion), \(version.minorVersion)");

        let nativeResolution = UIScreen.mainScreen().nativeBounds.size;
        assert(UIDevice.currentDevice().userInterfaceIdiom == .Phone && CGSizeEqualToSize(nativeResolution, CGSizeMake(640, 960)),
                 "The tests should be run on an iPhone 6, not a device with native resolution \(NSStringFromCGSize(nativeResolution))");

        return true
    }
}

