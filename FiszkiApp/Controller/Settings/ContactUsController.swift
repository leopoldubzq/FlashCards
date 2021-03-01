//
//  ContactUsController.swift
//  FiszkiApp
//
//  Created by Leopold on 04/02/2021.
//

import UIKit
import MessageUI

class ContactUsController: UIViewController {
    
    //MARK: - Properties
    
    
    
    private let sendMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Wyślij", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.4392156863, blue: 0.9960784314, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleSendMessageButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Actions
    
    @objc func handleSendMessageButton() {
        showMailComposer()
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(sendMessageButton)
        sendMessageButton.centerX(inView: view)
        sendMessageButton.centerY(inView: view)
        sendMessageButton.setDimensions(height: 50, width: 200)
    }
    
    func showMailComposer() {
        guard MFMailComposeViewController.canSendMail() else {
            print("DEBUG: Something went wrong...")
            return
        }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["leopold.romanowski@gmail.com"])
        composer.setSubject("Kontakt")
        present(composer, animated: true)
    }
}

extension ContactUsController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        let okAlert = UIAlertController(title: nil, message: "Wiadomość wysłana.", preferredStyle: .alert)
        okAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(okAlert, animated: true, completion: nil)
        
        controller.dismiss(animated: true, completion: nil)
        
    }
}

