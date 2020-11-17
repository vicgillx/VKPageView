
import UIKit

public struct VKpageTitleStyleLine{
    public var color = UIColor.red
    public var margin:CGFloat = 0
    public var lineWidth:CGFloat = 2
    public var isShadowAvailable = false
    public init(color:UIColor = .red,margin:CGFloat = 0,lineWidth:CGFloat = 2,isShadow:Bool = false) {
        self.color = color
        self.margin = margin
        self.lineWidth = lineWidth
        self.isShadowAvailable = isShadow
    }
}
public enum VKpageTitleStyle{
    case none
    //  (line color,margin,lineWidth,is shadow available)
    case line(VKpageTitleStyleLine)
    // ( image,image size )
    case image(UIImage?,CGSize)
}

public class VKpageTitleStyleManager:CALayer{
    var types = [VKpageTitleStyle].init()
    
    lazy var bottomImageLayer:CALayer = {
        let layer = CALayer.init()
        return layer
    }()
    
    public var hadAnimation = true
    
    var offsetY:CGFloat = 0
    
    var bottomSingleLine:CALayer?
    

    public init(styles:[VKpageTitleStyle],size:CGSize,offsetY:CGFloat = 0) {
        super.init()
        self.frame = CGRect.init(origin: CGPoint.zero, size: size)
        backgroundColor = UIColor.clear.cgColor
        zPosition = -1
        self.offsetY = offsetY
        self.types.append(contentsOf: styles)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public static func view(with styles:[VKpageTitleStyle]?,size:CGSize,offsetY:CGFloat = 0)->VKpageTitleStyleManager?{
        guard  let typs = styles else {
            return nil
        }
        return VKpageTitleStyleManager.init(styles: typs, size: size,offsetY: offsetY)
    }
    
    func setup(){
        for style in types{
            switch style {
            case .image(let image, let size):
                addSublayer(bottomImageLayer)
                let point = CGPoint.init(x: 0, y: self.frame.height -  size.height - offsetY)
                bottomImageLayer.frame = CGRect.init(origin: point, size: size)
                bottomImageLayer.contents = image?.cgImage
            case .line(let style):
                let y = bounds.height-style.lineWidth/2-offsetY
                let start = CGPoint.init(x: style.margin, y: y)
                let end = CGPoint.init(x: bounds.width - style.margin, y: y)
                bottomSingleLine = CAShapeLayer.init(from: start, to: end, strokeColor: style.color, fillColor: style.color,lineWidth: style.lineWidth)
                if style.isShadowAvailable{
                    bottomSingleLine?.shadowColor = style.color.cgColor
                    bottomSingleLine?.shadowOpacity = 0.7
                    bottomSingleLine?.shadowRadius = 5
                }
                addSublayer(bottomSingleLine!)
            default:
                break
            }
        }

    }
    
}
