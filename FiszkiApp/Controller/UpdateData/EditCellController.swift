//
//  EditCellController.swift
//  FiszkiApp
//
//  Created by Leopold on 27/01/2021.
//

import UIKit


class EditCellController: UIViewController {
    
    //MARK: - Properties
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var flashCards = [FlashCardItem]()
    
    var viewModel = EditFlashCardViewModel()
    
    var group: GroupItem?
    
    var index: Int?
    
    var hasBeenUsed: Bool?
    
    private let flashCardView: UIView = {
        let flashView = UIView()
        return flashView
    }()
    
    private let termLabel: UILabel = {
        let label = UILabel()
        label.text = "Pojęcie"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 21)
        return label
    }()
    
    private let termTextField = CustomTextField(placeholder: "np. Apple")
    
    private let definitionLabel: UILabel = {
        let label = UILabel()
        label.text = "Definicja"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 21)
        return label
    }()
    
    private let definitionTextField = CustomTextField(placeholder: "np. Jabłko")
    
    private let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Zapisz", for: .normal)
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
        
        guard let term = termTextField.text else { return }
        
        guard let definition = definitionTextField.text else { return }
        
        guard let index = index else { return }
        
        guard let flashCardItem = group?.flashCards?[index] else { return }
        
        guard let hasBeenUsed = hasBeenUsed else { return }
        
        if flashCardItem.didAnswerCorrectly == true {
        if let flashCard = FlashCardItem(term: term, definition: definition, didAnswerCorrectly: true, hasBeenUsed: hasBeenUsed) {
            
            group?.replaceRawFlashCards(at: index, with: flashCard)
            
            
            do {
                try flashCard.managedObjectContext?.save()
                
                dismiss(animated: true, completion: nil)
                
            } catch {
                print("DEBUG: Could not edit flashcard... \(error.localizedDescription)")
            }
        }  
        } else {
            if let flashCard = FlashCardItem(term: term, definition: definition, didAnswerCorrectly: false, hasBeenUsed: hasBeenUsed) {
                
                group?.replaceRawFlashCards(at: index, with: flashCard)
                
                
                do {
                    try flashCard.managedObjectContext?.save()
                    
                    dismiss(animated: true, completion: nil)
                    
                } catch {
                    print("DEBUG: Could not edit flashcard... \(error.localizedDescription)")
                }
            }
        }
}
    @objc func handleCancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func textDidChange(_ sender: UITextField) {
        
        if sender == termTextField {
            viewModel.termTextField = termTextField.text
        } else {
            viewModel.definitionTextField = definitionTextField.text
        }
        //updateForm()
    }
    
    @objc func textDidUpdate(_ sender: UITextField) {
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //checkIfTextFieldAreEmpty()
        configureUI()
        
    }
    
    convenience init(term: String, definition: String, array: [FlashCardItem]?, indexPath: Int, group: GroupItem?, hasBeenUsed: Bool) {
        self.init()
        termTextField.text = term
        definitionTextField.text = definition
        index = indexPath
        self.group = group
        self.hasBeenUsed = hasBeenUsed
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        //updateForm()
        
        
        
        view.backgroundColor = .systemBackground
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
                             paddingTop: 20,
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
                     bottom: flashCardView.bottomAnchor,
                     paddingTop: 30,
                     paddingBottom: 60)
        
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
        
        termTextField.addTarget(self, action: #selector(textDidUpdate), for: .editingDidEnd)
        definitionTextField.addTarget(self, action: #selector(textDidUpdate), for: .editingDidEnd)
    }
    
    func checkIfTextFieldAreEmpty() {
        if (termTextField.text?.isEmpty == true
            && definitionTextField.text?.isEmpty == true) {
            updateForm()
        }
    }
    
    //MARK: - CORE DATA
    
    func getAllItems() {
        do {
            flashCards = try context.fetch(FlashCardItem.fetchRequest())
        } catch {
            print("DEBUG: Failed to fetch request... [CORE DATA PROBLEM])")
        }
    }
    
    func createItem(term: String, definition: String) {
        let newItem = FlashCardItem(context: context)
        newItem.term = term
        newItem.definition = definition
        do {
            try context.save()
            getAllItems()
        } catch {
            print("DEBUG: Failed to save data... [CORE DATA PROBLEM])")
        }
    }
    
    func deleteItem(item: FlashCardItem) {
        context.delete(item)
        
        do {
            try context.save()
            getAllItems()
        } catch {
            print("DEBUG: Failed to delete data... [CORE DATA PROBLEM])")
        }
    }
    
    func updateItem(item: FlashCardItem, newTerm: String, newDefinition: String) {
        item.term = newTerm
        item.definition = newDefinition
        getAllItems()
    }
}

extension EditCellController: FormViewModel {
    func updateForm() {
        doneButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        doneButton.backgroundColor = viewModel.buttonBackgroundColor
        doneButton.isEnabled = viewModel.shouldEnableButton
    }
    
}
