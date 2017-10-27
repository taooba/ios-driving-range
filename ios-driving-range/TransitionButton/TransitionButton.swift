//
//  TransitionButton.swift
//  TransitionButton
//
//  Created by taooba on 10/24/17.
//  Copyright © 2017 taooba. All rights reserved.
//

import UIKit

/// Transition Button 的状态枚举
enum TransitionStatus:Int {
  case plusIcon   // 加号图标
  case crossIcon  // 叉号图标
  case leftArrow  // 左向箭头
}

/// 标识两个 ShapeLayer 的  path
private enum ShapePath:String {
  case path1 = "path1"
  case path2 = "path2"
}

/// 根据一组图标的两个 status 和 一个 Path 标识来获取字符串 key
private func getStatusKey(s1:TransitionStatus, s2:TransitionStatus, status:TransitionStatus, path:ShapePath) -> String {
  return "\(s1.rawValue + s2.rawValue)+\(status.rawValue)\(path)"
}


class TransitionButton: UIControl {
  let shapeLayer1 = CAShapeLayer()
  let shapeLayer2 = CAShapeLayer()
  
  var transitionAnimationDuration:CFTimeInterval = 0.8
  private(set) var isRunningAnimation:Bool = false

  private var isFirstSetupStatus = true
  private var _status:TransitionStatus = .plusIcon
  var status:TransitionStatus  {
    get{return _status}
    set{
      if isRunningAnimation {return}
      var old = _status
      if isFirstSetupStatus && newValue == self.status {
        old = TransitionStatus.init(rawValue: self.status.rawValue+1)!
      } else if (newValue == self.status) {return}
      
      switch (old, newValue) {
      case (.plusIcon,.crossIcon), (.crossIcon, .plusIcon):
        runTransitionAnimateion(path1: self.pathPlusIconAndCrossIcon1, path2: self.pathPlusIconAndCrossIcon2, old: old, new: newValue)
      case (.plusIcon, .leftArrow), (.leftArrow, .plusIcon):
        runTransitionAnimateion(path1: self.pathPlusIconAndLeftArrow1, path2: self.pathPlusIconAndLeftArrow2, old: old, new: newValue)
      case (.crossIcon, .leftArrow), (.leftArrow, .crossIcon):
        runTransitionAnimateion(path1: self.pathCrossIconAndLeftArrow1, path2: self.pathCrossIconAndLeftArrow2, old: old, new: newValue)
      default: break
      }
      _status = newValue
      isFirstSetupStatus = false
  }}
  
  private let dicStatusSegment = [
    // .plusIcon + .crossIcon 的一组
    getStatusKey(s1: .plusIcon, s2: .crossIcon, status: .plusIcon, path: .path1) : (start: 0.025, end: 0.175),
    getStatusKey(s1: .plusIcon, s2: .crossIcon, status: .plusIcon, path: .path2) : (start: 0.025, end: 0.175),
    getStatusKey(s1: .plusIcon, s2: .crossIcon, status: .crossIcon, path: .path1) : (start: 0.825, end: 0.975),
    getStatusKey(s1: .plusIcon, s2: .crossIcon, status: .crossIcon, path: .path2) : (start: 0.825, end: 0.975),
    // .plusIcon + .leftArrow 的一组
    getStatusKey(s1: .plusIcon, s2: .leftArrow, status: .plusIcon, path: .path1) : (start: 0.030, end: 0.210),
    getStatusKey(s1: .plusIcon, s2: .leftArrow, status: .plusIcon, path: .path2) : (start: 0.034, end: 0.234),
    getStatusKey(s1: .plusIcon, s2: .leftArrow, status: .leftArrow, path: .path1) : (start: 0.899, end: 1),
    getStatusKey(s1: .plusIcon, s2: .leftArrow, status: .leftArrow, path: .path2) : (start: 0.888, end: 1),
    // .crossIcon + .leftArrow 的一组
    getStatusKey(s1: .crossIcon, s2: .leftArrow, status: .crossIcon, path: .path1) : (start: 0.031, end: 0.216),
    getStatusKey(s1: .crossIcon, s2: .leftArrow, status: .crossIcon, path: .path2) : (start: 0.028, end: 0.196),
    getStatusKey(s1: .crossIcon, s2: .leftArrow, status: .leftArrow, path: .path1) : (start: 0.897, end: 1),
    getStatusKey(s1: .crossIcon, s2: .leftArrow, status: .leftArrow, path: .path2) : (start: 0.906, end: 1)
  ]
  
