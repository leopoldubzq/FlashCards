//
//  SettingsCell.swift
//  FiszkiApp
//
//  Created by Leopold on 03/02/2021.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    //MARK: - Properties
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Test"
        lbl.font = .systemFont(ofSize: 20)
        lbl.textAlignment = .left
        return lbl
    }()
    
    //MARK: - Lifecycle
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        backgroundColor = .white
        
//        addSubview(titleLabel)
//        titleLabel.centerY(inView: self)
//        titleLabel.anchor(left: leftAnchor, paddingLeft: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
