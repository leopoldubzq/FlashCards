//
//  RemoveDataController.swift
//  FiszkiApp
//
//  Created by Leopold on 04/02/2021.
//

import UIKit

private let reuseIdentifier = "cell"

class RemoveDataController: UIViewController {
    
    //MARK: - Properties
    
    private let data = [
        "Usuń fiszki", "Usuń wszystko"
    ]
    
    var group: GroupItem?
    
    var groups = [GroupItem]()
    
    private let tableView = UITableView()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: - Actions
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        configureTabBar()
    }
    //MARK: - Helpers
    
    func configureUI() {
        
        //BACKGROUND COLOR
        view.backgroundColor = .white
        
        //ADDING SUBVIEWS
        view.addSubview(tableView)
        tableView.fillSuperview()
    }
    
    func configureTabBar() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = "Wyzeruj dane"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingsCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
    }
    
    func deleteAllGroups() {
        groups.forEach { (group) in
            deleteGroupItem(item: group)
        }
    }
    
    func deleteGroupItem(item: GroupItem) {
        context.delete(item)
        do {
            try context.save()
        } catch {
            print("DEBUG: Failed to delete data...\(error))")
        }
    }
    
    func deleteFlashCardItem(item: FlashCardItem) {
        context.delete(item)
        do {
            try context.save()
        } catch {
            print("DEBUG: Failed to delete data...\(error))")
        }
    }
    
    func deleteAllFlashCards() {
        groups.forEach { (group) in
            group.flashCards?.forEach({ (flashCard) in
                deleteFlashCardItem(item: flashCard)
            })
        }
    }
}

extension RemoveDataController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SettingsCell
        cell.textLabel?.text = data[indexPath.row]
        
        if indexPath.row == 1 {
            cell.textLabel?.textColor = .red
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            let alert = UIAlertController(title: nil, message: "Czy na pewno chcesz usunąć wszystkie fiszki?", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Usuń", style: .destructive, handler: { _ in
                let okAlert = UIAlertController(title: "Pomyślnie usunięto fiszki.", message: nil, preferredStyle: .alert)
                okAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(okAlert, animated: true, completion: nil)
                self.deleteAllFlashCards()
            }))
            alert.addAction(UIAlertAction(title: "Anuluj", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            
        case 1:
            let alert = UIAlertController(title: "Czy na pewno chcesz usunąć całą zawartość aplikacji?", message: "Stracisz wszystkie grupy i fiszki wraz z postępem.", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Usuń", style: .destructive, handler: { _ in
                let okAlert = UIAlertController(title: "Pomyślnie usunięto zawartość aplikacji.", message: nil, preferredStyle: .alert)
                okAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(okAlert, animated: true, completion: nil)
                self.deleteAllGroups()
            }))
            alert.addAction(UIAlertAction(title: "Anuluj", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        default: break
        }
        
    }
}
    
