//
//  CustomTextField.swift
//  fiszki
//
//  Created by Leopold on 20/01/2021.
//

import UIKit

class CustomTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Initialization
    
    convenience init(placeholder: String) {
        self.init(frame: .zero)
        self.placeholder = placeholder
    }
    
    //MARK: - Setup textfield appearance
    
    private func configure() {
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        leftView = spacer
        leftViewMode = .always
        textColor = .black
        backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).withAlphaComponent(0.1)
        keyboardAppearance = .dark
        setWidth(width: 220)
        layer.cornerRadius = 8
    }
}
