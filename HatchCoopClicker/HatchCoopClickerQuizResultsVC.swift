import UIKit

class HatchCoopClickerQuizResultsVC: UIViewController {
    
    var HatchCoopClickerCorrectAnswers: Int = 0
    var HatchCoopClickerTotalQuestions: Int = 0
    var HatchCoopClickerOnContinue: (() -> Void)?
    
    private lazy var HatchCoopClickerBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var HatchCoopClickerMainCard: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1.0, green: 0.98, blue: 0.95, alpha: 1.0)
        view.layer.cornerRadius = 25
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 20
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var HatchCoopClickerTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0)
        label.textAlignment = .center
        label.text = "🎉 Quiz Complete!"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerScoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.textColor = UIColor(red: 0.2, green: 0.6, blue: 0.9, alpha: 1.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerResultsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var HatchCoopClickerCorrectCard: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 0.1)
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 1.0).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var HatchCoopClickerIncorrectCard: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 0.1)
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var HatchCoopClickerCorrectLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = UIColor(red: 0.2, green: 0.6, blue: 0.2, alpha: 1.0)
        label.textAlignment = .center
        label.text = "✅ Correct: 0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerIncorrectLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = UIColor(red: 0.8, green: 0.3, blue: 0.3, alpha: 1.0)
        label.textAlignment = .center
        label.text = "❌ Incorrect: 0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerRewardsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerContinueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.backgroundColor = UIColor(red: 0.2, green: 0.6, blue: 0.9, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 8
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.addTarget(self, action: #selector(HatchCoopClickerContinueTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HatchCoopClickerSetupUI()
        HatchCoopClickerUpdateResults()
        HatchCoopClickerAnimateResults()
    }
    
    private func HatchCoopClickerSetupUI() {
        view.backgroundColor = .clear
        
        view.addSubview(HatchCoopClickerBackgroundView)
        view.addSubview(HatchCoopClickerMainCard)
        
        HatchCoopClickerMainCard.addSubview(HatchCoopClickerTitleLabel)
        HatchCoopClickerMainCard.addSubview(HatchCoopClickerScoreLabel)
        HatchCoopClickerMainCard.addSubview(HatchCoopClickerResultsStackView)
        HatchCoopClickerMainCard.addSubview(HatchCoopClickerRewardsLabel)
        HatchCoopClickerMainCard.addSubview(HatchCoopClickerContinueButton)
        
        HatchCoopClickerResultsStackView.addArrangedSubview(HatchCoopClickerCorrectCard)
        HatchCoopClickerResultsStackView.addArrangedSubview(HatchCoopClickerIncorrectCard)
        
        HatchCoopClickerCorrectCard.addSubview(HatchCoopClickerCorrectLabel)
        HatchCoopClickerIncorrectCard.addSubview(HatchCoopClickerIncorrectLabel)
        
        NSLayoutConstraint.activate([
            HatchCoopClickerBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            HatchCoopClickerBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            HatchCoopClickerBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            HatchCoopClickerBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            HatchCoopClickerMainCard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            HatchCoopClickerMainCard.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            HatchCoopClickerMainCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            HatchCoopClickerMainCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            HatchCoopClickerTitleLabel.topAnchor.constraint(equalTo: HatchCoopClickerMainCard.topAnchor, constant: 30),
            HatchCoopClickerTitleLabel.leadingAnchor.constraint(equalTo: HatchCoopClickerMainCard.leadingAnchor, constant: 20),
            HatchCoopClickerTitleLabel.trailingAnchor.constraint(equalTo: HatchCoopClickerMainCard.trailingAnchor, constant: -20),
            
            HatchCoopClickerScoreLabel.topAnchor.constraint(equalTo: HatchCoopClickerTitleLabel.bottomAnchor, constant: 20),
            HatchCoopClickerScoreLabel.leadingAnchor.constraint(equalTo: HatchCoopClickerMainCard.leadingAnchor, constant: 20),
            HatchCoopClickerScoreLabel.trailingAnchor.constraint(equalTo: HatchCoopClickerMainCard.trailingAnchor, constant: -20),
            
            HatchCoopClickerResultsStackView.topAnchor.constraint(equalTo: HatchCoopClickerScoreLabel.bottomAnchor, constant: 30),
            HatchCoopClickerResultsStackView.leadingAnchor.constraint(equalTo: HatchCoopClickerMainCard.leadingAnchor, constant: 20),
            HatchCoopClickerResultsStackView.trailingAnchor.constraint(equalTo: HatchCoopClickerMainCard.trailingAnchor, constant: -20),
            HatchCoopClickerResultsStackView.heightAnchor.constraint(equalToConstant: 120),
            
            HatchCoopClickerCorrectLabel.centerXAnchor.constraint(equalTo: HatchCoopClickerCorrectCard.centerXAnchor),
            HatchCoopClickerCorrectLabel.centerYAnchor.constraint(equalTo: HatchCoopClickerCorrectCard.centerYAnchor),
            
            HatchCoopClickerIncorrectLabel.centerXAnchor.constraint(equalTo: HatchCoopClickerIncorrectCard.centerXAnchor),
            HatchCoopClickerIncorrectLabel.centerYAnchor.constraint(equalTo: HatchCoopClickerIncorrectCard.centerYAnchor),
            
            HatchCoopClickerRewardsLabel.topAnchor.constraint(equalTo: HatchCoopClickerResultsStackView.bottomAnchor, constant: 30),
            HatchCoopClickerRewardsLabel.leadingAnchor.constraint(equalTo: HatchCoopClickerMainCard.leadingAnchor, constant: 20),
            HatchCoopClickerRewardsLabel.trailingAnchor.constraint(equalTo: HatchCoopClickerMainCard.trailingAnchor, constant: -20),
            
            HatchCoopClickerContinueButton.topAnchor.constraint(equalTo: HatchCoopClickerRewardsLabel.bottomAnchor, constant: 30),
            HatchCoopClickerContinueButton.leadingAnchor.constraint(equalTo: HatchCoopClickerMainCard.leadingAnchor, constant: 40),
            HatchCoopClickerContinueButton.trailingAnchor.constraint(equalTo: HatchCoopClickerMainCard.trailingAnchor, constant: -40),
            HatchCoopClickerContinueButton.heightAnchor.constraint(equalToConstant: 50),
            HatchCoopClickerContinueButton.bottomAnchor.constraint(equalTo: HatchCoopClickerMainCard.bottomAnchor, constant: -30)
        ])
    }
    
    private func HatchCoopClickerUpdateResults() {
        let percentage = Int((Double(HatchCoopClickerCorrectAnswers) / Double(HatchCoopClickerTotalQuestions)) * 100)
        let incorrectAnswers = HatchCoopClickerTotalQuestions - HatchCoopClickerCorrectAnswers
        
        HatchCoopClickerScoreLabel.text = "\(HatchCoopClickerCorrectAnswers)/\(HatchCoopClickerTotalQuestions) (\(percentage)%)"
        HatchCoopClickerCorrectLabel.text = "✅ Correct: \(HatchCoopClickerCorrectAnswers)"
        HatchCoopClickerIncorrectLabel.text = "❌ Incorrect: \(incorrectAnswers)"
        
        // Calculate rewards
        let coinsEarned = HatchCoopClickerCorrectAnswers * 5
        let xpEarned = HatchCoopClickerCorrectAnswers * 10
        
        HatchCoopClickerRewardsLabel.text = "💰 Coins Earned: \(coinsEarned)\n⭐ XP Earned: \(xpEarned)"
    }
    
    private func HatchCoopClickerAnimateResults() {
        // Initial state
        HatchCoopClickerMainCard.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        HatchCoopClickerMainCard.alpha = 0
        
        // Animate in
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: [], animations: {
            self.HatchCoopClickerMainCard.transform = .identity
            self.HatchCoopClickerMainCard.alpha = 1
        })
        
        // Animate score
        HatchCoopClickerScoreLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.6, delay: 0.3, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
            self.HatchCoopClickerScoreLabel.transform = .identity
        })
        
        // Animate cards
        HatchCoopClickerCorrectCard.transform = CGAffineTransform(translationX: -50, y: 0)
        HatchCoopClickerIncorrectCard.transform = CGAffineTransform(translationX: 50, y: 0)
        
        UIView.animate(withDuration: 0.5, delay: 0.4, options: [], animations: {
            self.HatchCoopClickerCorrectCard.transform = .identity
            self.HatchCoopClickerIncorrectCard.transform = .identity
        })
    }
    
    @objc private func HatchCoopClickerContinueTapped() {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 0
        }) { _ in
            self.HatchCoopClickerOnContinue?()
            self.dismiss(animated: false)
        }
    }
} 