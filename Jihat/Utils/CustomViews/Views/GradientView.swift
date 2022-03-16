//
//  GradientView.swift
//  Jihat
//
//  Created by Peter Bassem on 15/09/2021.
//

import UIKit

@IBDesignable
public class GradientView: UIView {
    @IBInspectable var startColor:   UIColor = .black { didSet { updateColors() } }
    @IBInspectable var middleUpperColor:   UIColor? { didSet { updateColors() } }
    @IBInspectable var middleLowerColor:   UIColor? { didSet { updateColors() } }
    @IBInspectable var endColor:     UIColor = .white { didSet { updateColors() } }
    @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() } }
    @IBInspectable var middleUpperLocation:   Double = 0.0 { didSet { updateLocations() } }
    @IBInspectable var middleLowerLocation: Double = 0.0 { didSet { updateLocations() } }
    @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() } }
    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() } }
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() } }

    override public class var layerClass: AnyClass { CAGradientLayer.self }

    var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }

    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        if middleUpperLocation != 0.0 && middleLowerLocation != 0.0 {
            gradientLayer.locations = [startLocation as NSNumber, middleUpperLocation as NSNumber, middleLowerLocation as NSNumber, endLocation as NSNumber]
        } else {
            gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
        }
    }
    func updateColors() {
        if let middleUpperColor = middleUpperColor, let middleLowerColor = middleLowerColor {
            gradientLayer.colors = [startColor.cgColor, middleUpperColor.cgColor, middleLowerColor.cgColor, endColor.cgColor]
        } else {
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        }
    }
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updatePoints()
        updateLocations()
        updateColors()
    }

}
