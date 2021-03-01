//
//  SwipeFlashCardsController.swift
//  fiszki
//
//  Created by Leopold on 20/01/2021.
//

import UIKit
import Lottie

protocol SwipeFlashCardsControllerDelegate: class {
    func fetchDataAboutSwipes()
}

class SwipeFlashCardsController: UIViewController {
    
    //MARK: - Properties
    
    
    var flashCards = [FlashCardItem]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let viewModel = Animations()
    
    var swipeViewModel = SwipeFlashCardViewModel()
    
    private var topCardView: CardView?
    
    private var cardViews = [CardView]()
    
    var correctAnswers = [CorrectAnswer]()
    
    var answers = [Answer]()
    
    var wrongAnswers = [WrongAnswer]()
    
    var group: GroupItem?
    
    private var counter: Float = 0
    
    private var counter2 = 0
    
    var lastScores = [LastScore]()
    
    var lastRightAnswers = [LastRightAnswer]()
    
    weak var delegate: SwipeFlashCardsControllerDelegate?
    
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Wyjdź", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.05098039216, green: 0.4392156863, blue: 0.9960784314, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleCancelButton), for: .touchUpInside)
        return button
    }()
    
    private let deckView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let flashCardView: UIView = {
        let card = UIView()
        return card
    }()
    
    let termLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.text = "Pojęcie"
        label.tintColor = .black
        return label
    }()
    
    let termDetails: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.text = "placeholder"
        label.tintColor = .black
        return label
    }()
    
    let definitionTerm: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.text = "Definicja"
        label.tintColor = .black
        return label
    }()
    
    let definitionDetails: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.text = "placeholder"
        label.tintColor = .black
        return label
    }()
    
    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setDimensions(height: 50, width: 100)
        button.setTitle("Koniec", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.4392156863, blue: 0.9960784314, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleDismissButotn),
                         for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return button
    }()
    
    private let rightView: UIView = {
        let animationView = UIView()
        animationView.backgroundColor = .white
        animationView.alpha = 0
        return animationView
    }()
    
    private let leftView: UIView = {
        let animationView = UIView()
        animationView.backgroundColor = .white
        animationView.alpha = 0
        return animationView
    }()
    
    private let yesCheckMarkView: UIImageView = {
        let yesImage = UIImageView()
        yesImage.image = UIImage(named: "yesCheckmark")
        yesImage.contentMode = .scaleAspectFit
        yesImage.backgroundColor = .white
        yesImage.alpha = 0
        return yesImage
    }()
    
    private let noCheckMarkView: UIImageView = {
        let noImage = UIImageView()
        noImage.image = UIImage(named: "noCheckmark")
        noImage.backgroundColor = .white
        noImage.alpha = 0
        return noImage
    }()
    
    private let numberOfFlashCardsLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .boldSystemFont(ofSize: 20)
        lbl.textAlignment = .center
        lbl.text = ""
        lbl.textColor = .black
        return lbl
    }()
    
    private let remainedFlashCardsView: UIView = {
        let flashView = UIView()
        flashView.backgroundColor = .white
        return flashView
    }()
    
    private let progressBar: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.trackTintColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1).withAlphaComponent(0.2)
        progressView.progressTintColor = #colorLiteral(red: 0.05098039216, green: 0.4392156863, blue: 0.9960784314, alpha: 1)
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 8
        return progressView
    }()
    
    private let correctAnswerLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Dobra odpowiedź:"
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 22)
        return lbl
    }()
    
    private let numberOfCorrectAnswersLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "0"
        lbl.textColor = .systemGreen
        lbl.font = .boldSystemFont(ofSize: 22)
        return lbl
    }()
    
    private let wrongAnswerLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Zła odpowiedź:"
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 22)
        return lbl
    }()
    
    private let numberOfWrongAnswersLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "0"
        lbl.textColor = .systemRed
        lbl.font = .boldSystemFont(ofSize: 22)
        return lbl
    }()
    
    //MARK: - CORE DATA METHODS
    
    func getRightAnswerItems() {
        do {
            correctAnswers = try context.fetch(CorrectAnswer.fetchRequest())
            
        } catch {
            
            print("DEBUG: Could not save context... \(error.localizedDescription)")
        }
    }
    
    func createRightAnswerItem(term: String, definition: String) {
        let newItem = CorrectAnswer(context: context)
        newItem.term = term
        newItem.definition = definition
        do {
            try context.save()
            getRightAnswerItems()
        } catch {
            
            print("DEBUG: Could not create item... \(error.localizedDescription)")
        }
    }
    
    func deleteRightAnswerItem(item: CorrectAnswer) {
        context.delete(item)
        
        do {
            try context.save()
            getRightAnswerItems()
        } catch {
            
            print("DEBUG: Could not delete item... \(error.localizedDescription)")
        }
    }
    
    func deleteAllRightAnswers() {
        group?.rightAnswers?.forEach { (rightAnswer) in
            deleteRightAnswerItem(item: rightAnswer)
        }
    }
    
    func getWrongAnswerItems() {
        do {
            wrongAnswers = try context.fetch(WrongAnswer.fetchRequest())

        } catch {

            print("DEBUG: Could not save context... \(error.localizedDescription)")
        }
    }
    
    func createWrongAnswerItem(term: String, definition: String) {
        let newItem = WrongAnswer(context: context)
        newItem.term = term
        newItem.definition = definition
        do {
            try context.save()
            getWrongAnswerItems()
        } catch {

            print("DEBUG: Could not create item... \(error.localizedDescription)")
        }
    }
    
    func deleteAllWrongAnswers() {
        group?.wrongAnswers?.forEach { (wrongAnswer) in
            deleteWrongAnswerItem(item: wrongAnswer)
        }
    }
    
    func deleteWrongAnswerItem(item: WrongAnswer) {
        context.delete(item)

        do {
            try context.save()
            getWrongAnswerItems()
        } catch {

            print("DEBUG: Could not delete item... \(error.localizedDescription)")
        }
    }
    
    func getLastScore() {
        do {
            lastScores = try context.fetch(LastScore.fetchRequest())

        } catch {

            print("DEBUG: Could not save context... \(error.localizedDescription)")
        }
    }
    
    func deleteLastScore(item: LastScore) {
        context.delete(item)

        do {
            try context.save()
            getLastScore()
        } catch {

            print("DEBUG: Could not delete item... \(error.localizedDescription)")
        }
    }
    
    func deleteAllLastScoreItems() {
        group?.lastScore?.forEach { (lastScore) in
            deleteLastScore(item: lastScore)
        }
    }
    
    func getLastRightAnswers() {
        do {
            lastRightAnswers = try context.fetch(LastRightAnswer.fetchRequest())

        } catch {

            print("DEBUG: Could not save context... \(error.localizedDescription)")
        }
    }
    
    func deleteLastRightAnswers(item: LastRightAnswer) {
        context.delete(item)

        do {
            try context.save()
            getLastRightAnswers()
        } catch {

            print("DEBUG: Could not delete item... \(error.localizedDescription)")
        }
    }
    
    func deleteAllLastRightAnswersItems() {
        group?.lastRightAnswer?.forEach { (lastRightAnswer) in
            deleteLastRightAnswers(item: lastRightAnswer)
    }
}
       
    //MARK: - Actions
    
    @objc func handleDismissButotn() {
        checkIfArrayOfFlashCardsIsEmpty()
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleCancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureAnimations()
        fetchFlashCards()
        deleteAllLastScoreItems()
        deleteAllLastRightAnswersItems()
        deleteAllRightAnswers()
        deleteAllWrongAnswers()
        checkIfArrayOfFlashCardsIsEmpty()
        counter2 = cardViews.count
    }
    
    convenience init(flashCards: [FlashCardItem], correctAnswers: [CorrectAnswer], wrongAnswers: [WrongAnswer]) {
        self.init()
        self.flashCards = flashCards
        self.correctAnswers = correctAnswers
        self.wrongAnswers = wrongAnswers
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        setProgressBar()
        setupShadows()
        
        view.addSubview(deckView)
        
        view.addSubview(remainedFlashCardsView)
        numberOfFlashCardsLabel.text? = "Pozostało fiszek: \(flashCards.count)"
        remainedFlashCardsView.centerX(inView: view)
        remainedFlashCardsView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                       paddingTop: 30,
                                       width: 250, height: 50)
        
        view.addSubview(progressBar)
        progressBar.anchor(top: remainedFlashCardsView.bottomAnchor,
                           left: deckView.leftAnchor,
                           right: deckView.rightAnchor,
                           paddingTop: 15,
                           height: 5)
        
        
        remainedFlashCardsView.addSubview(numberOfFlashCardsLabel)
        numberOfFlashCardsLabel.centerX(inView: remainedFlashCardsView)
        numberOfFlashCardsLabel.centerY(inView: remainedFlashCardsView)
        
        deckView.setDimensions(height: 200, width: 300)
        deckView.centerX(inView: view)
        deckView.centerY(inView: view)
        
        let correctAnswerStack = UIStackView(arrangedSubviews: [correctAnswerLabel, numberOfCorrectAnswersLabel])
        correctAnswerStack.axis = .horizontal
        correctAnswerStack.distribution = .fillProportionally
        
        let wrongAnswerStack = UIStackView(arrangedSubviews: [wrongAnswerLabel, numberOfWrongAnswersLabel])
        wrongAnswerStack.axis = .horizontal
        wrongAnswerStack.distribution = .fillProportionally
        
        let stack = UIStackView(arrangedSubviews: [correctAnswerStack, wrongAnswerStack])

        stack.axis = .vertical
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.centerX(inView: deckView)
        stack.anchor(top: deckView.bottomAnchor,
                     paddingTop: 30,
                     width: 200, height: 150)
    }
    
    func checkIfArrayOfFlashCardsIsEmpty() {
        swipeViewModel.cardViewsArray = cardViews.count
        updateForm()
    }
    
    func setProgressBar() {
        let progress = counter / Float(flashCards.count)
        
        progressBar.setProgress(progress, animated: true)
    }
    
    func configureAnimations() {
        viewModel.addSwipeRightAnimation(view: rightView)
        viewModel.addSwipeLeftAnimation(view: leftView)
        viewModel.showSwipeTips(leftView: leftView,
                                rightView: rightView,
                                yesCheckMark: yesCheckMarkView,
                                noCheckMark: noCheckMarkView)
    }
    
    func performSwipeAnimation(shouldAnswerCorrectly: Bool) {
//        let translation: CGFloat = shouldAnswerCorrectly ? 700 : -700
//        let degrees: CGFloat = translation / 20
//        let angle = degrees * .pi / 180
//
//        guard let topCardWidth = self.topCardView?.frame.width else { return }
//        guard let topCardHeight = self.topCardView?.frame.height else { return }
//
//        UIView.animate(withDuration: 1.3, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut) {
//            self.topCardView?.frame = CGRect(x: translation, y: 0, width: topCardWidth, height: topCardHeight)
//            self.topCardView?.transform = CGAffineTransform(rotationAngle: angle)
//        } completion: { _ in
//
//
//        }
        
        self.topCardView?.removeFromSuperview()
        guard !self.cardViews.isEmpty else { return }
        self.cardViews.remove(at: self.cardViews.count - 1)
        self.topCardView = self.cardViews.last
    }
    
    func fetchFlashCards() {
        
        flashCards.reverse()
        
        
        Service.fetchFlashCards(array: flashCards, deckView: deckView) { (cardViews, cardView) in

            cardView.delegate = self

            self.cardViews = cardViews

            topCardView = cardViews.last!
        }
    }
    
    func setupShadows() {
        setupCardShadow(card: deckView)
    }

    func saveInformationAboutSwipe(for term: String, definition: String, didAnswerCorrectly: Bool) {
        
        group?.flashCards?[Int(self.counter)].hasBeenUsed = true
        guard let lastScore = LastScore(term: term, definition: definition) else { return }
        
        group?.addToRawLastScore(lastScore)
        

        if didAnswerCorrectly {
            
            if let answer = Answer(term: term, definition: definition) {
                guard let correctAnswer = CorrectAnswer(term: term, definition: definition) else { return }
                guard let lastRightAnswer = LastRightAnswer(term: term, definition: definition) else { return }
                group?.addToRawLastRightAnswers(lastRightAnswer)
                group?.addToRawAnswers(answer)
                group?.addToRawCorectAnswers(correctAnswer)
                group?.flashCards?[Int(self.counter)].didAnswerCorrectly = true
                group?.answers?[Int(self.counter)].didAnswerCorrectly = true
                
                do {
                    try answer.managedObjectContext?.save()
                    
                } catch {
                    print("DEBUG: Could not save right answer... \(error.localizedDescription)")
                }
            }
        } else {
            guard let wrongAnswer = WrongAnswer(term: term, definition: definition) else { return }
            if let answer = Answer(term: term, definition: definition) {
                
                group?.addToRawAnswers(answer)
                group?.addToRawWrongAnswers(wrongAnswer)
                group?.flashCards?[Int(self.counter)].didAnswerCorrectly = false
                group?.answers?[Int(self.counter)].didAnswerCorrectly = false
                
                
                do {
                    try answer.managedObjectContext?.save()
                    
                } catch {
                    print("DEBUG: Could not save wrong answer... \(error.localizedDescription)")
                }
            }
        }
    }
}

