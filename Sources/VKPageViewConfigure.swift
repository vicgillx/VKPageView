//
//  VKPageViewConfigure.swift
//  VKPageView
//
//  Created by karl  on 8/9/2020.
//  Copyright © 2020 karl. All rights reserved.
//

import UIKit
public class VKPageViewTitleConfigure{
    //label configure
    public var textNormolColor = UIColor.init(red: 107.0/255.0, green: 106.0/255.0, blue: 163.0/255.0, alpha: 1)
    public var textSelectColor = UIColor.init(red: 255.0/255.0, green: 0, blue: 64.0/255.0,alpha: 1)
    public var font = UIFont.systemFont(ofSize: 13)
    
    //each cell
    public var cellBackgroundColor = UIColor.clear
    public var cellSelectBackgroundColor = UIColor.clear
    public var cellSelectBottomImage:UIImage?
    //public var cellSelectBottomImageSize = CGSize.init(width: 80, height: 20)
    public var cellSize = CGSize.init(width: 80, height: 44)
    //full titleView
    public var backgroundColor = UIColor.clear
    
    public var backgroundLayer :CALayer?
    
    public var selectStyle:VKpageTitleStyleManager?
    
    public init(){}
}
public class VKPageViewConfigure{
    public var titleConfigure = VKPageViewTitleConfigure.init()
    public var contentBackgroundColor = UIColor.clear
    public init(){}
}
