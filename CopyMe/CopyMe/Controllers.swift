//
//  MainWindowController.swift
//  CopyMe
//
//  Created by cottonBuddha on 2021/7/4.
//

import AppKit

let ScreenWidth = NSScreen.main?.frame.size.width ?? 0
let ScreenHeight = NSScreen.main?.frame.size.height ?? 0


class MainWindowController: NSWindowController,NSWindowDelegate {
    
    let pasteViewController = PasteViewController()
    
    init() {
        let window = NSWindow.init(contentRect: NSRect.zero, styleMask: .borderless, backing: .buffered, defer: false)
        super.init(window: window)
        window.level = NSWindow.Level.modalPanel
        window.delegate = self
        window.isOpaque = false
        window.backgroundColor = NSColor.clear
        window.contentViewController = pasteViewController
        window.makeKey()
        
        registerNotifications()
    }

    func registerNotifications() {
        //workspace切换
        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(MainWindowController.changeActiveSpace), name: NSWorkspace.activeSpaceDidChangeNotification, object: nil)
        
        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(MainWindowController.resignActive), name: NSWorkspace.sessionDidBecomeActiveNotification, object: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func statusItemClick() {
        showOrHideBoard()
    }

    @objc
    func changeActiveSpace() {
        isShown = false
        pasteViewController.showBoard(false)
    }
    
    @objc
    func resignActive() {
        isShown = false
        pasteViewController.showBoard(false)
    }
    
    var isShown = false
    func showOrHideBoard() {
        isShown = !isShown
        self.window?.isOpaque = isShown
//        if self.window?.isOpaque == true {
//            resignActive()
//        }
        pasteViewController.showBoard(isShown)
    }
}

class PasteViewController: NSViewController {
    
    let collectionView = NSView.init(frame: NSRect.init(x: 0, y: 0, width: 200, height: ScreenHeight))
//    let textView = NSTextView.init(frame: NSRect.init(x: 0, y: 0, width: 200, height: 200))
    
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
        collectionView.frame = NSRect.init(x: -400, y: 0 , width: 400, height: ScreenHeight)
        view.addSubview(collectionView)
        
//        view.addSubview(textView)
    }
        
    func showBoard(_ show:Bool) {
        NSAnimationContext.runAnimationGroup { (context) in
            context.allowsImplicitAnimation = true
            context.duration = 0.2
            context.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            collectionView.frame = NSRect.init(x: show ? 0 : -400, y: 0 , width: 400, height: ScreenHeight)
        }
    }
    
}
