//
//  RootController.swift
//  ios-driving-range
//
//  Created by taooba on 11/28/17.
//  Copyright © 2017 taooba. All rights reserved.
//

import UIKit

class RootController: UITableViewController {
  let dataArr = [
    (name:"Transition Button", intro:"利用 PaintCode 软件制作 CAShapeLayer 的 CGPath, 再通过 CoreAnimation 动画修改 CGPath 的 strokeStart, strokeEnd 来实现按钮动画效果", typeVC:TransitionButtonVC.self),
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "iOS-Driving-Range"
    self.tableView.tableFooterView = UIView()
    self.tableView.tableFooterView?.frame = CGRect(x: 0, y: 0, width: 0, height: 0.1)
  }
}


// MARK: - tableView/dataSources delegate
extension RootController {
  override func numberOfSections(in tableView: UITableView) -> Int { return 1 }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return self.dataArr.count }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell:UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "defaultCell")
    if cell == nil {
      cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "defaultCell")
      cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 28)
      cell.detailTextLabel?.numberOfLines = 3
      cell.detailTextLabel?.textColor = UIColor(red: 120/255.0, green: 120/255.0, blue: 120/255.0, alpha: 1)
    }

    let data = dataArr[indexPath.row]
    cell.textLabel?.text = data.name
    cell.detailTextLabel?.text = data.intro
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let data = dataArr[indexPath.row]
    let controller = data.typeVC.init()
    controller.title = data.name
    self.navigationController?.pushViewController(controller, animated: true)
  }
}
