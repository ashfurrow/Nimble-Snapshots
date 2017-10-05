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

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // There are device specific tests, so we need to be tight on the devices running tests

        let version = ProcessInfo.processInfo.operatingSystemVersion
        let minVersion = OperatingSystemVersion(majorVersion: 9, minorVersion: 3, patchVersion: 0)
        assert(ProcessInfo.processInfo.isOperatingSystemAtLeast(minVersion),
                 "The tests should be run at least on iOS 9.3, not \(version.majorVersion), \(version.minorVersion)")

        let nativeResolution = UIScreen.main.nativeBounds.size
        assert(isExpectedDevice(nativeResolution: nativeResolution),
               "The tests should be run on an iPhone 6, not a device with " +
               "native resolution \(NSStringFromCGSize(nativeResolution))")

        return true
    }

    func isExpectedDevice(nativeResolution: CGSize) -> Bool {
        return UIDevice.current.userInterfaceIdiom == .phone &&
            nativeResolution == CGSize(width: 750, height: 1334)
    }
}
