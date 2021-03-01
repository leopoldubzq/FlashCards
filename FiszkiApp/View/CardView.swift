//
//  CardView.swift
//  TableViewTrainingApp
//
//  Created by Leopold on 25/01/2021.
//

import UIKit
import Lottie

enum SwipeDirection: Int {
    case left = -1
    case right = 1
}

protocol CardViewDelegate: class {
    func cardView(_ view: CardView, didAnswerCorrectly: Bool)
}

class CardView: UIView {
    
    //MARK: - Properties
    
    weak var delegate: CardViewDelegate?
    
    let viewModel = CardViewModel()
    
    lazy var gradient = CAGradientLayer()
    
    var flashCards = [FlashCardItem]()
    
    lazy var cardView: UIView = {
        let card = UIView()
        card.backgroundColor = .white
        card.layer.cornerRadius = 8
        card.layer.borderWidth = 1
        card.layer.borderColor = UIColor.lightGray.cgColor
        return card
    }()
    
    lazy var termLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.numberOfLines = 0
        label.text = "Pojęcie"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    lazy var termDetails: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.text = "placeholder"
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.6)
        label.textAlignment = .center
        return label
    }()
    
    lazy var definitionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.numberOfLines = 0
        label.text = "Definicja"
        label.textColor = .black
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    lazy var definitionDetails: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.text = "placeholder"
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.6)
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    lazy var rightLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Dobrze!"
        lbl.textColor = .systemGreen
        lbl.font = UIFont(name: "ChalkboardSE-Bold", size: 23)
        lbl.alpha = 0
        return lbl
    }()
    
    lazy var leftLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Źle :("
        lbl.textColor = .systemRed
        lbl.font = UIFont(name: "ChalkboardSE-Bold", size: 23)
        lbl.alpha = 0
        return lbl
    }()
    
    lazy var revealDefinitionButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Odkryj odpowiedź", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.4392156863, blue: 0.9960784314, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleRevealDefinitionButton),
                         for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return button
    }()
    
    //MARK: - Actions
    
    @objc func handlePanGesture(sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        
        case .began:
            superview?.subviews.forEach({ $0.layer.removeAllAnimations() })
        case .changed:
            panCard(sender: sender)
        case .ended:
            resetCardPosition(sender: sender)
        default: break
            
        }
        
        viewModel.configureRightLeftLabel(sender: sender,
                                          leftLabel: leftLabel,
                                          rightLabel: rightLabel)
    }
    
    @objc func handleRevealDefinitionButton() {
        updateForm()
    }
    
    //MARK: - Lifecycle
    
    init(term: String, definition: String) {
        super.init(frame: .zero)
        self.termDetails.text = term
        self.definitionDetails.text = definition
        configureUI()
        configureGestureRecognizers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Helpers
    
    func configureUI() {
        addSubview(cardView)
        cardView.fillSuperview()
        
        cardView.addSubview(termLabel)
        termLabel.centerX(inView: cardView)
        termLabel.anchor(top: cardView.topAnchor,
                         left: cardView.leftAnchor,
                         right: cardView.rightAnchor,
                         paddingTop: 15,
                         paddingLeft: 30,
                         paddingRight: 30,
                         height: 40)
        
        cardView.addSubview(definitionLabel)
        definitionLabel.centerX(inView: cardView)
        definitionLabel.anchor(top: cardView.topAnchor,
                               left: cardView.leftAnchor,
                               right: cardView.rightAnchor,
                               paddingTop: 15,
                               paddingLeft: 30,
                               paddingRight: 30,
                               height: 40)
        
        cardView.addSubview(termDetails)
        termDetails.centerX(inView: cardView)
        termDetails.anchor(top: termLabel.bottomAnchor,
                           left: cardView.leftAnchor,
                           right: cardView.rightAnchor,
                           paddingTop: 15,
                           paddingLeft: 30,
                           paddingRight: 30,
                           height: 30)
        
        cardView.addSubview(definitionDetails)
        definitionDetails.centerX(inView: cardView)
        definitionDetails.anchor(top: definitionLabel.bottomAnchor,
                                 left: cardView.leftAnchor,
                                 right: cardView.rightAnchor,
                                 paddingTop: 15,
                                 paddingLeft: 30,
                                 paddingRight: 30,
                                 height: 30)
        
        cardView.addSubview(revealDefinitionButton)
        revealDefinitionButton.setDimensions(height: 44, width: 170)
        revealDefinitionButton.centerX(inView: cardView)
        revealDefinitionButton.anchor(top: termDetails.bottomAnchor, paddingTop: 20)
        
        addSubview(rightLabel)
        rightLabel.anchor(top: topAnchor,
                          right: rightAnchor,
                          paddingTop: 30,
                          paddingRight: 5)
        
        addSubview(leftLabel)
        leftLabel.anchor(top: topAnchor,
                         left: leftAnchor,
                         paddingTop: 30,
                         paddingLeft: 15)
        
    }
    
    
    
    func setCardShadow(card: UIView) {
        
        card.layer.cornerRadius = 8
        
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOffset = CGSize(width: 0, height: 2)
        card.layer.shadowRadius = 5
        card.layer.shadowOpacity = 0.35
        card.backgroundColor = .white
        
        gradient = CAGradientLayer()
        gradient.colors = [UIColor.red.cgColor, UIColor.green.cgColor]
        gradient.startPoint = CGPoint(x: 1, y: 1)
        gradient.endPoint = CGPoint(x: 0, y: 0)
        gradient.locations = [0,1]
        gradient.frame = card.bounds
        gradient.cornerRadius = 8
        
        card.layer.addSublayer(gradient)
    }
    
    func updateForm() {
        viewModel.updateForm(termLabel: termLabel,
                             definitionLabel: definitionLabel,
                             termDetails: termDetails,
                             definitionDetails: definitionDetails,
                             button: revealDefinitionButton)
    }
    
    func configureGestureRecognizers() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        addGestureRecognizer(pan)
    }
    
    func panCard(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: nil)
        let degrees: CGFloat = translation.x / 20
        let angle = degrees * .pi / 180
        let rotationalTransform = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransform.translatedBy(x: translation.x, y: translation.y)
    }
    
    func resetCardPosition(sender: UIPanGestureRecognizer) {
        let direction: SwipeDirection = sender.translation(in: nil).x > 100 ? .right : .left
        let shouldDismissCard = abs(sender.translation(in: nil).x) > 100
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            if shouldDismissCard {
                let xTranslation = CGFloat(direction.rawValue) * 1000
                let offScreenTransform = self.transform.translatedBy(x: xTranslation, y: 0)
                self.transform = offScreenTransform
                
            } else {
                self.transform = .identity
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.3) {
                        self.rightLabel.alpha = 0
                        self.leftLabel.alpha = 0
                    }
                }
            }
            
        }) { _ in
            if shouldDismissCard {
                self.removeFromSuperview()
            }
        }
        
        if shouldDismissCard {
            
            let correctAnswer = direction == .right
            self.delegate?.cardView(self, didAnswerCorrectly: correctAnswer)
        }
        
    }
}
