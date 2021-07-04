//
//  StatusBarItem.swift
//  CopyMe
//
//  Created by cottonBuddha on 2021/7/4.
//

import AppKit

//一级菜单目录
let menuDesc = [("偏好设置"     ,itemSetting),
                ("sep"         ,{}),
                ("关于CopyMe"  ,itemAbout),
                ("帮助"        ,itemHelp),
                ("sep"         ,{}),
                ("退出"        ,itemQuit)]

func itemSetting() {
    print("itemSetting")
}

func itemAbout() {
    print("itemAbout")
}

//帮助
func itemHelp() {
    print("itemHelp")
}

//退出
func itemQuit() {
    print("itemQuit")
    NSApp.terminate(nil)
}

