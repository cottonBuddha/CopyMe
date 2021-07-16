//
//  CopyMePanelView.swift
//  CopyMe
//
//  Created by jqs on 2021/7/12.
//

import Cocoa

class CopyMePanelView: NSView {
    
    let textView = NSTextField.init(frame: NSRect.init(x: 20, y: 0, width: 200, height: 200))
    let searchBar = NSView.init()
    var scrollViewCollectionView = NSScrollView()
    
    lazy var collectionView: NSCollectionView = {
        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.itemSize = NSSize(width: Ruler.Size.MainPanelWidth, height: 200.0)
        flowLayout.sectionInset = NSEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
        flowLayout.minimumInteritemSpacing = 20.0
        flowLayout.minimumLineSpacing = 20.0
        flowLayout.scrollDirection = .vertical
        let collectionView = NSCollectionView()
        collectionView.wantsLayer = true
        collectionView.layer?.backgroundColor = NSColor.clear.cgColor
        collectionView.collectionViewLayout = flowLayout
        collectionView.backgroundColors = [.clear]

        return collectionView
    }()

//    lazy var visualView: NSVisualEffectView = {
//        let visualView = NSVisualEffectView()
//        visualView.material = .hudWindow
//        return visualView
//    }()
    
    lazy var bgImgView: NSImageView = {
        let bgImgView = NSImageView.init(image: NSImage.init(named: "474477")!)
        bgImgView.imageScaling = .scaleNone
        return bgImgView
    }()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
//        addSubview(visualView)
//        addSubview(bgImgView)
        
        scrollViewCollectionView.drawsBackground = false
        scrollViewCollectionView.backgroundColor = NSColor.clear
        scrollViewCollectionView.documentView = collectionView
        scrollViewCollectionView.scrollerStyle = .overlay
        scrollViewCollectionView.hasVerticalScroller = true
        scrollViewCollectionView.verticalScroller?.isHidden = true
        scrollViewCollectionView.translatesAutoresizingMaskIntoConstraints = false
        scrollViewCollectionView.scrollerInsets = NSEdgeInsets(top:0, left:0, bottom:0, right:-20)
        addSubview(scrollViewCollectionView)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layout() {
//        visualView.frame = bounds
        bgImgView.frame = bounds
        scrollViewCollectionView.frame = bounds
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    
    
}

//class CopyMeCollectionView: NSCollectionView {
//
//    override func frameForItem(at index: Int, withNumberOfItems numberOfItems: Int) -> NSRect {
//        return NSRect.init(x: 5, y: 0, width: Ruler.Size.MainPanelWidth - 10, height: 30)
//    }
//
//    override func item(at indexPath: IndexPath) -> NSCollectionViewItem? {
//        let item = self.makeItem(withIdentifier: CopyMeContentitem.identifer, for: indexPath)
//        return item
//    }
//}
