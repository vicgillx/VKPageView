# VKPageView


VKPageView 是一个纯Swift的`PageView`框架,完全使用原生`AutoLayout`布局,并提供多种属性设置

- [Demo](#Demo)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)

## Demo
请使用`VKPageView.xcwrokspace`来运行

<img src="https://github.com/vicgillx/VKPageView/tree/master/Gif/normal.gif" width="30%" height="30%">
<img src="https://github.com/vicgillx/VKPageView/tree/master/Gif/leftButton.gif" width="30%" height="30%">

## Requirements
- iOS 10.0+
- Xcode 11+
- swift 5.0+

## Installation
### Carthage
[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate VKPageView into your Xcode project using Carthage

- specify it in your Cartfile
- `github  "vicgillx/VKPageView"`
- then use `carthage update`
### Swift Package Manager
To install IQKeyboardManager package via Xcode

- Go to File -> Swift Packages -> Add Package Dependency...
- Then search for `https://github.com/vicgillx/VKPageView`
- And choose the version you want

## Usage

### 初始化
```
//也可使用pageView = VKPageView.init(frame: self.view.bounds),但都必须指定height属性

	pageView = VKPageView.init(height: UIScreen.main.bounds.height)
	view.addSubview(pageView!)
	pageView?.dataSource = self
	pageView?.delegate = self
```
### 设置数据源dataSource
```
extension ViewController:VKPageDataSource{
	//设置page Count
    func pageViewNumberOfPageItmesCount() -> Int {
	
    }
    //设置title
    func pageViewTitleModels() -> [String] {
	
    }
    //设置content
    func pageView(cellForItemAt row: Int) -> UIView {

    }
}
```
### 样式设置
```
    let config = VKPageViewConfigure.init()
    config.titleConfigure.selectStyle = [.image(UIImage.init(named: "active_g"), CGSize.init(width: 80, height: 40))]
	//默认configure = VKPageViewConfigure.init()
    pageView = VKPageView.init(height: UIScreen.main.bounds.height,configure: config)
	//添加titleView左右两侧按钮
    pageView!.addSideButtonForTitle(size: CGSize.init(width: 25, height: 25), image: UIImage.init(named: "ss"), direction: .right) {
			// action
     }
```




