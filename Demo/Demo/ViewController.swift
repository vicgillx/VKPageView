//
//  ViewController.swift
//  Demo
//
//  Created by karl  on 8/9/2020.
//  Copyright © 2020 karl. All rights reserved.
//

import UIKit
import VKPageView
class ViewController: UIViewController {
    var pageView : VKPageView?
    var isChangeDataSource = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let refreshButton = UIButton.init(type: .custom)
        refreshButton.frame = CGRect.init(x: 0, y: 40.0, width: UIScreen.main.bounds.width, height: 100)
        refreshButton.setTitle("点击我刷新数据源", for: .normal)
        refreshButton.addTarget(self, action: #selector(refreshButtonClick), for: .touchUpInside)
        refreshButton.setTitleColor(UIColor.blue, for: .normal)
        view.addSubview(refreshButton)
        let config = VKPageViewConfigure()
        pageView = VKPageView.init(frame: CGRect.init(x: 0, y: 140, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-140), configure: config)
        
        view.addSubview(pageView!)

        pageView?.dataSource = self
        pageView?.delegate = self
    }
    @objc func refreshButtonClick(){
        isChangeDataSource = !isChangeDataSource
        pageView!.reloadData()
    }
}

let titles = ["swift","object-c","ruby","go","python"]
let clos = [UIColor.red,UIColor.black,UIColor.yellow,UIColor.green,UIColor.blue]
let titles2 = ["a1","a2","a3","a4"]
let clos2 = [UIColor.yellow,UIColor.gray,UIColor.black,UIColor.red]

extension ViewController:VKPageViewDelegate{
    func pageViewDidShow(at row: Int) {
        print("did show index = \(row)")
    }
    
    func pageViewWillShowWhenDraggingContent(to row: Int) {
        print("will show index = \(row)")
    }
    
    
}

extension ViewController:VKPageDataSource{
    func pageViewNumberOfPageItmesCount() -> Int {
        var count = titles.count
        if isChangeDataSource{
            count = titles2.count
        }
        return count
    }
    
    func pageViewTitleModels() -> [String] {
        var pageTitles = titles
        if isChangeDataSource{
            pageTitles = titles2
        }
        return pageTitles
    }
    
    func pageView(cellForItemAt row: Int) -> UIView {
        let view = UIView.init()
        var selecColors = clos
        if isChangeDataSource{
            selecColors = clos2
        }
        view.backgroundColor = selecColors[row]
        let label = UILabel.init(frame: CGRect.init(x: 100, y: 100, width: 150, height: 50))
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 25)
        label.text = "index = \(row)"
        view.addSubview(label)
        return view
    }
}

