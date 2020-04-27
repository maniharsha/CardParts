//
//  CardHeaderCell.swift
//  CardParts
//
//  Created by manne  on 4/15/20.
//

import Foundation
import UIKit

open class CardHeaderCell : UICollectionReusableView {
    
    var cardContentView : UIView
    var cardContentConstraints = [NSLayoutConstraint]()
    var topBottomMarginConstraints = [NSLayoutConstraint]()
    
    private var currentSize = CGSize.zero
    private var gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        
        cardContentView = UIView()
        cardContentView.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = UIColor.white
        self.layer.borderColor = UIColor.Gray7.cgColor
        self.layer.borderWidth = 0.5
        if CardParts.theme.cardShadow {
            self.layer.shadowColor = UIColor.Gray7.cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 1)
            self.layer.shadowRadius = 1.0
            self.layer.shadowOpacity = 0.9
        }
        
        self.addSubview(cardContentView)
        self.backgroundColor = UIColor.white
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[cardContentView]|",
                                                                  options: [],
                                                                  metrics: nil,
                                                                  views: ["cardContentView" : cardContentView]))
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        gestureRecognizers?.forEach { removeGestureRecognizer($0) }
    }
    
    override open var bounds: CGRect {
        didSet {
            gradientLayer.frame = self.bounds
        }
    }
    
    override open func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {

        let desiredHeight: CGFloat = self.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        let desiredWidth: CGFloat = self.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).width

        if currentSize.height != desiredHeight || currentSize.width != desiredWidth || currentSize != layoutAttributes.size {
            let attr = super.preferredLayoutAttributesFitting(layoutAttributes)
            attr.frame.size.height = desiredHeight
            attr.frame.size.width = desiredWidth
            currentSize = attr.frame.size
            return attr
        }
        return layoutAttributes
    }
}
