//
//  AddGroupController.swift
//  fiszki
//
//  Created by Leopold on 18/01/2021.
//

import UIKit

protocol AddGroupControllerDelegate: class {
    func addGroup(name: String)
}

class AddGroupController: UIViewController {
    
    //MARK: - Properties
    
    var viewModel = NewGroupViewModel()
    
    var homeController = HomeController()
    
    weak var delegate: AddGroupControllerDelegate?
    
    var groups = [GroupItem]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private let titleView: UIView = {
        let titleView = UIView()
        return titleView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Group name"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
     
    private let newGroupTextField = CustomTextField(placeholder: "e.g. English")
    
    private let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.isEnabled = false
        button.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.4392156863, blue: 0.9960784314, alpha: 1).withAlphaComponent(0.5)
        button.setTitleColor(UIColor(white: 1, alpha: 0.67), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleDoneButton), for: .touchUpInside)
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.05098039216, green: 0.4392156863, blue: 0.9960784314, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleCancelButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationsObservers()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - Actions
    
    @objc func textDidChange(_ sender: UITextField) {
        if sender == newGroupTextField {
            viewModel.groupTitleTextField = newGroupTextField.text
        }
        
        updateForm()
    }
    
    @objc func handleDoneButton() {
        guard let title = newGroupTextField.text else { return }
        
        dismiss(animated: true, completion: nil)
        delegate?.addGroup(name: title)
        
    }
    
    @objc func handleCancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        setupCardShadow(card: titleView)
        view.addSubview(titleView)
        
        view.addSubview(cancelButton)
        cancelButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                            left: titleView.leftAnchor,
                            paddingTop: 10)
        
        
        titleView.anchor(top: cancelButton.bottomAnchor,
                                left: view.leftAnchor,
                                right: view.rightAnchor,
                                paddingTop: 30,
                                paddingLeft: 30,
                                paddingRight: 30,
                                height: 150)
        
        
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, newGroupTextField])
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        
        titleView.addSubview(stack)
        
        view.addSubview(stack)
        stack.centerX(inView: titleView)
        stack.anchor(top: titleView.topAnchor, bottom: titleView.bottomAnchor, paddingTop: 15, paddingBottom: 30)
        
        view.addSubview(doneButton)
        
        doneButton.centerX(inView: view)
        doneButton.anchor(top: titleView.bottomAnchor, paddingTop: 30, width: 200, height: 50)
        
    }
    
    func configureNotificationsObservers() {
        newGroupTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}

extension AddGroupController: FormViewModel {
    func updateForm() {
        doneButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        doneButton.backgroundColor = viewModel.buttonBackgroundColor
        doneButton.isEnabled = viewModel.shouldEnableButton
    }
}
