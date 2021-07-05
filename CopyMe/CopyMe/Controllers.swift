//
//  MainWindowController.swift
//  CopyMe
//
//  Created by cottonBuddha on 2021/7/4.
//

import AppKit

let ScreenWidth = NSScreen.main?.frame.size.width ?? 0
let ScreenHeight = NSScreen.main?.frame.size.height ?? 0


class MainWindow: NSWindow {
    
    override var canBecomeKey: Bool {
        return true
    }
    
    override var canBecomeMain: Bool {
        return true
    }
}

class MainWindowController: NSWindowController,NSWindowDelegate {
    
    let pasteViewController = PasteViewController()
    
    init() {
        let window = MainWindow.init(contentRect: NSRect.init(x: 0, y: 0, width: 600, height: ScreenHeight), styleMask: .borderless, backing: .buffered, defer: false)
        super.init(window: window)
        window.level = NSWindow.Level.mainMenu
        window.delegate = self
        window.isOpaque = false
        window.collectionBehavior = .canJoinAllSpaces
        window.backgroundColor = NSColor.clear
        window.contentViewController = pasteViewController
        pasteViewController.showBoard(false)
        window.makeKey()
        window.makeMain()
        registerNotifications()
    }

    func registerNotifications() {
        //workspace切换
        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(MainWindowController.changeActiveSpace), name: NSWorkspace.activeSpaceDidChangeNotification, object: nil)
        
        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(MainWindowController.resignActive), name: NSWorkspace.sessionDidBecomeActiveNotification, object: nil)
        
        //尝试各种通知的触发时机
        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(MainWindowController.resignActive), name: NSWorkspace.sessionDidBecomeActiveNotification, object: nil)
//        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(MainWindowController.resignActive), name: NSWorkspace.didTerminateApplicationNotification, object: nil)
//        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(MainWindowController.resignActive), name: NSWorkspace.didHideApplicationNotification, object: nil)
//        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(MainWindowController.resignActive), name: NSWorkspace.didUnhideApplicationNotification, object: nil)

//        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(MainWindowController.resignActive), name: NSWorkspace.didActivateApplicationNotification, object: nil)
//        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(MainWindowController.resignActive), name: NSWorkspace.didDeactivateApplicationNotification, object: nil)
//        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(MainWindowController.resignActive), name: NSWorkspace.didMountNotification, object: nil)
//        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(MainWindowController.resignActive), name: NSWorkspace.didUnmountNotification, object: nil)
//        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(MainWindowController.resignActive), name: NSWorkspace.willUnmountNotification, object: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func statusItemClick() {
        self.window?.makeMain()
        showOrHideBoard()
    }

    @objc
    func changeActiveSpace() {
        isShown = false
        pasteViewController.showBoard(false)
    }
    
    
    func windowDidBecomeKey(_ notification: Notification) {
        print("windowDidBecomeKey")
    }
    
    func windowDidResignKey(_ notification: Notification) {
        print("windowDidResignKey")
    }
    
    func windowDidBecomeMain(_ notification: Notification) {
        print("windowDidBecomeMain")
    }
    
    func windowDidResignMain(_ notification: Notification) {
        print("windowDidResignMain")
    }
            
    @objc
    func resignActive(_ notification:NSNotification) {
        print(notification.name)
//        isShown = false
//        pasteViewController.showBoard(false)
    }
    
    var isShown = false
    func showOrHideBoard() {
        isShown = !isShown
        self.window?.isOpaque = isShown
        if isShown {
            self.window?.makeKey()
        }
        pasteViewController.showBoard(isShown)
    }
}

class PasteViewController: NSViewController {
    
    let collectionView = NSView.init(frame: NSRect.init(x: 0, y: 0, width: 200, height: ScreenHeight))
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view = NSView.init(frame: NSRect.init(x: 0, y: 0, width: 400, height: ScreenHeight))
        viewDidLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.wantsLayer = true
        collectionView.layer?.backgroundColor = NSColor.blue.cgColor
        collectionView.frame = NSRect.init(x: 0, y: 0 , width: 400, height: ScreenHeight)
        view.addSubview(collectionView)
        
        let textView = NSTextField.init(frame: NSRect.init(x: 20, y: 0, width: 200, height: 200))
        textView.isEditable = true
        view.addSubview(textView)
        
        let button = NSButton.init(title: "只是点点", target: self, action: #selector(PasteViewController.buttonClick))
        button.frame = NSRect.init(x: 20, y: 200, width: 200, height: 200)
        view.addSubview(button)
    }
    
    @objc
    func buttonClick() {
        print("buttonClick")
    }
        
    func showBoard(_ show:Bool) {
        NSAnimationContext.runAnimationGroup { (context) in
            context.allowsImplicitAnimation = true
            context.duration = 0.2
            context.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            view.frame = NSRect.init(x: show ? 0 : -400, y: 0 , width: 400, height: ScreenHeight)
        }
    }
    
    override func validateProposedFirstResponder(_ responder: NSResponder, for event: NSEvent?) -> Bool {
        return true
    }
    
}
