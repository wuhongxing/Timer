//
//  HXTimerProxy.swift
//  Timer
//
//  Created by 吴红星 on 2020/3/26.
//  Copyright © 2020 wuhongxing. All rights reserved.
//

import Foundation

/// 这个类就是为了转发消息的，并且弱引用其中的 target
class HXTimerProxy: NSObject {
    
    weak var target: NSObjectProtocol?
    weak var timer: Timer?
    var selector: Selector?
    
    public required init(target: NSObjectProtocol?, selector: Selector?) {
        self.target = target
        self.selector = selector
        
        super.init()
        
        guard let target = target, let selector = selector, target.responds(to: selector) else {
            return
        }
        
        let method = class_getInstanceMethod(self.classForCoder, #selector(redirectionMethod))!
        class_replaceMethod(self.classForCoder, selector, method_getImplementation(method), method_getTypeEncoding(method))
    }
    
    @objc func redirectionMethod () {
        if let target = target {
            target.perform(selector)
        } else {
            timer?.invalidate()
        }
    }
}

extension NSObject: HXCompatible { }

extension HX where Base == Timer {
    @discardableResult
    init(timeInterval ti: TimeInterval, target aTarget: Any, selector aSelector: Selector, userInfo: Any?, repeats yesOrNo: Bool) {
        let proxy = HXTimerProxy(target: aTarget as? NSObjectProtocol, selector: aSelector)
        let timer = Timer(timeInterval: ti, target: proxy, selector: aSelector, userInfo: userInfo, repeats: yesOrNo)
        proxy.timer = timer
        RunLoop.main.add(timer, forMode: RunLoop.Mode.common)
        base = timer
    }
    
    @discardableResult
    static func scheduledTimer(timeInterval ti: TimeInterval, target aTarget: Any, selector aSelector: Selector, userInfo: Any?, repeats yesOrNo: Bool) -> Timer {
        let timer = self.init(timeInterval: ti, target: aTarget, selector: aSelector, userInfo: userInfo, repeats: yesOrNo)
        return timer.base
    }
}


