//
//  SummaryController.swift
//  FiszkiApp
//
//  Created by Leopold on 30/01/2021.
//

import UIKit



class SummaryController: UIViewController {
    
    //MARK: - Properties
    
    var group: GroupItem?
    
    var flashCards = [FlashCardItem]()
    
    private let circleProgressBar = CAShapeLayer()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private let tableView = UITableView()
    
    private let mainTitle: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = .boldSystemFont(ofSize: 24)
        lbl.numberOfLines = 0
        lbl.text = "Gratulacje!"
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let wrongAnswersLabel: UILabel = {
        let label = UILabel()
        label.text = "Fiszki wymagające powtórki"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private let effectivenessLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 18)
        lbl.textColor = .gray
        lbl.text = "Twoja skuteczność wynosi"
        return lbl
    }()
    
    private let progressBar: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.trackTintColor = #colorLiteral(red: 0.05098039216, green: 0.4392156863, blue: 0.9960784314, alpha: 1).withAlphaComponent(0.5)
        progressView.progressTintColor = #colorLiteral(red: 0.05098039216, green: 0.4392156863, blue: 0.9960784314, alpha: 1)
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 5
        
        
        
        return progressView
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
    
    //MARK: - Actions
    
    @objc func handleDismissButotn() {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleTap() {
        print("DEBUG: Attempting to animate stroke")
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 1
        
        basicAnimation.duration = 1.5
        
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        circleProgressBar.add(basicAnimation, forKey: "urSoBasic")
    }
    
    //MARK: - Core Data
    
    func deleteRightAnswerItem(item: CorrectAnswer) {
        context.delete(item)
        
        do {
            try context.save()
        } catch {
            
            print("DEBUG: Could not delete item... \(error.localizedDescription)")
        }
    }
    
    func deleteAllRightAnswers() {
        group?.rightAnswers?.forEach { (rightAnswer) in
            deleteRightAnswerItem(item: rightAnswer)
        }
    }
    
    func deleteWrongAnswerItem(item: WrongAnswer) {
        context.delete(item)
        
        do {
            try context.save()
        } catch {
            
            print("DEBUG: Could not delete item... \(error.localizedDescription)")
        }
    }
    
    
    
    func deleteAllWrongAnswers() {
        group?.wrongAnswers?.forEach { (wrongAnswer) in
            deleteWrongAnswerItem(item: wrongAnswer)
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationBar()
        configureTableView()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        configureMainLabelText()
        configureProgressBarColor()
        //configureCircleBar()
        
        effectivenessLabel.text?.append(" \(calculateEffectiveness())%")
        
        
        view.addSubview(mainTitle)
        mainTitle.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 30, paddingRight: 30)
        
        view.addSubview(effectivenessLabel)
        effectivenessLabel.centerX(inView: view)
        effectivenessLabel.anchor(top: mainTitle.bottomAnchor, paddingTop: 30)
        
        view.addSubview(progressBar)
        //progressBar.centerX(inView: effectivenessLabel)
        progressBar.anchor(top: effectivenessLabel.bottomAnchor, left: effectivenessLabel.leftAnchor, right: effectivenessLabel.rightAnchor, paddingTop: 30,  height: 15)
        
        view.addSubview(wrongAnswersLabel)
        wrongAnswersLabel.centerX(inView: view)
        wrongAnswersLabel.anchor(top: progressBar.bottomAnchor, paddingTop: 30)
        
        
        
        view.addSubview(tableView)
        tableView.anchor(top: wrongAnswersLabel.bottomAnchor,
                         left: view.leftAnchor,
                         bottom: view.bottomAnchor,
                         right: view.rightAnchor,
                         paddingTop: 20)
        
        view.addSubview(dismissButton)
        dismissButton.centerX(inView: view)
        dismissButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 30)
        setupButtonShadow(button: dismissButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.setProgressBar()
        })
    }
    
    func configureMainLabelText() {
        switch calculateEffectiveness() {
        case 0...50: return mainTitle.text = "Musisz jeszcze popracować :("
        case 51...70: return mainTitle.text = "Nie tak źle! Jeszcze kilka razy i będzie 100% :D"
        case 71...90: return mainTitle.text = "Coraz bliżej do celu! Spróbuj jeszcze raz :D"
        case 91...99.99: return mainTitle.text = "Już prawie!!! Spróbuj jeszcze raz i zamknij naukę!"
        default: break
        }
    }
    
    func configureProgressBarColor() {
        switch calculateEffectiveness() {
        case 0...39: return darkRedProgressBar()
        case 40...59: return lightRedProgressBar()
        case 60...90: return lightBlueProgressBar()
        case 91...99.99: return blueProgressBar()
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
    
    
    
    func configureTableView() {
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(FlashCardCell.self, forCellReuseIdentifier: "FlashCardCell")
        tableView.reloadData()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 220
        tableView.backgroundColor = .white
    }
    
    func setProgressBar() {
        guard let rightAnswersCount = group?.rightAnswers?.count else { return }
        
        let progress = Float(rightAnswersCount) / Float(self.flashCards.count)
        
        progressBar.setProgress(progress, animated: true)
    }
    
    func configureCircleBar() {
        
        let center = view.center
        
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        circleProgressBar.path = circularPath.cgPath
        
        let test = (-CGFloat.pi / 2) / -(2 * CGFloat.pi)
        print(test)
        
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        
        trackLayer.strokeColor = UIColor.systemPink.withAlphaComponent(0.5).cgColor
        trackLayer.lineWidth = 15
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = .round
        view.layer.addSublayer(trackLayer)
        
        circleProgressBar.strokeColor = UIColor.systemPink.cgColor
        circleProgressBar.strokeEnd = 0
        circleProgressBar.lineWidth = 15
        circleProgressBar.lineCap = .round
        circleProgressBar.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(circleProgressBar)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func calculateEffectiveness() -> Float {
        guard let rightAnswersCount = group?.rightAnswers?.count else { return 0.0 }
        
        let effectiveness = Float(rightAnswersCount) / Float(flashCards.count)
        
        let decimalPlaces = 2.0
        
        let multiplier = pow(10, decimalPlaces)
        
        let result = round(Double(effectiveness * 100) * multiplier) / multiplier
        
        return Float(result)
    }
}

extension SummaryController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return group?.wrongAnswers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlashCardCell", for: indexPath) as! FlashCardCell
        let term = group?.wrongAnswers?[indexPath.row].term
        let definition = group?.wrongAnswers?[indexPath.row].definition
        cell.termDetails.text = term
        cell.definitionDetails.text = definition
        cell.yesCheckmarkImage.isHidden = true
        cell.isUserInteractionEnabled = false
        return cell
    }
}
