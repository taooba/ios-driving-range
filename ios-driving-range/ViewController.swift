//
//  ViewController.swift
//  ios-driving-range
//
//  Created by taooba on 10/27/17.
//  Copyright © 2017 taooba. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  let button = TransitionButton()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.button.center = self.view.center
    self.button.bounds = CGRect(x: 0, y: 0, width: 34, height: 34)
    self.button.layer.transform = CATransform3DMakeScale(5, 5, 1)
    self.view.backgroundColor = UIColor(red: 118/255, green: 108/255, blue: 118/255, alpha: 1)
    self.view.addSubview(button)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func eventPlusIconTouchUpInside(_ sender: UIButton) {
    self.button.status = .plusIcon
  }
  
  @IBAction func eventCrossIconTouchUpInside(_ sender: UIButton) {
    self.button.status = .crossIcon
  }
  
  @IBAction func eventLeftArrowTouchUpInside(_ sender: UIButton) {
    self.button.status = .leftArrow
  }
}

