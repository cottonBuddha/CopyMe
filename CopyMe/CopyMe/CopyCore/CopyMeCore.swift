//
//  CopyMeCore.swift
//  CopyMe
//
//  Created by jqs on 2021/7/14.
//

import Cocoa
import RxSwift
import RxRelay
import RealmSwift

//realm文档：https://docs.mongodb.com/realm-sdks/swift/latest/Extensions.html#/s:Sa


public protocol PasteboardAbility {
    //搜索
    func search()
    //选中
    func select()
    //删除
    func delete()
    //新增
    func insert()

}



class RLMCopyItem: Object {
    @Persisted dynamic var contentDesc: String?//用于查找
    @Persisted dynamic var dataHash = ""
    @Persisted dynamic var dataPath: String?
    @Persisted dynamic var iconPath: String?

}


class CopyItem:NSObject, NSCoding {
    
    fileprivate static let Types          = "types"
    fileprivate static let StringValueKey = "stringValue"
    fileprivate static let RTFDataKey     = "RTFData"
    fileprivate static let PDFKey         = "PDF"
    fileprivate static let FileNamesKey   = "filenames"
    fileprivate static let URLsKey        = "URL"
    fileprivate static let ImageKey       = "image"
    
    var types: [NSPasteboard.PasteboardType] = []

    var dispalyData:Display?
    
    //raw
    var stringValue = ""
    var RTFData: Data?
    var PDF: Data?
    var image: NSImage?

    
    struct Display {
        var appIcon: NSImage = NSImage()//默认图片
        var stringValue = ""
        var RTFData: Data?
        var PDF: Data?
        var image: NSImage?
    }
    
    
    
    
    // MARK: - NSCoding
    @objc
    func encode(with aCoder: NSCoder) {
        aCoder.encode(types.map { $0.rawValue }, forKey: CopyItem.Types)
        aCoder.encode(stringValue, forKey: CopyItem.StringValueKey)

    }

    @objc
    required init(coder aDecoder: NSCoder) {
        types = (aDecoder.decodeObject(forKey: CopyItem.Types) as? [String])?.compactMap { NSPasteboard.PasteboardType(rawValue: $0) } ?? []
        stringValue = aDecoder.decodeObject(forKey: CopyItem.StringValueKey) as? String ?? ""
    }


}

class CoffeeDrink: Object {
    
    @Persisted var name = ""
    @Persisted var hotOrCold: String?
    @Persisted var rating = 0
    
    let realm1 = try! Realm()
    
    func save() {
        try! realm1.write {
            // Add coffee shop and drink info here.
            let drink = CoffeeDrink()
            drink.name = "Maple Latte"
            drink.rating = 7
            realm1.add(drink)
        }
    }
}




class CopyMeCore {
    
    static let shared = CopyMeCore()
    
    var items:[CopyItem] = []

    private let pasteboard = NSPasteboard.general
    private var disposeBag = DisposeBag()
    
    private var cachedChangeCount = BehaviorRelay<Int>(value: 0)
    private let lock = NSLock.init()
    private let scheduler = SerialDispatchQueueScheduler(qos: .userInteractive)


    private init() {
        
        //准备数据
        //准备监听
        startMonitoring()
        
        
    }
    

    func startMonitoring() {
        disposeBag = DisposeBag()
        // Pasteboard observe timer
        Observable<Int>.interval(.microseconds(750), scheduler: scheduler)
            .map { [weak self] _ in
                guard let self = self else {return 0}
                return self.pasteboard.changeCount
            }
            .withLatestFrom(cachedChangeCount.asObservable()) { ($0, $1) }
            .filter { $0 != $1}
            .subscribe(onNext: { [weak self] changeCount, _ in
                self?.cachedChangeCount.accept(changeCount)
                self?.create()
            })
            .disposed(by: disposeBag)
    }
        
    func create() {
        lock.lock(); defer { lock.unlock() }
        guard let items = pasteboard.pasteboardItems, items.count > 0 else { return }
        items.forEach({receiveCopyItem(transto($0))})
    }

    //转换
    private func transto(_ item: NSPasteboardItem) -> CopyItem {
        
        return CopyItem()
    }


    
    //=============================
    // pure function
    //=============================
    //接收
    func receiveCopyItem(_ item: CopyItem) {
        //接收到新剪贴板事件，做存储，本地化，更新数据源逻辑
        print(item)
    }
    
    //输出到欲粘贴处，若无权限，则仅输出到剪贴板
    func outputCopyItem(_ item: CopyItem) {
        //
        
    }
    
}

class DataManager {
    
}
