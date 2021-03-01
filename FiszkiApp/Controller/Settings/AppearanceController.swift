//
//  AppearanceController.swift
//  FiszkiApp
//
//  Created by Leopold on 03/02/2021.
//

import UIKit

private let reuseIdentifier = "cell"

class AppearanceController: UIViewController {
    
    //MARK: - Properties
    
    private let motive = [
        "Tryb jasny", "Tryb ciemny", "Według systemu"
    ]
    
    private let tableView = UITableView()
    
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
        navigationItem.title = "Appearance"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingsCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
    }
}

extension AppearanceController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return motive.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SettingsCell
        cell.textLabel?.text = motive[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
//        }
        
        
    }
}
    
