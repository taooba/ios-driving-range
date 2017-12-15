//
//  TransitionButtonVC.swift
//  ios-driving-range
//
//  Created by taooba on 10/27/17.
//  Copyright © 2017 taooba. All rights reserved.
//

import UIKit

class TransitionButtonVC: UIViewController {
  let btnTransition = TransitionButton()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor(red: 82/255, green: 185/255, blue: 137/255, alpha: 1)
    
    self.btnTransition.center = self.view.center
    self.btnTransition.bounds = CGRect(x: 0, y: 0, width: 34, height: 34)
    self.btnTransition.layer.transform = CATransform3DMakeScale(5, 5, 1)
    self.view.addSubview(self.btnTransition)
    
    self.btnTransition.addTarget(self, action: #selector(self.eventWhenBtnTransitonTouchUpInside(_:)), for: .touchUpInside)
  }

  @objc func eventWhenBtnTransitonTouchUpInside(_ sender: UIButton) {
    let status = TransitionStatus(rawValue: self.btnTransition.status.rawValue + 1) ?? .plusIcon
    self.btnTransition.status = status
  }
}

