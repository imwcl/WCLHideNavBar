//
//  UINavigationBar+WCL.swift
//  WCLHideNavBar
//
//  Created by 王崇磊 on 16/7/28.
//  Copyright © 2016年 王崇磊. All rights reserved.
//

import UIKit

private var wclBackView = "wclBackView"

extension UINavigationBar {
    
    /**
     给UINavigationBar添加背景色，用runtime插入一个backView
     
     - parameter color: backView的背景颜色
     
     - returns: 返回UINavigationBar本身
     */
    func setWclBackGroundColor(color:UIColor) -> UINavigationBar {
        let wclBackGroundColorView = objc_getAssociatedObject(self, &wclBackView) as? UIView
        if wclBackGroundColorView == nil {
            setBackgroundImage(UIImage.init(), forBarMetrics: .Default)
            shadowImage = UIImage.init()
            let backView = UIView.init(frame: CGRectMake(0, -20, bounds.width, bounds.height+20))
            backView.backgroundColor = color
            backView.userInteractionEnabled = false
            backView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
            insertSubview(backView, atIndex: 0)
            objc_setAssociatedObject(self, &wclBackView, backView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }else {
            wclBackGroundColorView!.backgroundColor = color
        }
        return self
    }
    
    /**
     设置backView的透明度
     
     - parameter alpha: backView的透明度
     
     - returns: 返回UINavigationBar本身
     */
    func setWclBackViewAlpha(alpha:CGFloat) -> UINavigationBar {
        let wclBackGroundColorView = objc_getAssociatedObject(self, &wclBackView) as? UIView
        wclBackGroundColorView?.alpha = alpha
        return self
    }
    
    /**
     向上隐藏NavigationBar
     
     - parameter progress: 隐藏的进度，默认是0，范围0~1
     
     - returns: 返回UINavigationBar本身
     */
    func setWclNavBarHide(progress:CGFloat) -> UINavigationBar {
        print(progress)
        if progress > 0 {
            transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -bounds.height*progress)
        }else {
            transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0)
        }
        if let leftViews = valueForKey("_leftViews") as? [UIView] {
            for leftView in leftViews {
                leftView.alpha = 1 - progress
            }
        }
        if let rightViews = valueForKey("_rightViews") as? [UIView] {
            for rightView in rightViews {
                rightView.alpha = 1 - progress
            }
        }
        if let titleView = valueForKey("_titleView") as? UIView {
            titleView.alpha = 1 - progress
        }
        return self
    }
    
    /**
     向上隐藏NavigationBar和StateView
     
     - parameter progress: 隐藏的进度，默认是0，范围0~1
     
     - returns: 返回UINavigationBar本身
     */
    func setWclNavBarAndStateHide(progress:CGFloat) -> UINavigationBar {
        if let stateView = UIApplication.sharedApplication().valueForKey("statusBarWindow") as? UIView {
            if progress > 0 {
                transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -(bounds.height+20)*progress)
                stateView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -(bounds.height+20)*progress)
            }else {
                transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0)
                stateView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0)

            }
        }
        return self
    }
    
}