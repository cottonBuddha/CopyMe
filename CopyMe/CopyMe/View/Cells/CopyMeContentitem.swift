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
//        view.layer?.cornerRadius = 20
        
    }
    
    override func viewWillLayout() {
        super.viewWillLayout()
        visualView.frame = CGRect.init(x: 10, y: 0, width: Ruler.Size.MainPanelWidth - 20, height: Ruler.Size.MainPanelHeight)
        visualView.layer?.cornerRadius = 20
    }
    
    func configure(name: String) {

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

    }
    
}