  let pathPlusIconAndCrossIcon1:CGPath = {
    let path = CGMutablePath()
    path.move(to: CGPoint(x: 15, y: 35))
    path.addLine(to: CGPoint(x: 15, y: 0))
    path.addCurve(to: CGPoint(x: 30, y: 15), control1: CGPoint(x: 23.28, y: 0), control2: CGPoint(x: 30, y: 6.72))
    path.addCurve(to: CGPoint(x: 15, y: 30), control1: CGPoint(x: 30, y: 23.28), control2: CGPoint(x: 23.28, y: 30))
    path.addCurve(to: CGPoint(x: 0, y: 15), control1: CGPoint(x: 6.72, y: 30), control2: CGPoint(x: 0, y: 23.28))
    path.addCurve(to: CGPoint(x: 15, y: 0), control1: CGPoint(x: 0, y: 6.72), control2: CGPoint(x: 6.72, y: 0))
    path.addCurve(to: CGPoint(x: 30, y: 15), control1: CGPoint(x: 23.28, y: 0), control2: CGPoint(x: 30, y: 6.72))
    path.addCurve(to: CGPoint(x: 25.61, y: 25.61), control1: CGPoint(x: 30, y: 19.14), control2: CGPoint(x: 28.32, y: 22.89))
    path.addLine(to: CGPoint(x: 0.86, y: 0.86))
    return path
  }()
  let pathPlusIconAndCrossIcon2:CGPath = {
    let path = CGMutablePath()
    path.move(to: CGPoint(x: -5, y: 15))
    path.addLine(to: CGPoint(x: 30, y: 15))
    path.addCurve(to: CGPoint(x: 15, y: 30), control1: CGPoint(x: 30, y: 23.28), control2: CGPoint(x: 23.28, y: 30))
    path.addCurve(to: CGPoint(x: 0, y: 15), control1: CGPoint(x: 6.72, y: 30), control2: CGPoint(x: 0, y: 23.28))
    path.addCurve(to: CGPoint(x: 15, y: 0), control1: CGPoint(x: 0, y: 6.72), control2: CGPoint(x: 6.72, y: 0))
    path.addCurve(to: CGPoint(x: 30, y: 15), control1: CGPoint(x: 23.28, y: 0), control2: CGPoint(x: 30, y: 6.72))
    path.addCurve(to: CGPoint(x: 15, y: 30), control1: CGPoint(x: 30, y: 23.28), control2: CGPoint(x: 23.28, y: 30))
    path.addCurve(to: CGPoint(x: 4.39, y: 25.61), control1: CGPoint(x: 10.86, y: 30), control2: CGPoint(x: 7.11, y: 28.33))
    path.addLine(to: CGPoint(x: 29.14, y: 0.86))
    return path
  }()
  
  let pathPlusIconAndLeftArrow1:CGPath = {
    let path = CGMutablePath()
    path.move(to: CGPoint(x: -5, y: 15))
    path.addLine(to: CGPoint(x: 30, y: 15))
    path.addCurve(to: CGPoint(x: 15, y: 30), control1: CGPoint(x: 30, y: 23.28), control2: CGPoint(x: 23.28, y: 30))
    path.addCurve(to: CGPoint(x: 0, y: 15), control1: CGPoint(x: 6.72, y: 30), control2: CGPoint(x: 0, y: 23.28))
    path.addCurve(to: CGPoint(x: 15, y: 0), control1: CGPoint(x: 0, y: 6.72), control2: CGPoint(x: 6.72, y: 0))
    path.addCurve(to: CGPoint(x: 30, y: 15), control1: CGPoint(x: 23.28, y: 0), control2: CGPoint(x: 30, y: 6.72))
    path.addCurve(to: CGPoint(x: 18.44, y: 29.6), control1: CGPoint(x: 30, y: 22.1), control2: CGPoint(x: 25.07, y: 28.05))
    path.addLine(to: CGPoint(x: 10, y: 15))
    return path
  }()
  let pathPlusIconAndLeftArrow2:CGPath = {
    let path = CGMutablePath()
    path.move(to: CGPoint(x: 15, y: 35))
    path.addLine(to: CGPoint(x: 15, y: 0))
    path.addCurve(to: CGPoint(x: 30, y: 15), control1: CGPoint(x: 23.28, y: 0), control2: CGPoint(x: 30, y: 6.72))
    path.addCurve(to: CGPoint(x: 15, y: 30), control1: CGPoint(x: 30, y: 23.28), control2: CGPoint(x: 23.28, y: 30))
    path.addCurve(to: CGPoint(x: 0, y: 15), control1: CGPoint(x: 6.72, y: 30), control2: CGPoint(x: 0, y: 23.28))
    path.addCurve(to: CGPoint(x: 15, y: 0), control1: CGPoint(x: 0, y: 6.72), control2: CGPoint(x: 6.72, y: 0))
    path.addCurve(to: CGPoint(x: 18.44, y: 0.4), control1: CGPoint(x: 16.19, y: 0), control2: CGPoint(x: 17.33, y: 0.14))
    path.addLine(to: CGPoint(x: 10, y: 15))
    return path
  }()

