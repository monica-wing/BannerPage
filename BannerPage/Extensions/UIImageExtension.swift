//
//  UIImageExtension.swift
//  BannerPage
//
//  Created by 张霄男 on 15/9/17.
//  Copyright (c) 2015年 ir0ach.me. All rights reserved.
//

import UIKit

extension UIImage {
  
  /**
   根据颜色生成一个1x1的图片
   */
  class func imageWithColor(color: UIColor) -> UIImage {
    let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    CGContextSetFillColorWithColor(context, color.CGColor)
    CGContextFillRect(context, rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }
  
  /**
   缩放图片
   */
  func imageWithSize(size: CGSize) -> UIImage {
    UIGraphicsBeginImageContext(size)
    self.drawInRect(CGRect(x: 0, y: 0, width: size.width, height: size.height))
    let currentImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return currentImage
  }
}