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
        addPageView()
        addRefreshButton()
        // Do any additional setup after loading the view.
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("height = \(view.safeAreaInsets.top+view.safeAreaInsets.bottom)")
        pageView?.selectIndex = titles.count - 1
    }

    
    func addPageView(){
        let config = VKPageViewConfigure()
        //每个page里待展示的view 距边框的距离,默认为0
        config.contentSideMargin = 20
        let size = CGSize.init(width: view.bounds.width, height: config.titleConfigure.cellSize.height)
        let layer = CAGradientLayer.init( startColor: UIColor.init(red: 50, green: 13, blue: 66), endColor: UIColor.init(red: 29, green: 31, blue: 84), size:size )
        config.titleConfigure.backgroundLayer = layer
        let underLine = VKpageTitleStyle.line(VKpageTitleStyleLine.init(color: .white, margin: 5,lineWidth: 8))
        let image = VKpageTitleStyle.image(UIImage.init(named: "active_g"), CGSize.init(width: 80, height: 40))
        config.titleConfigure.selectStyle = VKpageTitleStyleManager.init(styles: [underLine,image], size: config.titleConfigure.cellSize,offsetY: 0)
        config.titleConfigure.backgroundColor = UIColor.init(red: 14.0/255.0, green: 15.0/255.0, blue: 63.0/255.0, alpha: 1)
        let safeViewHeight = view.bounds.height - 81
        //指定pageView的高度，宽度为固定的screenWidth,没发现需要更改的场景 所以宽度固定
        pageView = VKPageView.init(height: safeViewHeight,configure: config)
        //是否添加titielview左右两边的按钮
//        pageView?.addSideButtonForTitle(size: CGSize.init(width: 80, height: 30), image: UIImage.init(named: "buttonImage"), direction: .left, action: {
//
//        })
        view.addSubview(pageView!)
        pageView?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageView!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pageView!.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pageView!.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pageView!.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        pageView?.dataSource = self
        pageView?.delegate = self
    }
    
    func addRefreshButton(){
        let refreshButton = UIButton.init(type: .custom)
        refreshButton.frame = CGRect.zero
        refreshButton.setTitle("刷新数据源", for: .normal)
        refreshButton.addTarget(self, action: #selector(refreshButtonClick), for: .touchUpInside)
        refreshButton.setTitleColor(UIColor.blue, for: .normal)
        view.addSubview(refreshButton)
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            refreshButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -50),
            refreshButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -50),
        ])
    }
    
    
    @objc func refreshButtonClick(){
        isChangeDataSource = !isChangeDataSource
        pageView!.reloadData()
    }
}

let titles = ["swift","object-c","ruby","go","python","xxxx","yyrt"]
let clos = [UIColor.red,UIColor.black,UIColor.yellow,UIColor.green,UIColor.blue,.brown,.blue]
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

