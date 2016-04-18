//
//  StringExtension.swift
//  BannerPage
//
//  Created by 张霄男 on 15/10/19.
//  Copyright © 2015年 ir0ach.me. All rights reserved.
//

import Foundation

// MARK: - String类扩展
extension String {
  
  /// 字符串的数量
  var count: Int {
    return self.characters.count
  }
  
  /**
   截取超出部分字符串为...
   
   :param: max 要截取的位数
   */
  mutating func stringWithMaxLength(max: Int) {
    if self.characters.count < max {
      return
    }
    let range = Range(self.startIndex.advancedBy(max)..<self.endIndex)
    self.replaceRange(range, with: "...")
  }
  
  /**
   截取超出部分字符串
   
   :param: max 要截取的位数
   */
  mutating func stringCutWithMaxLength(max: Int) {
    if self.characters.count < max {
      return
    }
    let range = Range(self.startIndex.advancedBy(max)..<self.endIndex)
    self.replaceRange(range, with: "")
  }
  
  /**
   去除两边的空格
   */
  func trim() -> String{
    return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
  }
  
  /**
   判断是不是合法的金额输入
   */
  func amountVerify() -> Bool {
    let chars = characters.split(".")
    let strs = chars.map(String.init)
    if hasPrefix(".") {
      return false
    } else if containsString("..") {
      return false
    } else if chars.count == 2 && hasSuffix(".") {
      return false
    } else if strs.count >= 2 {
      if strs[1].count > 2 {
        return false
      }
    }
    return true
  }
}