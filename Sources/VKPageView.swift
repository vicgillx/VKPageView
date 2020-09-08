

import UIKit

let titleCellIdentifier = "pageTitleCellID"
let contentCellIndentifier = "pageContentCellID"
open class VKPageView: UIView {

    let titleView = VKPageTitleView.init()
        
    let contentView = VKPageContentView.init()
    
    var isFirstTimeLoading :[Bool] = Array.init()
        
    public var selectIndex:Int = 0 { didSet{ reloadSelectIndex() } }
    
    weak public var delegate:VKPageViewDelegate?
    
    weak public var dataSource:VKPageDataSource?{ didSet{ refreshDataSource() } }

    
    public var viewCount :Int?
    
    var titleViewModels:[String] = Array.init()
    
    var contentViewModels:[UIView] = Array.init()
    
    var size:CGSize = CGSize.init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    
    var configure = VKPageViewConfigure.init()
    
    
    public init(frame:CGRect,configure:VKPageViewConfigure = VKPageViewConfigure.init()){
        super.init(frame: frame)
        size = frame.size
        self.configure = configure
        setupConfigure()
    }
    
    public init(height:CGFloat,configure:VKPageViewConfigure = VKPageViewConfigure.init()) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height))
        size = frame.size
        self.configure = configure
        setupConfigure()
    }


    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK:Private mothod
extension VKPageView{

    public func reloadData(){
        refreshDataSource()
    }
    
    public func refreshDataSource(){
        guard let tempDataSource = dataSource else {return}
        viewCount = tempDataSource.pageViewNumberOfPageItmesCount()
        titleViewModels = Array.init(tempDataSource.pageViewTitleModels())
        contentViewModels.removeAll()
        if viewCount != nil{
            for i in 0..<viewCount!{
                let cell = tempDataSource.pageView(cellForItemAt: i)
                contentViewModels.append(cell)
                isFirstTimeLoading.append(false)
            }
        }
        self.titleView.collectionView?.reloadData()
        self.contentView.collectionView?.reloadData()
    }
    
    func reloadSelectIndex(){
        contentView.collectionView?.scrollToItem(at: IndexPath.init(row: selectIndex, section: 0), at: .centeredHorizontally, animated: false)
        delegate?.pageViewDidShow(at :selectIndex)
        self.titleView.collectionView?.reloadData()
        contentView.collectionView?.reloadData()
    }
    
    func setupConfigure(){
        self.addSubview(titleView)
        self.addSubview(contentView)
        titleView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: self.topAnchor),
            titleView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleView.heightAnchor.constraint(equalToConstant: configure.titleStyle.cellSize.height),
            contentView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        setupTitileAndContentView()
        
        reloadData()
    }
    
    func setupTitileAndContentView(){
        titleView.setupConfigure(with: configure.titleStyle)
        contentView.setupConfigure(height: (self.size.height-configure.titleStyle.cellSize.height),width:size.width,backgroundColor:configure.contentBackgroundColor)

        titleView.collectionView!.dataSource = self
        titleView.collectionView!.delegate = self

        contentView.collectionView!.dataSource = self
        contentView.collectionView!.delegate = self
        
    }
    
    public func addSideButtonForTitle(size:CGSize,image:UIImage?,direction:VKSideButtonDirection,action:@escaping sideButtonAction){
        titleView.addSideButtonForTitle(size: size, image: image, direction: direction, action: action)
    }
    
    
}
// MARK:UICollectionViewDelegate,UICollectionViewDataSource
extension VKPageView:UICollectionViewDelegate,UICollectionViewDataSource{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewCount ?? 0
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

    }
    
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.isEqual(titleView.collectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: titleCellIdentifier, for: indexPath) as! VKPageTitleCollectionCell
            let isSelect = (indexPath.row == selectIndex)
            cell.update(with: titleViewModels[indexPath.row], isSelect: isSelect,configure:self.configure.titleStyle)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellIndentifier, for: indexPath) as! VKPageContentCollectionCell
            for subView in cell.contentView.subviews{
                subView.removeFromSuperview()
            }
            let collectionView = contentViewModels[indexPath.row]
            cell.setupConfigure(with: collectionView)
            return cell
        }

    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.isEqual(titleView.collectionView){
            self.selectIndex = indexPath.row
            titleView.collectionView?.reloadData()
        }
    }

}

// MARK:UIScrollViewDelegate
extension VKPageView:UIScrollViewDelegate{
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        guard let myDelegate = self.delegate else {
            return
        }
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        // 向右边滑动
        var nextIndex = 0
        if translation.x < 0{
            if self.selectIndex == (self.contentViewModels.count - 1){
                nextIndex = self.selectIndex
            }else{
                nextIndex = selectIndex + 1
            }
        }else if translation.x > 0{
            if self.selectIndex == 0{
                nextIndex = self.selectIndex
            }else{
                nextIndex = selectIndex - 1
            }
        }
        myDelegate.pageViewWillShowWhenDraggingContent(to: nextIndex)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.isEqual(contentView.collectionView){
            let offset = scrollView.contentOffset
            let index = Int(offset.x/contentView.frame.size.width)
            self.selectIndex = index
            self.titleView.collectionView?.scrollToItem(at: IndexPath.init(row: index, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}

