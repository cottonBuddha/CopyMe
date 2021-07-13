//
//  CopyMeContentitem.swift
//  CopyMe
//
//  Created by jqs on 2021/7/12.
//

import Cocoa

class CopyMeContentitem: NSCollectionViewItem {

    static let identifer = NSUserInterfaceItemIdentifier("CopyMeContentitem")
    
    let contentView = NSView()
    
    lazy var visualView: NSVisualEffectView = {
        let visualView = NSVisualEffectView()
        visualView.material = .hudWindow
        return visualView
    }()
    
    lazy var fromAppIcon: NSImageView = {
        let bgImgView = NSImageView.init()
        bgImgView.imageScaling = .scaleNone
        return bgImgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(visualView)
    }
        
    override func loadView() {
        view = contentView
        view.wantsLayer = true
//        view.layer?.backgroundColor = NSColor.green.cgColor
    }
    
    override func viewWillLayout() {
        super.viewWillLayout()
        visualView.frame = view.bounds
    }
    
    func configure(name: String) {

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

    }
    
}
