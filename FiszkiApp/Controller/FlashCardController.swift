//
//  FlashCardController.swift
//  fiszki
//
//  Created by Leopold on 19/01/2021.
//

import UIKit
import CoreData



class FlashCardController: UIViewController {
    
    //MARK: - Properties
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var flashCards = [FlashCardItem]()
    
    var group: GroupItem?
    
    var answers = [Answer]()
    
    var correctAnswers = [CorrectAnswer]()
    
    var wrongAnswers = [WrongAnswer]()
    
    private let tableView = UITableView()
    
    var lastScores = [LastScore]()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.text = "Placeholder"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let lastScoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Last \n score"
        return label
    }()
    
    private let percentageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "0%"
        return label
    }()
    
    private let numberOfFlashCardsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.8)
        label.text = "Placeholder"
        label.textAlignment = .center
        return label
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "chevron.left")
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        return button
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(handleAddButton), for: .touchUpInside)
        return button
    }()
    
    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Let's go!", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.4392156863, blue: 0.9960784314, alpha: 1).withAlphaComponent(0.95)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleStartButton), for: .touchUpInside)
        return button
    }()
    
    private let progressBar: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.trackTintColor = #colorLiteral(red: 0.05098039216, green: 0.4392156863, blue: 0.9960784314, alpha: 1).withAlphaComponent(0.5)
        progressView.progressTintColor = #colorLiteral(red: 0.05098039216, green: 0.4392156863, blue: 0.9960784314, alpha: 1)
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 2
        return progressView
    }()
    
    //MARK: - CORE DATA
    
    func deleteFlashCard(at indexPath: IndexPath) {
        guard let flashCard = group?.flashCards?[indexPath.row],
              let managedContext = flashCard.managedObjectContext else {
            return
        }
        
        managedContext.delete(flashCard)
        
        do {
            try managedContext.save()
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } catch {
            print("DEBUG: Could not delete... \(error.localizedDescription)")
            
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func deleteAnswer(at indexPath: IndexPath) {
        guard let answer = group?.answers?[indexPath.row],
              let managedContext = answer.managedObjectContext else {
            return
        }
        
        managedContext.delete(answer)
        
        do {
            try managedContext.save()
        } catch {
            print("DEBUG: Could not delete... \(error.localizedDescription)")
        }
    }
    
    func deleteRightAnswer() {
        
        guard let rightAnswersCount = group?.rightAnswers?.count else { return }
        
        guard let rightAnswer = group?.rightAnswers?[rightAnswersCount - 1],
              let managedContext = rightAnswer.managedObjectContext else {
            return
        }
        
        managedContext.delete(rightAnswer)
        
        do {
            try managedContext.save()
            
            
        } catch {
            print("DEBUG: Could not delete... \(error.localizedDescription)")
        }
    }
    
    func deleteWrongAnswer() {
        
        guard let wrongAnswersCount = self.group?.wrongAnswers?.count else { return }
        
        guard let wrongAnswer = group?.wrongAnswers?[wrongAnswersCount - 1],
              let managedContext = wrongAnswer.managedObjectContext else {
            return
        }
        
        managedContext.delete(wrongAnswer)
        
        do {
            try managedContext.save()
        } catch {
            print("DEBUG: Could not delete... \(error.localizedDescription)")
        }
    }
    
    //MARK: - Actions
    
    @objc func handleBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleAddButton() {
        let controller = AddNewFlashCardController()
        controller.group = group
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    
    @objc func handleStartButton() {
        
        guard let array = group?.flashCards else { return }
        
        let controller = SwipeFlashCardsController(flashCards: array, correctAnswers: correctAnswers, wrongAnswers: wrongAnswers)
        controller.group = group
        controller.delegate = self
        controller.modalPresentationStyle = .fullScreen

        
        navigationController?.navigationBar.isHidden = true
        
        guard let count = group?.flashCards?.count else { return }
        
        if count > 0 {
            present(controller, animated: true, completion: nil)
        }
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        navigationController?.navigationBar.barTintColor = .systemBackground
        view.backgroundColor = .white
 
        guard let count = group?.flashCards?.count else { return }
        
        numberOfFlashCardsLabel.text = "Number of flashcards: \(count)"
        
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          left: view.leftAnchor,
                          paddingTop: 15,
                          paddingLeft: 25)
        
        view.addSubview(addButton)
        addButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         right: view.rightAnchor,
                         paddingTop: 15,
                         paddingRight: 25)
        
        view.addSubview(lastScoreLabel)
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          left: view.leftAnchor,
                          right: lastScoreLabel.leftAnchor,
                          paddingTop: 60,
                          paddingLeft: 30,
                          paddingRight: 30,
                          width: 200)

        view.addSubview(numberOfFlashCardsLabel)
        numberOfFlashCardsLabel.centerX(inView: titleLabel)
        numberOfFlashCardsLabel.anchor(top: titleLabel.bottomAnchor, paddingTop: 40)

        setupButtonShadow(button: startButton)

        
        lastScoreLabel.anchor(top: titleLabel.topAnchor,
                              right: addButton.leftAnchor,
                              paddingRight: 15)
        
        view.addSubview(percentageLabel)
        percentageLabel.centerX(inView: lastScoreLabel)
        percentageLabel.centerY(inView: numberOfFlashCardsLabel)
        
        view.addSubview(progressBar)
        progressBar.centerX(inView: view)
        progressBar.anchor(top: numberOfFlashCardsLabel.bottomAnchor,
                           left: numberOfFlashCardsLabel.leftAnchor,
                           right: percentageLabel.rightAnchor,
                           paddingTop: 30,
                           height: 7)
        
        view.addSubview(tableView)
        tableView.anchor(top: progressBar.bottomAnchor,
                         left: view.leftAnchor,
                         bottom: view.bottomAnchor,
                         right: view.rightAnchor,
                         paddingTop: 20)
        
        view.addSubview(startButton)
        startButton.centerX(inView: view)
        startButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                           paddingBottom: 30,
                           width: 200,
                           height: 50)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        fetchDataAboutSwipes()
        configureProgressBarColor()
    }
    
    convenience init(title: String) {
        self.init()
        self.titleLabel.text = title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        fetchDataAboutSwipes()
    }
    
    func configureTableView() {
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(FlashCardCell.self, forCellReuseIdentifier: "FlashCardCell")
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 220
        tableView.backgroundColor = .white
    }
    
    func calculateEffectiveness() -> Int {
        
        guard let lastScoreCount = group?.lastScore?.count else { return 0 }
        
        guard let lastRightAnswers = group?.lastRightAnswer?.count else { return 0 }
        
        if lastRightAnswers == 0 && lastScoreCount == 0 {
            return 0
        }
        
        let effectiveness = Float(lastRightAnswers) / Float(lastScoreCount)
            
            let decimalPlaces = 0.0
            
            let multiplier = pow(10, decimalPlaces)
            
            let result = round(Double(effectiveness * 100) * multiplier) / multiplier
        
            return Int(result)
    }
    
    func setProgressBar() {
        
        guard let lastScoreCount = group?.lastScore?.count else { return }
        
        guard let lastRightAnswers = group?.lastRightAnswer?.count else { return }
        
        if lastRightAnswers == 0 && lastScoreCount == 0  {
            return progressBar.setProgress(0, animated: true)
        }
        
        let progress = Float(lastRightAnswers) / Float(lastScoreCount)
        
        progressBar.setProgress(progress, animated: true)
    }
    
    func configureProgressBarColor() {
        switch calculateEffectiveness() {
        case 0...39: return darkRedProgressBar()
        case 40...59: return lightRedProgressBar()
        case 60...90: return lightBlueProgressBar()
        case 91...100: return blueProgressBar()
        default: break
        }
    }
    
    func darkRedProgressBar() {
        progressBar.trackTintColor = #colorLiteral(red: 0.6689509554, green: 0, blue: 0.006262555315, alpha: 1).withAlphaComponent(0.5)
        progressBar.progressTintColor = #colorLiteral(red: 0.6689509554, green: 0, blue: 0.006262555315, alpha: 1)
    }
    
    func lightRedProgressBar() {
        progressBar.trackTintColor = #colorLiteral(red: 1, green: 0.41747839, blue: 0.152556437, alpha: 1).withAlphaComponent(0.5)
        progressBar.progressTintColor = #colorLiteral(red: 1, green: 0.41747839, blue: 0.152556437, alpha: 1)
    }
    
    func lightBlueProgressBar() {
        progressBar.trackTintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1).withAlphaComponent(0.5)
        progressBar.progressTintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    }
    
    func blueProgressBar() {
        progressBar.trackTintColor = #colorLiteral(red: 0.05098039216, green: 0.4392156863, blue: 0.9960784314, alpha: 1).withAlphaComponent(0.5)
        progressBar.progressTintColor = #colorLiteral(red: 0.05098039216, green: 0.4392156863, blue: 0.9960784314, alpha: 1)
    }
}

