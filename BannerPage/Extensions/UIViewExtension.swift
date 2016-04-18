//
//  UIViewExtension.swift
//  BannerPage
//
//  Created by 张霄男 on 15/7/21.
//  Copyright (c) 2015年 ir0ach.me. Inc. All rights reserved.
//

import UIKit

extension UIView {
  
  /// View的X值
  var X: CGFloat {
    get {
      return self.frame.origin.x
    }
    set {
      var origin = self.frame.origin
      origin.x = newValue
      self.frame.origin = origin
    }
  }
  
  /// View的Y值
  var Y: CGFloat {
    get {
      return self.frame.origin.y
    }
    set {
      var origin = self.frame.origin
      origin.y = newValue
      self.frame.origin = origin
    }
  }
  
  /// View的宽度
  var width: CGFloat {
    get {
      return self.bounds.width
    }
    set {
      var bounds = self.bounds
      bounds.size.width = newValue
      self.bounds = bounds
    }
  }
  
  /// View的高度
  var height: CGFloat {
    get {
      return self.bounds.height
    }
    set {
      var bounds = self.bounds
      bounds.size.height = newValue
      self.bounds = bounds
    }
  }
  
  /// View的中心X值
  var centerX: CGFloat {
    get {
      return self.center.x
    }
    set {
      var center = self.center
      center.x = newValue
      self.center = center
    }
  }
  
  /// View的中心Y值
  var centerY: CGFloat {
    get {
      return self.center.y
    }
    set {
      var center = self.center
      center.y = newValue
      self.center = center
    }
  }
  
  
}
