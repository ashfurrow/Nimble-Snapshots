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
        assert(version.majorVersion == 9 && version.minorVersion == 3 ,
                 "The tests should be run on iOS 9.x, not \(version.majorVersion), \(version.minorVersion)");

        let nativeResolution = UIScreen.mainScreen().nativeBounds.size;
        assert(UIDevice.currentDevice().userInterfaceIdiom == .Phone && CGSizeEqualToSize(nativeResolution, CGSizeMake(640, 960)),
                 "The tests should be run on an iPhone 6, not a device with native resolution \(NSStringFromCGSize(nativeResolution))");

        return true
    }
}

