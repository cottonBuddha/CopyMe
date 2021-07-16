//
//  CopyMeCellModel.swift
//  CopyMe
//
//  Created by jqs on 2021/7/16.
//

import Cocoa

protocol CopyMeCellModelProtocol {
    
    var selected: Bool { get set }
    var height: CGFloat { get }

    func clickAction()
    func wrap(item: AnyObject)
    
}

class CopyMeItemCellModel: CopyMeCellModelProtocol {
    
    var selected: Bool = false
    var height: CGFloat = 0.0
    
    //剪贴板内容
    var content = ""

    
    func wrap(item: AnyObject) {
        
    }

    func clickAction() {
        
    }

}
