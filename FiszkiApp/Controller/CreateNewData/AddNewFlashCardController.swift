//
//  AddNewFlashCardController.swift
//  fiszki
//
//  Created by Leopold on 19/01/2021.
//

import UIKit
import RxSwift
import RxCocoa

protocol AddNewFlashCardControllerDelegate: class {
    func addNewFlashCard()
}

class AddNewFlashCardController: UIViewController {
    
    //MARK: - Properties
    
    var group: GroupItem?
    
    var viewModel = NewFlashCardViewModel()
    
    private let disposeBag = DisposeBag()
    
    weak var delegate: AddNewFlashCardControllerDelegate?
    
    
    private let flashCardView: UIView = {
        let flashView = UIView()
        return flashView
    }()
    
    private let termLabel: UILabel = {
        let label = UILabel()
        label.text = "Pojęcie"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 21)
        return label
    }()
    
    private let termTextField = CustomTextField(placeholder: "np. Apple")
    
    private let definitionLabel: UILabel = {
        let label = UILabel()
        label.text = "Definicja"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 21)
        return label
    }()
    
    private let definitionTextField = CustomTextField(placeholder: "np. Jabłko")
    
    lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Dodaj", for: .normal)
        button.isEnabled = true
        button.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.4392156863, blue: 0.9960784314, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleAddButton), for: .touchUpInside)
        return button
    }()
    
    private let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Gotowe", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.4392156863, blue: 0.9960784314, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleDoneButton), for: .touchUpInside)
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Anuluj", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.05098039216, green: 0.4392156863, blue: 0.9960784314, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleCancelButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Actions
    
    @objc func handleDoneButton() {
        delegate?.addNewFlashCard()
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleAddButton() {
        
        guard let term = termTextField.text else { return }
        
        guard let definition = definitionTextField.text else { return }
        
        termTextField.text = ""
        definitionTextField.text = ""
        configureNotificationsObservers()
        if let flashCard = FlashCardItem(term: term, definition: definition, didAnswerCorrectly: false, hasBeenUsed: false) {
            group?.addToRawFlashCards(flashCard)
            
            do {
                try flashCard.managedObjectContext?.save()
                delegate?.addNewFlashCard()
                
            } catch {
                print("DEBUG: Could not save flashcard... \(error.localizedDescription)")
            }
        } 
    }
    
    @objc func textDidChange(_ sender: UITextField) {
        
        if sender == termTextField {
            viewModel.termTextField = termTextField.text
        } else {
            viewModel.definitionTextField = definitionTextField.text
        }
        updateForm()
    }
    
    @objc func handleCancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        termTextField.delegate = self
        definitionTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        setupCardShadow(card: flashCardView)
        configureNotificationsObservers()
        view.addSubview(flashCardView)
        
        view.addSubview(cancelButton)
        cancelButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                            left: flashCardView.leftAnchor,
                            paddingTop: 10)
        
        flashCardView.anchor(top: cancelButton.bottomAnchor,
                             left: view.leftAnchor,
                             right: view.rightAnchor,
                             paddingTop: 30,
                             paddingLeft: 30,
                             paddingRight: 30,
                             height: 300)
        
        
        let stack = UIStackView(arrangedSubviews: [termLabel, termTextField, definitionLabel, definitionTextField])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 15
        
        
        flashCardView.addSubview(stack)
        stack.centerX(inView: flashCardView)
        stack.anchor(top: flashCardView.topAnchor,
                     paddingTop: 10,
                     paddingBottom: 15)
        
        flashCardView.addSubview(addButton)
        addButton.centerX(inView: flashCardView)
        addButton.anchor(top: stack.bottomAnchor,
                         bottom: flashCardView.bottomAnchor,
                         paddingTop: 30,
                         paddingBottom: 30,
                         width: 140,
                         height: 35)
        
        
        
        view.addSubview(doneButton)
        doneButton.centerX(inView: view)
        doneButton.anchor(top: flashCardView.bottomAnchor,
                          paddingTop: 50,
                          width: 200,
                          height: 50)
        
        setupButtonShadow(button: doneButton)
    }
    
    func configureNotificationsObservers() {
        termTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        definitionTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        
        termTextField.rx.text.map { $0 ?? ""}.bind(to: viewModel.termTextFieldPublishSubject).disposed(by: disposeBag)
        definitionTextField.rx.text.map { $0 ?? ""}.bind(to: viewModel.definitionTextFieldPublishSubject).disposed(by: disposeBag)
        
        viewModel.formIsValid().bind(to: addButton.rx.isEnabled).disposed(by: disposeBag)
        viewModel.formIsValid().map { $0 ? 1 : 0.4}.bind(to: addButton.rx.alpha).disposed(by: disposeBag)
    }
}

extension AddNewFlashCardController: FormViewModel {
    func updateForm() {
    }
}

extension AddNewFlashCardController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
}
