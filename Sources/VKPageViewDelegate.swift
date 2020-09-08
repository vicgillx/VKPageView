
import UIKit

@objc public protocol VKPageViewDelegate:NSObjectProtocol {
     func pageViewDidShow(at row:Int)
     func pageViewWillShowWhenDraggingContent(to row:Int)
}


@objc public protocol VKPageDataSource:NSObjectProtocol{
    func pageViewNumberOfPageItmesCount()->Int
    func pageView(cellForItemAt row:Int) ->UIView
    func pageViewTitleModels()->[String]
    
}