extension FlashCardController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return group?.flashCards?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlashCardCell") as! FlashCardCell
        
        let term = group?.flashCards?[indexPath.row].term
        let definition = group?.flashCards?[indexPath.row].definition
        
        if group?.flashCards?[indexPath.row].hasBeenUsed == false {
            cell.yesCheckmarkImage.isHidden = true
            cell.noCheckmarkImage.isHidden = true
        } else if group?.flashCards?[indexPath.row].didAnswerCorrectly == true {
            cell.yesCheckmarkImage.isHidden = false
            cell.noCheckmarkImage.isHidden = true
        } else if group?.flashCards?[indexPath.row].didAnswerCorrectly == false {
            cell.yesCheckmarkImage.isHidden = true
            cell.noCheckmarkImage.isHidden = false
        }

        cell.group = group
        cell.termDetails.text = term
        cell.definitionDetails.text = definition
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let term = group?.flashCards?[indexPath.row].term else { return }
        guard let definition = group?.flashCards?[indexPath.row].definition else { return }
        guard let hasBeenUsed = group?.flashCards?[indexPath.row].hasBeenUsed else { return }
        
        let controller = EditCellController(term: term, definition: definition, array: group?.flashCards, indexPath: indexPath.row, group: group, hasBeenUsed: hasBeenUsed)
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {

            if let answersArrayIsEmpty = group?.answers?.isEmpty {
                if answersArrayIsEmpty {
                    deleteFlashCard(at: indexPath)
                } else {
                    if group?.flashCards?[indexPath.row].hasBeenUsed == false {
                        deleteFlashCard(at: indexPath)
                    }
                    else if (group?.answers?[indexPath.row].didAnswerCorrectly == true) {
                        deleteAnswer(at: indexPath)
                        deleteFlashCard(at: indexPath)
                        deleteRightAnswer()
                    } else if (group?.answers?[indexPath.row].didAnswerCorrectly == false) {
                        deleteAnswer(at: indexPath)
                        deleteWrongAnswer()
                        deleteFlashCard(at: indexPath)
                    }
                }
            }

            guard let count = group?.flashCards?.count else { return }

            DispatchQueue.main.async {
                self.numberOfFlashCardsLabel.text = "Ilość fiszek: \(count)"
                self.percentageLabel.text = "\(self.calculateEffectiveness())%"
                self.setProgressBar()
            }
        }
    }
}

extension FlashCardController: SwipeFlashCardsControllerDelegate {
    func fetchDataAboutSwipes() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<FlashCardItem> = FlashCardItem.fetchRequest()
        
        do {
            flashCards = try managedContext.fetch(fetchRequest)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        } catch {
            print("DEBUG: Could reload group data... \(error.localizedDescription)")
        }
        
        guard let count = group?.flashCards?.count else { return }
 
        DispatchQueue.main.async {
            self.numberOfFlashCardsLabel.text = "Number of flashcards: \(count)"
            self.percentageLabel.text = "\(self.calculateEffectiveness())%"
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.setProgressBar()
            }
            self.tableView.reloadData()
        }
    }
}

extension FlashCardController: AddNewFlashCardControllerDelegate {
    func addNewFlashCard() {
        fetchDataAboutSwipes()
    }
}
