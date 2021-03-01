//
//  SettingsController.swift
//  FiszkiApp
//
//  Created by Leopold on 03/02/2021.
//

import UIKit
import MessageUI

class SettingsController: UIViewController {
    
    //MARK: - Properties
    
    var groups = [GroupItem]()
    
    var group: GroupItem?
    
    private let tableView = UITableView()
    
    //MARK: - Actions
    
    //MARK: - CoreData
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationBar()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Settings"
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.fillSuperview()
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = .black
        
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "cell")
        //tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.tableFooterView = UIView()
    }
    
    func showReportMailComposer() {
        guard MFMailComposeViewController.canSendMail() else {
            print("DEBUG: Something went wrong...")
            return
        }
        
        let englishBody = "What went wrong?\n\n\n\n\n\n\nIf you have any screenshot or a screen recording, please include it in the message. It's gonna make it easier for developers to locate the problem."
        
        let body = "Co poszło nie tak?\n\n\n\n\n\n\nJeżeli posiadasz screena bądź nagranie ekranu, załącz je w wiadomości. Ułatwi to pracę deweloperom w lokalizacji problemu."
        
        let composer = MFMailComposeViewController()
        
        composer.mailComposeDelegate = self
        composer.setToRecipients(["leopold.romanowski@gmail.com"])
        composer.setSubject("Bug report")
        composer.setMessageBody(englishBody, isHTML: false)
        
        present(composer, animated: true)
    }
    
    func showContactMailComposer() {
        guard MFMailComposeViewController.canSendMail() else {
            print("DEBUG: Something went wrong...")
            return
        }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["leopold.romanowski@gmail.com"])
        composer.setSubject("Contact")
        present(composer, animated: true)
    }
}

extension SettingsController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.allCases.count
    }
     
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).withAlphaComponent(0.15)
        view.layer.borderWidth = 0.15
        
        view.layer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        let title = UILabel()
        title.font = .systemFont(ofSize: 13)
        title.text = SettingsSection(rawValue: section)?.description
        title.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1).withAlphaComponent(0.80)
        view.addSubview(title)
        title.centerY(inView: view)
        title.anchor(left: view.leftAnchor, paddingLeft: 15)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = SettingsSection(rawValue: section) else { return 0 }
        
        switch section {
        case .General: return GeneralOptions.allCases.count
        case .Contact: return ContactOptions.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingsCell
        
        guard let section = SettingsSection(rawValue: indexPath.section) else { return  UITableViewCell() }
        switch section {
        case .General:
            let general = GeneralOptions(rawValue: indexPath.row)
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = general?.description
        case .Contact:
            let contact = ContactOptions(rawValue: indexPath.row)
            cell.accessoryType = .none
            cell.textLabel?.text = contact?.description
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let section = SettingsSection(rawValue: indexPath.section) else { return }
        
        switch section {
        case .General:
            switch indexPath.row {
            case 0:
                let controller = RemoveDataController()
                controller.groups = groups
                controller.group = group
                navigationController?.pushViewController(controller, animated: true)
            default: break
            }
        case .Contact:
            switch indexPath.row {
            case 0:
                showReportMailComposer()
            case 1:
                showContactMailComposer()
            default: break
            }
        }
    }
}

extension SettingsController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        
        
        if result == .cancelled {
            controller.dismiss(animated: true, completion: nil)
        }
        
        controller.dismiss(animated: true) {
            let okAlert = UIAlertController(title: nil, message: "The message has been sent.", preferredStyle: .alert)
            okAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(okAlert, animated: true, completion: nil)
        }
    }
}
