//
//  HXCompatible.swift
//  Timer
//
//  Created by 吴红星 on 2020/3/26.
//  Copyright © 2020 wuhongxing. All rights reserved.
//
//  这个类就是为了加hx.这个前缀的，和kf/snp之类是一样的

import Foundation

struct HX<Base> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

protocol HXCompatible {
    associatedtype CompatibleType
    
    static var hx: HX<CompatibleType>.Type { get }
    var hx: HX<CompatibleType> { get }
}

extension HXCompatible {
    static var hx: HX<Self>.Type {
        get {
            HX<Self>.self
        }
    }
    
    var hx: HX<Self> {
        get {
            HX(self)
        }
    }
}
