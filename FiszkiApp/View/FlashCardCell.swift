//
//  FlashCardCell.swift
//  fiszki
//
//  Created by Leopold on 18/01/2021.
//

import UIKit

class FlashCardCell: UITableViewCell {
    
    //MARK: - Properties
    
    var group: GroupItem?
    
    let termLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.text = "Pojęcie"
        label.textColor = .black
        return label
    }()
    
    let termDetails: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.text = "placeholder"
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.6)
        return label
    }()
    
    let definitionTerm: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.text = "Definicja"
        label.textColor = .black
        return label
    }()
    
    let definitionDetails: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.text = "placeholder"
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.6)
        return label
    }()
    
    let flashCardView: UIView = {
        let flashView = UIView()
        flashView.backgroundColor = .lightGray
        flashView.layer.cornerRadius = 20
        return flashView
    }()
    
    let yesCheckmarkImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "yesCheckmark")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let noCheckmarkImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "noCheckmark")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        setupCardShadow()
        
        
        addSubview(flashCardView)
        flashCardView.centerY(inView: self)
        flashCardView.anchor(left: leftAnchor,
                             right: rightAnchor,
                             paddingLeft: 20,
                             paddingRight: 20,
                             height: 180)
        
        flashCardView.addSubview(termLabel)
        termLabel.anchor(top: flashCardView.topAnchor,
                         left: flashCardView.leftAnchor,
                         paddingTop: 15, paddingLeft: 15)
        
        flashCardView.addSubview(termDetails)
        termDetails.anchor(top: termLabel.bottomAnchor,
                           left: flashCardView.leftAnchor,
                           right: flashCardView.rightAnchor,
                           paddingTop: 15,
                           paddingLeft: 15,
                           paddingRight: 15)
        
        flashCardView.addSubview(definitionTerm)
        definitionTerm.anchor(top: termDetails.bottomAnchor, left: flashCardView.leftAnchor, paddingTop: 15, paddingLeft: 15)
        
        flashCardView.addSubview(definitionDetails)
        definitionDetails.anchor(top: definitionTerm.bottomAnchor,
                           left: flashCardView.leftAnchor,
                           right: flashCardView.rightAnchor,
                           paddingTop: 15,
                           paddingLeft: 15,
                           paddingRight: 15)
        
        flashCardView.addSubview(yesCheckmarkImage)
        yesCheckmarkImage.centerY(inView: flashCardView)
        yesCheckmarkImage.anchor(right: flashCardView.rightAnchor, paddingRight: 30, width: 30, height: 30)
        
        flashCardView.addSubview(noCheckmarkImage)
        noCheckmarkImage.centerY(inView: flashCardView)
        noCheckmarkImage.anchor(right: flashCardView.rightAnchor, paddingRight: 23, width: 37, height: 37)
    }
    
    //MARK: - Helpers
    
    func setupCardShadow() {
        
        flashCardView.layer.cornerRadius = 8
        
        flashCardView.layer.shadowColor = UIColor.black.cgColor
        flashCardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        flashCardView.layer.shadowRadius = 5
        flashCardView.layer.shadowOpacity = 0.35
        flashCardView.backgroundColor = .white
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.red.cgColor, UIColor.green.cgColor]
        gradient.startPoint = CGPoint(x: 1, y: 1)
        gradient.endPoint = CGPoint(x: 0, y: 0)
        gradient.locations = [0,1]
        gradient.frame = flashCardView.bounds
        gradient.cornerRadius = 8
        
        flashCardView.layer.addSublayer(gradient)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
