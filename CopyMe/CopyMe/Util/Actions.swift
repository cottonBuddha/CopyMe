//
//  Actions.swift
//  CopyMe
//
//  Created by jqs on 2021/7/10.
//

import Cocoa
import RxCocoa
import RxSwift
import HotKey

struct Action {
    
    struct StatusBar {
        static var ItemTap = PublishSubject<Void>()
    }
    
    struct Noti {
        //noti
        static let ChangeSpace = NSWorkspace.shared.notificationCenter.rx.notification(NSWorkspace.activeSpaceDidChangeNotification)
        static let UnmountApp = NSWorkspace.shared.notificationCenter.rx.notification(NSWorkspace.didDeactivateApplicationNotification)

    }
    
    struct HotKey {
        
    }
}

class HotKeyManager {
    let triggerHotKey = HotKey(key: .r, modifiers: [.command, .option])

}


