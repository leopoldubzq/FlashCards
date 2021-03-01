//
//  CustomCell.swift
//  fiszki
//
//  Created by Leopold on 18/01/2021.
//

import UIKit

class CustomCell: UITableViewCell {
    
    //MARK: - Properties
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(titleLabel)
        titleLabel.centerY(inView: self)
        titleLabel.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 20, paddingRight: 20)
        backgroundColor = .white
    }
    
    //MARK: - Helpers
    
    func configureCircleProgressBar() {
        let shapelayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapelayer.path = circularPath.cgPath
        shapelayer.strokeColor = UIColor.red.cgColor
        shapelayer.lineWidth = 10
        layer.addSublayer(shapelayer)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
