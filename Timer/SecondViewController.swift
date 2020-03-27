//
//  SecondViewController.swift
//  Timer
//
//  Created by 吴红星 on 2020/3/26.
//  Copyright © 2020 wuhongxing. All rights reserved.
//

import UIKit



class SecondViewController: UIViewController {
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.hx.scheduledTimer(timeInterval: 1, target: self, selector: #selector(test), userInfo: nil, repeats: true)
    }
    
    @objc private func test() {
        print(CACurrentMediaTime())
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
        print("deinit", Thread.current)
    }
}
