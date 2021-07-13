//
//  Ruler.swift
//  CopyMe
//
//  Created by jqs on 2021/7/9.
//

import Cocoa

/**
 Ruler is used to handle various rules of app, such as UI size, color, icon and so on.
 */
struct Ruler {
    
    struct Size {
        //状态栏高度
        static let statusBarHeight: CGFloat = NSStatusBar.system.thickness
        
        //屏幕宽高
        static let ScreenWidth: CGFloat = NSScreen.main?.frame.size.width ?? 0
        static let ScreenHeight: CGFloat = NSScreen.main?.frame.size.height ?? 0
        
        //屏幕visible高度（去掉状态栏）
        static let ScreenVisibleWidth: CGFloat = NSScreen.main?.visibleFrame.size.width ?? 0
        static let ScreenVisibleHeight: CGFloat = NSScreen.main?.visibleFrame.size.height ?? 0

    }

}

extension Ruler.Size {
    //面板宽高
    static let MainPanelWidth: CGFloat = 380
    static let MainPanelHeight: CGFloat = Ruler.Size.ScreenVisibleHeight

}

