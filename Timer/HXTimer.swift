//
//  HXTimer.swift
//  Timer
//
//  Created by 吴红星 on 2020/3/26.
//  Copyright © 2020 wuhongxing. All rights reserved.
//

import Foundation

public class HXTimer {
    private let sourceTimer: DispatchSourceTimer
    
    public class func every(_ interval: DispatchTimeInterval, handle: @escaping () -> Void) -> HXTimer {
        let timer = HXTimer(interval: interval, repeats: true, handler: handle)
        timer.start()
        return timer
    }
    
    public init(interval: DispatchTimeInterval, deadline: DispatchTime = .now(), repeats: Bool = false, queue: DispatchQueue? = nil , handler: @escaping () -> Void) {
        sourceTimer = DispatchSource.makeTimerSource(queue: queue ?? DispatchQueue(label: "com.hxtimer.queue"))
        sourceTimer.schedule(deadline: deadline, repeating: repeats ? interval : .never, leeway: .milliseconds(10))
        sourceTimer.setEventHandler(handler: handler)
    }
    
    deinit {
        cancel()
    }
}

extension HXTimer {
    public func start() {
        sourceTimer.resume()
    }

    public func cancel()  {
        sourceTimer.setEventHandler(handler: nil)
        sourceTimer.cancel()
    }

}
