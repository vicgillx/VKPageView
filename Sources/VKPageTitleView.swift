
import UIKit
public enum VKSideButtonDirection {
    case left
    case right
}

public typealias sideButtonAction = () ->()

public class VKPageTitleView: UIView {

    public var collectionView : UICollectionView?
    
    var leftCollectionConstraint : NSLayoutConstraint? = nil
    
    var rightCollectionConstraint : NSLayoutConstraint? = nil
    
    var configure = VKPageViewTitleConfigure.init()
    
    func setupConfigure(with configure:VKPageViewTitleConfigure){
        
        self.configure = configure
        
        if let backLayer = configure.backgroundLayer{
            self.layer.insertSublayer(backLayer, at: 0)
        }
        
        self.backgroundColor = configure.backgroundColor
        
        let layout = UICollectionViewFlowLayout.init()
        
        layout.itemSize = configure.cellSize
        
        layout.scrollDirection = .horizontal
        
        layout.minimumInteritemSpacing = 0
        
        layout.minimumLineSpacing = 0
        
        self.collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        
        
        self.collectionView!.register(VKPageTitleCollectionCell.self, forCellWithReuseIdentifier: titleCellIdentifier)
        
        self.collectionView!.backgroundColor = UIColor.clear
        
        self.collectionView!.isScrollEnabled = true
        
        self.collectionView!.showsHorizontalScrollIndicator = false
        
        self.addSubview(collectionView!)
        
        self.leftCollectionConstraint = self.collectionView!.leftAnchor.constraint(equalTo: self.leftAnchor)
        self.rightCollectionConstraint = self.collectionView!.rightAnchor.constraint(equalTo: self.rightAnchor)
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.collectionView!.topAnchor.constraint(equalTo: self.topAnchor),
            self.collectionView!.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.leftCollectionConstraint!,
            self.rightCollectionConstraint!
        ])
        
    }
    
    

    

    
    var sideActionBlock :sideButtonAction?
    
    @objc func pressSideButton(sender:UIButton){
        sideActionBlock!()
    }
    var sideButton = UIButton.init()
    
    func addSideButtonForTitle(size:CGSize,image:UIImage?,direction:VKSideButtonDirection,action:@escaping sideButtonAction){
        
        self.addSubview(sideButton)
        sideButton.setImage(image, for: .normal)
        sideButton.addTarget(self, action: #selector(pressSideButton(sender:)), for: .touchUpInside)
        sideButton.imageView?.contentMode = .scaleAspectFit
        sideButton.isUserInteractionEnabled = true
        
        
        
        sideActionBlock = action
        sideButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sideButton.topAnchor.constraint(equalTo: self.topAnchor),
            sideButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            sideButton.widthAnchor.constraint(equalToConstant: size.width)
        ])

        let sideOffset : CGFloat = 10.0
        switch direction {
        case .left:
            guard let left = self.leftCollectionConstraint else {
                return
            }
            NSLayoutConstraint.deactivate([left])
            NSLayoutConstraint.activate([
                sideButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: sideOffset),
                sideButton.rightAnchor.constraint(equalTo: self.collectionView!.leftAnchor, constant: -sideOffset)
            ])

        default:
            guard let right = self.rightCollectionConstraint else {return}
            NSLayoutConstraint.deactivate([right])
            NSLayoutConstraint.activate([
                sideButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -sideOffset),
                sideButton.leftAnchor.constraint(equalTo: self.collectionView!.rightAnchor, constant: sideOffset)
            ])

        }

    }
}



class VKPageTitleCollectionCell: UICollectionViewCell {

    
    var titleLabel = UILabel.init()
    
    var bottomImageView = UIImageView.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup(){
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.backgroundColor  = .clear
        titleLabel.textColor = UIColor.init(red: 107.0/255.0, green: 106.0/255.0, blue: 163.0/255.0, alpha: 1)
        titleLabel.text = ""
        titleLabel.textAlignment = .center
        self.contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])

        
        self.contentView.addSubview(bottomImageView)
        bottomImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            bottomImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            bottomImageView.widthAnchor.constraint(equalToConstant: 40),
            bottomImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        
    }
    
    func update(with title:String,isSelect:Bool,configure:VKPageViewTitleConfigure){
        titleLabel.text = title
        if isSelect{
            titleLabel.textColor = configure.textSelectColor
            bottomImageView.image = configure.cellSelectBottomImage
        }else{
            titleLabel.textColor = configure.textNormolColor
            bottomImageView.image = nil
        }
        titleLabel.backgroundColor = configure.cellBackgroundColor
        titleLabel.font = configure.font
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


