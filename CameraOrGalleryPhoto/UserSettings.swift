//
//  UserSettings.swift
//  StickPlan
//
//  Created by Rudolf Farkas on 15.03.20.
//  Copyright © 2020 Eric PAJOT. All rights reserved.
//

import CoreLocation
import UIKit

/// define defaults
/// for storage in sharedDefaults (shared between SHARE apps)
// enum SharedUserDefaults {
//    enum Key: String {
//        case calendarTitles
//        case selectedCalendarTitle
//    }
//
//    // shared store
//    static let sharedDefaults = UserDefaults(suiteName: "group.com.share-telematics.calshare")!
//
//    @CodableUserDefault(key: Key.calendarTitles,
//                        defaultValue: [],
//                        userDefaults: sharedDefaults)
//    static var calendarTitles: [String]
//
//    @CodableUserDefault(key: Key.selectedCalendarTitle,
//                        defaultValue: "Select a calendar...",
//                        userDefaults: sharedDefaults)
//    static var selectedCalendarTitle: String
// }

struct ResourceData: Codable {
    var calendarTitle: String = ""
    var email: String = ""
    var price: String = ""
    var currency: String = ""
    var options: Int = 0
    var longitude: CLLocationDegrees?
    var latitude: CLLocationDegrees?

    private var imageData: Data?
    var image: UIImage? {
        set {
            imageData = newValue?.pngData()
        }
        get {
            if imageData != nil {
                return UIImage(data: imageData!)
            }
            return nil
        }
    }

    var string: String {
        var strs = [String]()
        strs.append("calendarTitle= \(calendarTitle)")
        strs.append("email= \(email)")
        strs.append("price= \(price)")
        strs.append("currency= \(currency)")
        strs.append("options= \(options)")
        strs.append("longitude= \(String(describing: longitude))")
        strs.append("latitude= \(String(describing: latitude))")
        return strs.joined(separator: ", ")
    }
}

/// define defaults
/// for storage in UserDefaults.standard (local to the app)
enum LocalUserDefaults {
    // define keys to defaults
    enum Key: String {
//        case isSignedIn
//        case productCurrencySymbol
//        case qrCodeCorrectionLevel
        case resourceDataArray
//        case subscriptionInfo
//        case testing_ignorePreviousAppleSignIn
//        case testing_ignoreSavedAcceptance
//        case testing_ignoreSavedSubscriptionInfo
//        case userTermsAccepted
    }

    static func resourceData(for calendar: String) -> ResourceData? {
        return LocalUserDefaults.resourceDataArray.first { $0.calendarTitle == calendar }
    }

    static func update(from resourceData: ResourceData, for calendar: String) {
        if let index = LocalUserDefaults.resourceDataArray.firstIndex(where: { $0.calendarTitle == calendar }) {
            LocalUserDefaults.resourceDataArray[index] = resourceData
        } else {
            LocalUserDefaults.resourceDataArray.append(resourceData)
        }
    }

//    @CodableUserDefault(key: Key.isSignedIn, defaultValue: false)
//    static var isSignedIn: Bool
//
//    @CodableUserDefault(key: Key.userTermsAccepted, defaultValue: false)
//    static var userTermsAccepted: Bool
//
//    @CodableUserDefault(key: Key.subscriptionInfo, defaultValue: SubscriptionInfo())
//    static var subscriptionInfo: SubscriptionInfo
//
//    @CodableUserDefault(key: Key.productCurrencySymbol, defaultValue: "")
//    static var productCurrencySymbol: String

    @CodableUserDefault(key: Key.resourceDataArray, defaultValue: [])
    static var resourceDataArray: [ResourceData]

    // use PlistUserDefault for these 3 settings, for compatibility with Root.plist settings

    // testing_ignorePreviousAppleSignIn

//    @PlistUserDefault(key: Key.testing_ignorePreviousAppleSignIn, defaultValue: false)
//    static var ignorePreviousAppleSignIn: Bool
//
//    @PlistUserDefault(key: Key.testing_ignoreSavedSubscriptionInfo, defaultValue: false)
//    static var ignorSavedSubscriptionInfo: Bool
//
//    @PlistUserDefault(key: Key.testing_ignoreSavedAcceptance, defaultValue: false)
//    static var ignoreSavedAcceptance: Bool
}
