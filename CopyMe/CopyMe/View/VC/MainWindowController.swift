//
//  MainWindowController.swift
//  CopyMe
//
//  Created by jqs on 2021/7/9.
//

import Cocoa
import RxSwift
//import RxCocoa

class MainWindowController: NSWindowController,NSWindowDelegate {
    
    let disposeBag = DisposeBag()
    var isKey = false
    let btn = NSButton.init(frame: NSRect.init(x: 100, y: 100, width: 100, height: 100))

    //MARK:初始化方法
    init() {
        let window = MainWindow.init(contentRect: NSRect.init(x: 0, y: 0, width: Ruler.Size.ScreenWidth, height: Ruler.Size.ScreenHeight), styleMask: [.borderless, .nonactivatingPanel], backing: .buffered, defer: false)
        super.init(window: window)
        window.level = NSWindow.Level.mainMenu
        window.delegate = self
        window.isOpaque = false
        window.collectionBehavior = [.canJoinAllSpaces]
        window.backgroundColor = NSColor.clear
        contentViewController = MainContentViewController()
        
        registerNotifications()
        Action.Pateboard.BoardWillShow.subscribe { [weak self] _ in
            guard let self = self, let window = self.window else {return}
            window.makeKey();
        }.disposed(by: disposeBag)
        Action.Pateboard.BoardDidHide.subscribe { [weak self] _ in
            guard let self = self, let window = self.window else {return}
            window.resignKey()
        }.disposed(by: disposeBag)

        Action.Noti.ChangeSpace.subscribe {[weak self] _ in
            guard let self = self else {return}
            if !self.isKey {
                window.resignKey()
            }
        }.disposed(by: disposeBag)
        
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func registerNotifications() {
        //workspace切换
//        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(MainWindowController.changeActiveSpace), name: NSWorkspace.activeSpaceDidChangeNotification, object: nil)

        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(MainWindowController.resignActive), name: NSApplication.willResignActiveNotification, object: nil)

        //尝试各种通知的触发时机

    }

    @objc
    func resignActive() {
        print("===")
    }
    
}



