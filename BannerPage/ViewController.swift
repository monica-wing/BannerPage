//
//  ViewController.swift
//  BannerPage
//
//  Created by 张霄男 on 16/4/18.
//  Copyright © 2016年 ir0ach.me. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let banner = BannerPageView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.width / 2))
    banner.delegate = self
    view.addSubview(banner)
    banner.imagesURL = [
      "http://qsqseapp-10000035.image.myqcloud.com/qqtbossdevcom/banner/8c6c900824bc7c934e42361ca134ee27.png",
      "http://qsqseapp-10000035.image.myqcloud.com/qqtbossdevcom/banner/0e3fc408497be65a68ef137a517445f2.png"
      ]
  }

}

extension ViewController: BannerPageViewDelegate {
  func pageViewDidClick(pageView: BannerPageView, currentPage: Int) {
    print("当前点击了第\(currentPage)页")
  }
}