extension SwipeFlashCardsController: CardViewDelegate {
    func cardView(_ view: CardView, didAnswerCorrectly: Bool) {
        self.topCardView = self.cardViews.last
        self.cardViews.removeAll(where: { view == $0 })
        guard let term = topCardView?.termDetails.text else { return }
        guard let definition = topCardView?.definitionDetails.text else { return }
        saveInformationAboutSwipe(for: term, definition: definition, didAnswerCorrectly: didAnswerCorrectly)
        
        guard let rightAnswersCount = group?.rightAnswers?.count else { return }
        
        guard let wrongAnswersCount = group?.wrongAnswers?.count else { return }
        
        DispatchQueue.main.async {
            //self.performSwipeAnimation(shouldAnswerCorrectly: didAnswerCorrectly)
            self.counter += 1
            self.checkIfArrayOfFlashCardsIsEmpty()
            self.setProgressBar()
            self.numberOfFlashCardsLabel.text? = "Pozostało fiszek: \(self.cardViews.count)"
            self.numberOfCorrectAnswersLabel.text = "\(rightAnswersCount)"
            self.numberOfWrongAnswersLabel.text = "\(wrongAnswersCount)"
           
        }
    }
}

extension SwipeFlashCardsController: FormViewModel {
    func updateForm() {
        dismissButton.isEnabled = swipeViewModel.shouldEnableButton
        dismissButton.setTitleColor(swipeViewModel.buttonTitleColor, for: .normal)
        dismissButton.backgroundColor = swipeViewModel.buttonBackgroundColor
            
        if cardViews.count == 0 {
            delegate?.fetchDataAboutSwipes()
            let controller = SummaryController()
            controller.group = group
            controller.flashCards = flashCards
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: true, completion: nil)
        }
    }
}
