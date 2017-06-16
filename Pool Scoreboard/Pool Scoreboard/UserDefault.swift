//
//  UserDefault.swift
//  TeaBox
//
//  Created by HarveyHu on 4/14/16.
//  Copyright © 2016 HarveyHu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct UserDefault {
    // DataStatus
    var isNewLounch: Bool {
        get {
            return getBool(key: PrivateData.KEY_IS_NEW_LAUNCH, defaultValue: true)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: PrivateData.KEY_IS_NEW_LAUNCH)
        }
    }
    
    var magnetPositionList: Dictionary<String, Array<CGFloat>>? {
        get {
            return UserDefaults.standard.object(forKey: PrivateData.KEY_MAGNETS_POSITION) as? Dictionary<String, Array<CGFloat>>
        }
        set {
            UserDefaults.standard.set(newValue, forKey: PrivateData.KEY_MAGNETS_POSITION)
        }
    }
    
    var ballPositionList: Dictionary<String, Array<Double>>? {
        get {
            return UserDefaults.standard.object(forKey: PrivateData.KEY_BALLS_POSITION) as? Dictionary<String, Array<Double>>
        }
        set {
            UserDefaults.standard.set(newValue, forKey: PrivateData.KEY_BALLS_POSITION)
        }
    }
    
    // MARK: - Operation
    func getObject(key: String) -> AnyObject? {
        return UserDefaults.standard.object(forKey: key) as AnyObject?
    }
    
    func setObject(key: String, value: AnyObject?) {
        if value == nil {
            UserDefaults.standard.removeObject(forKey: key)
        } else {
            UserDefaults.standard.set(value, forKey: key)
        }
    }
    
    private func getBool(key: String, defaultValue: Bool) -> Bool {
        if getObject(key: key) == nil {
            setObject(key: key, value: defaultValue as AnyObject?)
        }
        return UserDefaults.standard.bool(forKey: key)
    }
    
    private func getString(key: String, defaultValue: String) -> String {
        if let result = getObject(key: key) as? String {
            return result
        }
        setObject(key: key, value: defaultValue as AnyObject?)
        return defaultValue
    }
    
    private func getDictionary(key: String, defaultValue: Dictionary<String, AnyObject>) -> Dictionary<String, AnyObject> {
        if let result = getObject(key: key) as? Dictionary<String, AnyObject> {
            return result
        }
        setObject(key: key, value: defaultValue as AnyObject?)
        return defaultValue
    }
    
    private func getArray(key: String, defaultValue: Array<AnyObject>) -> Array<AnyObject> {
        if let result = getObject(key: key) as? Array<AnyObject> {
            return result
        }
        setObject(key: key, value: defaultValue as AnyObject?)
        return defaultValue
    }
}
