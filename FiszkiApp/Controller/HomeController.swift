//
//  HomeController.swift
//  fiszki
//
//  Created by Leopold on 18/01/2021.
//

import UIKit
import Lottie
import CoreData

class HomeController: UIViewController, UIGestureRecognizerDelegate {

    //MARK: - Properties
    
    let animationView = AnimationView()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let tableView = UITableView()
    
    let viewModel = NewGroupViewModel()
    
    var groups = [GroupItem]()
    
    var group: GroupItem?
    
    let longPressGesture = UILongPressGestureRecognizer()
    
    var index = 0
    
    private let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "gear"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(handleSettingsButton), for: .touchUpInside)
        return button
    }()
    
    private let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleEditButton), for: .touchUpInside)
        let att = NSAttributedString(string: "Edit", attributes: [.font: UIFont.boldSystemFont(ofSize: 17)])
        button.setAttributedTitle(att, for: .normal)
        return button
    }()
    
    private let addFlashCardView: UIView = {
        let flashView = UIView()
        return flashView
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "add-button"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.05098039216, green: 0.4392156863, blue: 0.9960784314, alpha: 1)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(handleAddGroup), for: .touchUpInside)
        return button
    }()
    
    private let addNewFlashCardLabel: UILabel = {
        let label = UILabel()
        label.text = "Create a new group"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - CORE DATA
    
    func getAllItems() {
        do {
            groups = try context.fetch(GroupItem.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("DEBUG: Failed to fetch request...\(error)")
        }
    }

    func deleteItem(item: GroupItem) {
        context.delete(item)
        do {
            try context.save()
            getAllItems()
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
    
    func createItem(name: String, at indexPath: Int) {
        let newItem = GroupItem(context: context)
        newItem.name = name
        self.group = groups[indexPath]
        
        do {
            try context.save()
            getAllItems()
        } catch {
            
            //error
        }
        
    }
    
    func updateItem(item: GroupItem, newName: String) {
        item.name = newName
        getAllItems()
    }
    
    //MARK: - Actions
    
    @objc func handleAddGroup() {
        let controller = AddGroupController()
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    
    @objc func handleSettingsButton() {
        let controller = SettingsController()
        controller.groups = groups
        controller.group = group
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleEditButton() {
        if (tableView.isEditing) {
            tableView.isEditing = false
        } else {
            tableView.isEditing = true
        }
    }
    
    @objc func handleLongPressGesture(_ press: UILongPressGestureRecognizer) {
        if press.state == .began {
            let menu = UIMenuController.shared
            becomeFirstResponder()
            
            let menuItem = UIMenuItem(title: "Edit", action: #selector(handleMenuItemTap))
            menu.menuItems = [menuItem]
            let location = press.location(in: press.view)
            let menuLocation = CGRect(x: location.x, y: location.y, width: 0, height: 0)
            menu.showMenu(from: press.view!, rect: menuLocation)
        }
    }
    
    @objc func handleMenuItemTap() {
        
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavigationBar()
        //getAllItems()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<GroupItem> = GroupItem.fetchRequest()

        do {
            groups = try managedContext.fetch(fetchRequest)

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        } catch {
            print("DEBUG: Could reload group data... \(error.localizedDescription)")
        }
        
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        
        checkIfArrayIsEmpty()
        
        view.backgroundColor = .white
        
        
        longPressGesture.addTarget(self, action: #selector(handleLongPressGesture))
        
        view.addSubview(addFlashCardView)
        addFlashCardView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                left: view.leftAnchor,
                                right: view.rightAnchor,
                                paddingTop: 30,
                                paddingLeft: 30,
                                paddingRight: 30,
                                height: 150)
        
        setupCardShadow(card: addFlashCardView)
        
        
        
        addFlashCardView.addSubview(addNewFlashCardLabel)
        addNewFlashCardLabel.centerX(inView: addFlashCardView)
        addNewFlashCardLabel.anchor(top: addFlashCardView.topAnchor,
                                    paddingTop: 30)


        addFlashCardView.addSubview(addButton)
        addButton.centerX(inView: addFlashCardView)
        addButton.anchor(top: addNewFlashCardLabel.bottomAnchor,
                         paddingTop: 15,
                         width: 50, height: 50)
        
        view.addSubview(tableView)
        
        tableView.anchor(top: addFlashCardView.bottomAnchor,
                         left: view.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.rightAnchor,
                         paddingTop: 30,
                         paddingLeft: 30,
                         paddingBottom: 30,
                         paddingRight: 30)
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.title = "Groups"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(handleSettingsButton))
        
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                                           target: self,
                                                           action: #selector(handleEditButton))
        
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func configureTableView() {
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.backgroundColor = .white
        tableView.addGestureRecognizer(longPressGesture)
    }
    
    func checkIfArrayIsEmpty() {
        if groups.count == 0 {
            navigationItem.leftBarButtonItem?.tintColor = .lightGray
            navigationItem.leftBarButtonItem?.isEnabled = false
        } else {
            navigationItem.leftBarButtonItem?.isEnabled = true
            navigationItem.leftBarButtonItem?.tintColor = .black
        }
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let item = groups[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Delete") { (action, view, completion) in
            self.deleteItem(item: item)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.checkIfArrayIsEmpty()
        }
        action.image = UIImage(systemName: "xmark.bin.fill")
        action.backgroundColor = .red
        return action
    }
}

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
        
        let group = groups[indexPath.row]
        cell.textLabel?.text = group.name
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let title = groups[indexPath.row].name else { return }
        
        let controller = FlashCardController(title: title)
        
        controller.group = groups[indexPath.row]
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

extension HomeController: AddGroupControllerDelegate {
    func addGroup(name: String) {
        
        let newItem = GroupItem(context: context)
        newItem.name = name
        
        do {
            try context.save()
            getAllItems()
        } catch {
            
            print("DEBUG: Could reload group data... \(error.localizedDescription)")
        }
    }
}

extension HomeController: EditGroupNameControllerDelegate {
    func editGroupName(name: String) {
        let item = groups[index]
        updateItem(item: item, newName: name)
        print(item.name!)
    }
}