  let pathCrossIconAndLeftArrow1:CGPath = {
    let path = CGMutablePath()
    path.move(to: CGPoint(x: 29.14, y: 29.14))
    path.addLine(to: CGPoint(x: 4.39, y: 4.39))
    path.addCurve(to: CGPoint(x: 15, y: 0), control1: CGPoint(x: 7.11, y: 1.67), control2: CGPoint(x: 10.86, y: 0))
    path.addCurve(to: CGPoint(x: 30, y: 15), control1: CGPoint(x: 23.28, y: 0), control2: CGPoint(x: 30, y: 6.72))
    path.addCurve(to: CGPoint(x: 15, y: 30), control1: CGPoint(x: 30, y: 23.28), control2: CGPoint(x: 23.28, y: 30))
    path.addCurve(to: CGPoint(x: 0, y: 15), control1: CGPoint(x: 6.72, y: 30), control2: CGPoint(x: 0, y: 23.28))
    path.addCurve(to: CGPoint(x: 15, y: 0), control1: CGPoint(x: 0, y: 6.72), control2: CGPoint(x: 6.72, y: 0))
    path.addCurve(to: CGPoint(x: 18.44, y: 0.38), control1: CGPoint(x: 16.18, y: 0), control2: CGPoint(x: 17.34, y: 0.12))
    path.addLine(to: CGPoint(x: 10, y: 15))
    return path
  }()
  let pathCrossIconAndLeftArrow2:CGPath = {
    let path = CGMutablePath()
    path.move(to: CGPoint(x: 0.86, y: 29.14))
    path.addLine(to: CGPoint(x: 25.61, y: 4.39))
    path.addCurve(to: CGPoint(x: 30, y: 15), control1: CGPoint(x: 28.33, y: 7.11), control2: CGPoint(x: 30, y: 10.85))
    path.addCurve(to: CGPoint(x: 15, y: 30), control1: CGPoint(x: 30, y: 23.28), control2: CGPoint(x: 23.28, y: 30))
    path.addCurve(to: CGPoint(x: 0, y: 15), control1: CGPoint(x: 6.72, y: 30), control2: CGPoint(x: 0, y: 23.28))
    path.addCurve(to: CGPoint(x: 15, y: 0), control1: CGPoint(x: 0, y: 6.72), control2: CGPoint(x: 6.72, y: 0))
    path.addCurve(to: CGPoint(x: 30, y: 15), control1: CGPoint(x: 23.28, y: 0), control2: CGPoint(x: 30, y: 6.72))
    path.addCurve(to: CGPoint(x: 18.44, y: 29.62), control1: CGPoint(x: 30, y: 22.1), control2: CGPoint(x: 25.06, y: 28.06))
    path.addLine(to: CGPoint(x: 10, y: 15))
    return path
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    func callFuncForDidSet() { self.status = .plusIcon }
    callFuncForDidSet()
    
    for layer in [self.shapeLayer1, self.shapeLayer2] {
      layer.fillColor = nil
      layer.strokeColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1).cgColor
      layer.strokeColor = UIColor.white.cgColor
      layer.lineWidth = 4
      layer.miterLimit = 4
      layer.lineCap = kCALineCapRound
      layer.lineJoin = kCALineJoinRound
      layer.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
      layer.actions = ["strokeStart": NSNull(), "strokeEnd": NSNull()]
      self.layer.addSublayer(layer)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


extension TransitionButton: CAAnimationDelegate {
  override var frame: CGRect { didSet{
    for layer in [self.shapeLayer1, self.shapeLayer2] {
      layer.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
    }
  }}
  override var bounds: CGRect {didSet{
    for layer in [self.shapeLayer1, self.shapeLayer2] {
      layer.position = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
    }
  }}
  
  func runTransitionAnimateion(path1:CGPath, path2:CGPath, old:TransitionStatus, new: TransitionStatus) {
    isRunningAnimation = true
    self.shapeLayer1.path = path1
    self.shapeLayer2.path = path2
    
    func runAnimation(shapePath:ShapePath) {
      let shapeLayer = shapePath == .path1 ? self.shapeLayer1 : self.shapeLayer2
      let fromSegm = self.dicStatusSegment[getStatusKey(s1: old, s2: new, status: old, path: shapePath)]!
      let toSegm = self.dicStatusSegment[getStatusKey(s1: old, s2: new, status: new, path: shapePath)]!
      
      for info in [(path:"strokeStart", from:fromSegm.0, to:toSegm.0), (path:"strokeEnd", from:fromSegm.1, to:toSegm.1)] {
        let animate = CABasicAnimation(keyPath: info.path)
        animate.fromValue = info.from
        animate.toValue = info.to
        animate.duration = self.isFirstSetupStatus ? 0.0001 : self.transitionAnimationDuration
        animate.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, -0.2, 0.5, 1.2)
        animate.delegate = self
        shapeLayer.ext_applyAnimation(animate)
      }
    }
    for shapePath in [ShapePath.path1, ShapePath.path2] { runAnimation(shapePath: shapePath) }
  }
  
  func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    self.isRunningAnimation = !flag
  }
}


extension CALayer {
  func ext_applyAnimation(_ animation: CABasicAnimation) {
    self.add(animation, forKey: animation.keyPath)
    self.setValue(animation.toValue, forKeyPath:animation.keyPath!)
  }
}
