//
//  CopyMePanelViewController.swift
//  CopyMe
//
//  Created by jqs on 2021/7/12.
//

import Cocoa

class CopyMePanelViewController: NSViewController {

    let btn = NSButton.init(frame: NSRect.init(x: 100, y: 100, width: 100, height: 100))
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view = CopyMePanelView()
        view.wantsLayer = true
        
        let collectionView = (view as! CopyMePanelView).collectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(CopyMeContentitem.self, forItemWithIdentifier: CopyMeContentitem.identifer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
            
    override func validateProposedFirstResponder(_ responder: NSResponder, for event: NSEvent?) -> Bool {
        return true
    }
}

extension CopyMePanelViewController: NSCollectionViewDelegate {
    
}

extension CopyMePanelViewController: NSCollectionViewDataSource {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
        
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: CopyMeContentitem.identifer, for: indexPath)
        return item
    }
    
}
