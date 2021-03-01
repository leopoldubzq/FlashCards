//
//  CardViewModel.swift
//  FiszkiApp
//
//  Created by Leopold on 26/01/2021.
//

import UIKit

struct CardViewModel {
    
    func updateForm(termLabel: UILabel, definitionLabel: UILabel, termDetails: UILabel, definitionDetails: UILabel, button: UIButton) {
        termLabel.isHidden = !termLabel.isHidden
        definitionLabel.isHidden = !definitionLabel.isHidden
        termDetails.isHidden = !termDetails.isHidden
        definitionDetails.isHidden = !definitionDetails.isHidden
        button.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.4392156863, blue: 0.9960784314, alpha: 1).withAlphaComponent(0.5)
        button.setTitleColor(UIColor(white: 1, alpha: 0.5), for: .normal)
        button.isEnabled = false
    }
    
    func configureRightLeftLabel(sender: UIPanGestureRecognizer, leftLabel: UILabel, rightLabel: UILabel) {
        
        rightLabel.transform = CGAffineTransform(rotationAngle: (.pi / 8))
        leftLabel.transform = CGAffineTransform(rotationAngle: -(.pi / 8))
        
        let translation = sender.translation(in: nil)
        rightLabel.alpha = translation.x / 100
        leftLabel.alpha = -translation.x / 100
        
    }
    
}
