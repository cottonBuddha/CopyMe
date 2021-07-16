//
//  Actions.swift
//  CopyMe
//
//  Created by jqs on 2021/7/10.
//

import Cocoa
import RxSwift
import HotKey
import RxRelay

struct Action {
    
    struct StatusBar {
        static var ItemTap = PublishSubject<Void>()
    }
    
    struct Noti {
        //noti
        static let ChangeSpace = NSWorkspace.shared.notificationCenter.rx.notification(NSWorkspace.activeSpaceDidChangeNotification)
        static let UnmountApp = NSWorkspace.shared.notificationCenter.rx.notification(NSWorkspace.didDeactivateApplicationNotification)

    }
    
    struct App {
        static let FrontApp = BehaviorRelay<NSRunningApplication?>(value: nil)

    }
    
    struct HotKey {
        
    }
    
    struct Pateboard {
        static var BoardWillShow = PublishSubject<Void>()
        static var BoardDidShow  = PublishSubject<Void>()
        static var BoardWillHide = PublishSubject<Void>()
        static var BoardDidHide  = PublishSubject<Void>()
    }
    
}

class HotKeyManager {
    let triggerHotKey = HotKey(key: .r, modifiers: [.command, .option])

}


