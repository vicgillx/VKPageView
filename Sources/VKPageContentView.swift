
import UIKit

class VKPageContentView: UIView {

    var collectionView : UICollectionView?
    
    func setupConfigure(height:CGFloat,width:CGFloat,backgroundColor:UIColor){
        
        let layout = UICollectionViewFlowLayout.init()
        
        let size = CGSize.init(width: width, height: height)
        
        layout.itemSize = size
        
        layout.scrollDirection = .horizontal
        
        layout.minimumInteritemSpacing = 0
        
        collectionView?.isScrollEnabled = false
        
        layout.minimumLineSpacing = 0
        
        self.collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        
        
        self.addSubview(collectionView!)
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.collectionView!.topAnchor.constraint(equalTo: self.topAnchor),
            self.collectionView!.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.collectionView!.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.collectionView!.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
                
        self.collectionView!.register(VKPageContentCollectionCell.self, forCellWithReuseIdentifier: contentCellIndentifier)
        
        
        self.collectionView!.backgroundColor = backgroundColor
        
        self.collectionView!.isScrollEnabled = true
        
        self.collectionView!.showsHorizontalScrollIndicator = false
        
        self.collectionView!.isPagingEnabled = true

    }

}

class VKPageContentCollectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    var content:UIView?
    
    func setupConfigure(with subView:UIView,margin:CGFloat){
        self.contentView.addSubview(subView)
        content = subView
        subView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            subView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,constant: margin),
            subView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,constant: -margin),
            subView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
