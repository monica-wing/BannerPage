//
//  BannerPageView.swift
//  BannerPage
//
//  Created by 张霄男 on 15/12/17.
//  Copyright © 2015年 ir0ach.me. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

/**
 *  BannerPageViewDelegate
 */
@objc
protocol BannerPageViewDelegate {
  /**
   当点击Banner上面的图片时，可以得到当前点击的Index
   */
  optional func pageViewDidClick(pageView: BannerPageView, currentPage: Int)
}

class BannerPageView: UIView {

  private weak var scrollView: UIScrollView!
  private weak var pageControl: UIPageControl!
  private weak var timer: NSTimer!
  
  weak var delegate: BannerPageViewDelegate?
  let imageViewCount = 3
  var imagesURL = [String]() {
    didSet {
      stopTimer()
      if imagesURL.count == 0 {
        return
      } else if imagesURL.count == 1 {
        scrollView.scrollEnabled = false
        pageControl.numberOfPages = 1
      }
      
      if scrollView.subviews.count > 0 {
        scrollView.subviews.forEach { $0.removeFromSuperview() }
      }
      
      for i in 0..<imageViewCount {
        var index = i
        if i == 0 {
          index = imagesURL.count - 1
        }
        if index >= imagesURL.count {
          index = 0
        }
        let imageView = UIImageView()
        let url = NSURL(string: imagesURL[index])!
        let placeholderImage = UIImage.imageWithColor(UIColor.lightGrayColor())
        imageView.sd_setImageWithURL(url, placeholderImage: placeholderImage)
        imageView.frame = CGRect(x: CGFloat(i) * width, y: 0, width: width, height: height)
        imageView.tag = i
        
        scrollView.addSubview(imageView)
      }
      
      pageControl.numberOfPages = imagesURL.count
      
      updateContent()
      if imagesURL.count > 1 {
        startTimer()
      }
    }
  }
  var timerInterval: NSTimeInterval = 5
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupScrollView()
    setupPageControl()
    
    startTimer()
    
    let gesture = UITapGestureRecognizer(target: self, action: #selector(BannerPageView.tap))
    addGestureRecognizer(gesture)
  }
  
  func tap() {
    delegate?.pageViewDidClick?(self, currentPage: pageControl.currentPage)
  }
  
  private func setupScrollView() {
    let scrollView = UIScrollView(frame: frame)
    scrollView.delegate = self
    scrollView.pagingEnabled = true
    scrollView.showsVerticalScrollIndicator = false
    scrollView.showsHorizontalScrollIndicator = false
    addSubview(scrollView)
    
    self.scrollView = scrollView
  }
  
  private func setupPageControl() {
    let pageControl = UIPageControl()
    pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
    pageControl.currentPage = 0
    addSubview(pageControl)
    pageControl.snp_makeConstraints { (make) -> Void in
      make.bottom.centerX.equalTo(self)
    }
    self.pageControl = pageControl
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    scrollView.contentSize = CGSize(width: width * CGFloat(imageViewCount), height: 0)
    
    if imagesURL.count > 0 {
      for i in 0..<imageViewCount {
        let imageView = scrollView.subviews[i] as! UIImageView
        imageView.frame = CGRect(x: CGFloat(i) * width, y: 0, width: width, height: height)
      }
      
      updateContent()
    }
  }
  
  private func updateContent() {
    for i in 0..<imageViewCount {
      let imageView = scrollView.subviews[i] as! UIImageView
      var index = pageControl.currentPage
      if i == 0 {
        index -= 1
      } else if i == 2 {
        index += 1
      }
      
      if index < 0 {
        index = pageControl.numberOfPages - 1
      } else if index >= pageControl.numberOfPages {
        index = 0
      }
      
      let placeholderImage = UIImage.imageWithColor(UIColor.lightGrayColor())
      let url = NSURL(string: imagesURL[index])!
      imageView.sd_setImageWithURL(url, placeholderImage: placeholderImage)
      imageView.tag = index
    }
    
    scrollView.contentOffset = CGPoint(x: width, y: 0)
  }
  
  private func startTimer() {
    stopTimer()
    let timerInterval = self.timerInterval
    
    let timer = NSTimer.scheduledTimerWithTimeInterval(timerInterval, target: self, selector: #selector(BannerPageView.next), userInfo: nil, repeats: true)
    NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
    
    self.timer = timer
  }
  
  private func stopTimer() {
    if let timer = timer {
      timer.invalidate()
    }
  }
  
  func next() {
    scrollView.setContentOffset(CGPoint(x: width * 2, y: 0), animated: true)
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }

}

// MARK: - UIScrollViewDelegate
extension BannerPageView: UIScrollViewDelegate {
  
  func scrollViewDidScroll(scrollView: UIScrollView) {
    var page = 0
    var minDistance = CGFloat(MAXFLOAT)
    for i in 0..<scrollView.subviews.count {
      let imageView = scrollView.subviews[i] as! UIImageView
      let distance = abs(scrollView.contentOffset.x - imageView.X)
      
      if distance < minDistance {
        minDistance = distance
        page = imageView.tag
      }
    }
    pageControl.currentPage = page
  }
  
  /**
   当手动翻页的时候，停止定时器
   */
  func scrollViewWillBeginDragging(scrollView: UIScrollView) {
    stopTimer()
  }
  
  /**
   当松开手指调用，开启定时器，继续自动滚动
   */
  func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    startTimer()
  }
  
  /**
   当手指松开时，scrollView会滚到分割好的页上，有一个减速的过程，当减速结束时会调用
   */
  func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
    if imagesURL.count > 0 {
      updateContent()
    }
  }
  
  /**
   定时器自动滚动结束时会调用
   */
  func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
    if imagesURL.count > 0 {
      updateContent()
    }
  }
}
