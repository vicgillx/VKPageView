
import UIKit

public enum VKpageTitleStyle{
    case none
    //  (line color,margin,is shadow available)
    case line(UIColor,CGFloat,Bool)
    // ( image,image size )
    case image(UIImage?,CGSize)
}

public class VKpageTitleStyleManager:UIView{
    var types = [VKpageTitleStyle].init()
    
    lazy var bottomImageView:UIImageView = {
        let imageView = UIImageView.init()
        return imageView
    }()
    
    var bottomSingleLine:CALayer?
    
    init(styles:[VKpageTitleStyle],size:CGSize) {
        super.init(frame: CGRect.init(origin: CGPoint.zero, size: size))
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = false
        self.types.append(contentsOf: styles)
        setup()
    }
    
    public static func view(with styles:[VKpageTitleStyle]?,size:CGSize)->VKpageTitleStyleManager?{
        guard  let typs = styles else {
            return nil
        }
        return VKpageTitleStyleManager.init(styles: typs, size: size)
    }
    
    func setup(){
        for style in types{
            switch style {
            case .image(let image, let size):
                addSubview(bottomImageView)
                bottomImageView.translatesAutoresizingMaskIntoConstraints = false
                bottomImageView.image = image
                NSLayoutConstraint.activate([
                    bottomImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
                    bottomImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
                    bottomImageView.widthAnchor.constraint(equalToConstant: size.width),
                    bottomImageView.heightAnchor.constraint(equalToConstant: size.height)
                ])
            case .line(let lineColor, let margin, let isHadShadow):
                let start = CGPoint.init(x: margin, y: bounds.height-1)
                let end = CGPoint.init(x: bounds.width - margin, y: bounds.height-1)
                bottomSingleLine = CAShapeLayer.init(from: start, to: end, strokeColor: lineColor, fillColor: lineColor,lineWidth: 2)
                if isHadShadow{
                    bottomSingleLine?.shadowColor = lineColor.cgColor
                    bottomSingleLine?.shadowOpacity = 0.7
                    bottomSingleLine?.shadowRadius = 5
                }
                layer.addSublayer(bottomSingleLine!)
            default:
                break
            }
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
