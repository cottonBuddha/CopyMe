//
//  RXExtension.swift
//  CopyMe
//
//  Created by jqs on 2021/7/12.
//

import Foundation
import RxSwift
import HotKey
import RxCocoa


private var rx_hot_key: UInt8 = 0

//extension Reactive where Base: HotKey {
//
//
//}


struct Extension<Base> {
    let base: Base
    init (_ base: Base) {
        self.base = base
    }
}

protocol ExtensionCompatible {
    associatedtype Compatible
    static var ex: Extension<Compatible>.Type { get }
    var ex: Extension<Compatible> { get }
}

extension ExtensionCompatible {
    static var ex: Extension<Self>.Type {
        return Extension<Self>.self
    }

    var ex: Extension<Self> {
        return Extension(self)
    }
}
