//
//  Extensions.swift
//  fiszki
//
//  Created by Leopold on 18/01/2021.
//

import UIKit

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if let topAnchor = topAnchor, let padding = paddingTop {
            self.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive = true
        }
    }
    
    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil,
                 paddingLeft: CGFloat = 0, constant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
        
        if let left = leftAnchor {
            anchor(left: left, paddingLeft: paddingLeft)
        }
    }
    
    func setDimensions(height: CGFloat, width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setHeight(height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setWidth(width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func fillSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superviewTopAnchor = superview?.topAnchor,
            let superviewBottomAnchor = superview?.bottomAnchor,
            let superviewLeadingAnchor = superview?.leftAnchor,
            let superviewTrailingAnchor = superview?.rightAnchor else { return }
        
        anchor(top: superviewTopAnchor, left: superviewLeadingAnchor,
               bottom: superviewBottomAnchor, right: superviewTrailingAnchor)
    }
    
    func setupCardShadow(card: UIView) {
        
        card.layer.cornerRadius = 8
        
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOffset = CGSize(width: 0, height: 2)
        card.layer.shadowRadius = 5
        card.layer.shadowOpacity = 0.35
        card.backgroundColor = .white
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.red.cgColor, UIColor.green.cgColor]
        gradient.startPoint = CGPoint(x: 1, y: 1)
        gradient.endPoint = CGPoint(x: 0, y: 0)
        gradient.locations = [0,1]
        gradient.frame = card.bounds
        gradient.cornerRadius = 8
        
        card.layer.addSublayer(gradient)
    }
    
    func setupButtonShadow(button: UIButton) {
        
        button.layer.cornerRadius = 15
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.35
        button.backgroundColor = #colorLiteral(red: 0.2770560902, green: 0.4351817718, blue: 1, alpha: 1)
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.red.cgColor, UIColor.green.cgColor]
        gradient.startPoint = CGPoint(x: 1, y: 1)
        gradient.endPoint = CGPoint(x: 0, y: 0)
        gradient.locations = [0,1]
        gradient.frame = button.bounds
        gradient.cornerRadius = 15
        
        button.layer.addSublayer(gradient)
    }
    
    func setupLabelShadow(label: UILabel) {
        
        label.layer.cornerRadius = 15
        
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 2)
        label.layer.shadowRadius = 5
        label.layer.shadowOpacity = 0.35
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.red.cgColor, UIColor.green.cgColor]
        gradient.startPoint = CGPoint(x: 1, y: 1)
        gradient.endPoint = CGPoint(x: 0, y: 0)
        gradient.locations = [0,1]
        gradient.frame = label.bounds
        gradient.cornerRadius = 15
        
        label.layer.addSublayer(gradient)
    }
}

extension UIViewController {
    func configureGradientBackground() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }
    
    func setupCardShadow(card: UIView) {
        
        card.layer.cornerRadius = 8
        
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOffset = CGSize(width: 0, height: 2)
        card.layer.shadowRadius = 5
        card.layer.shadowOpacity = 0.35
        card.backgroundColor = .white
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.red.cgColor, UIColor.green.cgColor]
        gradient.startPoint = CGPoint(x: 1, y: 1)
        gradient.endPoint = CGPoint(x: 0, y: 0)
        gradient.locations = [0,1]
        gradient.frame = card.bounds
        gradient.cornerRadius = 8
        
        card.layer.addSublayer(gradient)
    }
    
    func setupButtonShadow(button: UIButton) {
        
        button.layer.cornerRadius = 15
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.35
        button.backgroundColor = #colorLiteral(red: 0.2770560902, green: 0.4351817718, blue: 1, alpha: 1)
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.red.cgColor, UIColor.green.cgColor]
        gradient.startPoint = CGPoint(x: 1, y: 1)
        gradient.endPoint = CGPoint(x: 0, y: 0)
        gradient.locations = [0,1]
        gradient.frame = button.bounds
        gradient.cornerRadius = 15
        
        button.layer.addSublayer(gradient)
    }
    
    func setupLabelShadow(label: UILabel) {
        
        label.layer.cornerRadius = 15
        
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 2)
        label.layer.shadowRadius = 5
        label.layer.shadowOpacity = 0.35
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.red.cgColor, UIColor.green.cgColor]
        gradient.startPoint = CGPoint(x: 1, y: 1)
        gradient.endPoint = CGPoint(x: 0, y: 0)
        gradient.locations = [0,1]
        gradient.frame = label.bounds
        gradient.cornerRadius = 15
        
        label.layer.addSublayer(gradient)
    }
}

extension UIImage {
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.y, y: -origin.x,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return rotatedImage ?? self
        }

        return self
    }
}


