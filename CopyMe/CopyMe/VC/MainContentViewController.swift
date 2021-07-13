//
//  MainContentViewController.swift
//  CopyMe
//
//  Created by jqs on 2021/7/9.
//

import Cocoa
import RxSwift
import HotKey

class MainContentViewController: NSViewController {

    let disposeBag = DisposeBag()
    var isShow = false
    let panelVC = CopyMePanelViewController()
    let btn = NSButton.init(frame: NSRect.init(x: 100, y: 100, width: 100, height: 100))

    //MARK:初始化方法
    init() {
        super.init(nibName: nil, bundle: nil)
        view = MainContentView.init(frame: NSRect.init(x: 0, y: 0, width: Ruler.Size.ScreenWidth, height: Ruler.Size.ScreenHeight))
        addChild(panelVC)
        makeUI()
        layoutUI()
        bindAction()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:创建、布局、事件
    func makeUI() {
        view.addSubview(panelVC.view)
    }
    
    @objc
    func hahahah() {
        print("sdsdsdsd")
    }

    
    func layoutUI() {
        panelVC.view.frame = NSRect.init(x: isShow ? 0 : -Ruler.Size.MainPanelWidth, y: 0, width: Ruler.Size.MainPanelWidth, height: Ruler.Size.MainPanelHeight)
    }
    

    func bindAction() {
        Action.StatusBar.ItemTap.subscribe({[weak self] _ in
            guard let self = self else {return}
            self.showPanel(!self.isShow)
            self.isShow = !self.isShow
        }).disposed(by: disposeBag)
        
        Action.Noti.ChangeSpace.subscribe {[weak self] _ in
            guard let self = self else {return}
//            self.showBoard(false)
        }.disposed(by: disposeBag)

    }
    
    //MARK:细则
    func showPanel(_ isShow:Bool) {
        NSAnimationContext.runAnimationGroup { (context) in
            context.allowsImplicitAnimation = true
            context.duration = 0.2
            context.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            panelVC.view.frame = NSRect.init(x: isShow ? 0 : -Ruler.Size.MainPanelWidth, y: 0, width: Ruler.Size.MainPanelWidth, height: Ruler.Size.MainPanelHeight)
        }
    }
        
    override func validateProposedFirstResponder(_ responder: NSResponder, for event: NSEvent?) -> Bool {
        return true
    }
    
}
