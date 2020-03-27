//
//  ThirdViewController.swift
//  Timer
//
//  Created by 吴红星 on 2020/3/27.
//  Copyright © 2020 wuhongxing. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    var timer: HXTimer?

    override func viewDidLoad() {
        super.viewDidLoad()

        timer = HXTimer.every(.seconds(1)) { [weak self] in
            self?.test()
        }
    }
    
    @objc private func test() {
        print(CACurrentMediaTime())
    }
    
    deinit {
        print("deinit", Thread.current)
    }
}
