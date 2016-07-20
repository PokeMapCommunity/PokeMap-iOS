//
//  NSObject+Swizzle.swift
//  Pods
//
//  Created by sergdort on 5/11/16.
//
//

import Foundation
import ObjectiveC

extension NSObject {
    class func swizzleMethodForSelector(originalSelector: Selector,
                                        withMethodForSelector swizzledSelector: Selector) {
        let originalMethod = class_getInstanceMethod(self, originalSelector)
        let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
        
        let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        
        if didAddMethod {
            class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}