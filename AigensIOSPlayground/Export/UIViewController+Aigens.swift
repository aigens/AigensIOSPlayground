//
//  UIViewController+Aigens.swift
//  AigensIOSPlayground
//
//  Created by Peter Liu on 6/10/2016.
//  Copyright © 2016 Aigens. All rights reserved.
//

import Foundation
import UIKit

private var xoAssociationKey: UInt8 = 0

extension UIViewController{
    
    
    private func associatedObject<ValueType: AnyObject>(
        base: AnyObject,
        key: UnsafePointer<UInt8>,
        initialiser: () -> ValueType)
        -> ValueType {
            if let associated = objc_getAssociatedObject(base, key)
                as? ValueType { return associated }
            let associated = initialiser()
            objc_setAssociatedObject(base, key, associated,
                                     .OBJC_ASSOCIATION_RETAIN)
            return associated
    }
    
    private func associateObject<ValueType: AnyObject>(
        base: AnyObject,
        key: UnsafePointer<UInt8>,
        value: ValueType) {
        objc_setAssociatedObject(base, key, value,
                                 .OBJC_ASSOCIATION_RETAIN)
    }
    
    
    public var iq: IQuery{
        
        get{
            return associatedObject(base:self, key: &xoAssociationKey){return IQuery()}
        }
        
        set { associateObject(base:self, key: &xoAssociationKey, value: newValue) }
    }
    
    
    
}
