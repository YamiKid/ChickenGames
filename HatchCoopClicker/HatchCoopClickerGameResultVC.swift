import UIKit

class HatchCoopClickerGameResultVC: UIViewController {
    
    var HatchCoopClickerIsWin: Bool = false
    var HatchCoopClickerCoinsEarned: Int = 0
    var HatchCoopClickerXPEarned: Int = 0
    var HatchCoopClickerGameName: String = ""
    var HatchCoopClickerOnContinue: (() -> Void)?
    
    private lazy var HatchCoopClickerBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var HatchCoopClickerCardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1.0, green: 0.98, blue: 0.95, alpha: 1.0)
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 15
        view.layer.shadowOffset = CGSize(width: 0, height: 8)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var HatchCoopClickerResultEmojiLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 60)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerResultTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerGameNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerRewardsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var HatchCoopClickerCoinsRewardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1.0, green: 0.95, blue: 0.88, alpha: 1.0)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var HatchCoopClickerCoinsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(red: 1.0, green: 0.84, blue: 0.31, alpha: 1.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerXPRewardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1.0, green: 0.95, blue: 0.88, alpha: 1.0)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var HatchCoopClickerXPLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 1.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerContinueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(HatchCoopClickerContinueTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HatchCoopClickerSetupUI()
        HatchCoopClickerConfigureResult()
    }
    
    private func HatchCoopClickerSetupUI() {
        view.backgroundColor = .clear
        
        view.addSubview(HatchCoopClickerBackgroundView)
        view.addSubview(HatchCoopClickerCardView)
        
        HatchCoopClickerCardView.addSubview(HatchCoopClickerResultEmojiLabel)
        HatchCoopClickerCardView.addSubview(HatchCoopClickerResultTitleLabel)
        HatchCoopClickerCardView.addSubview(HatchCoopClickerGameNameLabel)
        HatchCoopClickerCardView.addSubview(HatchCoopClickerRewardsStackView)
        HatchCoopClickerCardView.addSubview(HatchCoopClickerContinueButton)
        
        HatchCoopClickerRewardsStackView.addArrangedSubview(HatchCoopClickerCoinsRewardView)
        HatchCoopClickerRewardsStackView.addArrangedSubview(HatchCoopClickerXPRewardView)
        
        HatchCoopClickerCoinsRewardView.addSubview(HatchCoopClickerCoinsLabel)
        HatchCoopClickerXPRewardView.addSubview(HatchCoopClickerXPLabel)
        
        NSLayoutConstraint.activate([
            HatchCoopClickerBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            HatchCoopClickerBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            HatchCoopClickerBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            HatchCoopClickerBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            HatchCoopClickerCardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            HatchCoopClickerCardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            HatchCoopClickerCardView.widthAnchor.constraint(equalToConstant: 300),
            HatchCoopClickerCardView.heightAnchor.constraint(equalToConstant: 400),
            
            HatchCoopClickerResultEmojiLabel.topAnchor.constraint(equalTo: HatchCoopClickerCardView.topAnchor, constant: 30),
            HatchCoopClickerResultEmojiLabel.centerXAnchor.constraint(equalTo: HatchCoopClickerCardView.centerXAnchor),
            
            HatchCoopClickerResultTitleLabel.topAnchor.constraint(equalTo: HatchCoopClickerResultEmojiLabel.bottomAnchor, constant: 20),
            HatchCoopClickerResultTitleLabel.leadingAnchor.constraint(equalTo: HatchCoopClickerCardView.leadingAnchor, constant: 20),
            HatchCoopClickerResultTitleLabel.trailingAnchor.constraint(equalTo: HatchCoopClickerCardView.trailingAnchor, constant: -20),
            
            HatchCoopClickerGameNameLabel.topAnchor.constraint(equalTo: HatchCoopClickerResultTitleLabel.bottomAnchor, constant: 10),
            HatchCoopClickerGameNameLabel.leadingAnchor.constraint(equalTo: HatchCoopClickerCardView.leadingAnchor, constant: 20),
            HatchCoopClickerGameNameLabel.trailingAnchor.constraint(equalTo: HatchCoopClickerCardView.trailingAnchor, constant: -20),
            
            HatchCoopClickerRewardsStackView.topAnchor.constraint(equalTo: HatchCoopClickerGameNameLabel.bottomAnchor, constant: 30),
            HatchCoopClickerRewardsStackView.leadingAnchor.constraint(equalTo: HatchCoopClickerCardView.leadingAnchor, constant: 20),
            HatchCoopClickerRewardsStackView.trailingAnchor.constraint(equalTo: HatchCoopClickerCardView.trailingAnchor, constant: -20),
            
            HatchCoopClickerCoinsRewardView.heightAnchor.constraint(equalToConstant: 40),
            HatchCoopClickerCoinsRewardView.widthAnchor.constraint(equalTo: HatchCoopClickerRewardsStackView.widthAnchor),
            
            HatchCoopClickerXPRewardView.heightAnchor.constraint(equalToConstant: 40),
            HatchCoopClickerXPRewardView.widthAnchor.constraint(equalTo: HatchCoopClickerRewardsStackView.widthAnchor),
            
            HatchCoopClickerCoinsLabel.centerXAnchor.constraint(equalTo: HatchCoopClickerCoinsRewardView.centerXAnchor),
            HatchCoopClickerCoinsLabel.centerYAnchor.constraint(equalTo: HatchCoopClickerCoinsRewardView.centerYAnchor),
            
            HatchCoopClickerXPLabel.centerXAnchor.constraint(equalTo: HatchCoopClickerXPRewardView.centerXAnchor),
            HatchCoopClickerXPLabel.centerYAnchor.constraint(equalTo: HatchCoopClickerXPRewardView.centerYAnchor),
            
            HatchCoopClickerContinueButton.topAnchor.constraint(equalTo: HatchCoopClickerRewardsStackView.bottomAnchor, constant: 30),
            HatchCoopClickerContinueButton.leadingAnchor.constraint(equalTo: HatchCoopClickerCardView.leadingAnchor, constant: 20),
            HatchCoopClickerContinueButton.trailingAnchor.constraint(equalTo: HatchCoopClickerCardView.trailingAnchor, constant: -20),
            HatchCoopClickerContinueButton.heightAnchor.constraint(equalToConstant: 50),
            HatchCoopClickerContinueButton.bottomAnchor.constraint(lessThanOrEqualTo: HatchCoopClickerCardView.bottomAnchor, constant: -30)
        ])
    }
    
    private func HatchCoopClickerConfigureResult() {
        if HatchCoopClickerIsWin {
            HatchCoopClickerResultEmojiLabel.text = "🎉"
            HatchCoopClickerResultTitleLabel.text = "Victory!"
            HatchCoopClickerResultTitleLabel.textColor = UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 1.0)
        } else {
            HatchCoopClickerResultEmojiLabel.text = "😔"
            HatchCoopClickerResultTitleLabel.text = "Game Over"
            HatchCoopClickerResultTitleLabel.textColor = UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0)
        }
        
        HatchCoopClickerGameNameLabel.text = HatchCoopClickerGameName
        HatchCoopClickerCoinsLabel.text = "💰 +\(HatchCoopClickerCoinsEarned) RanchCoins"
        HatchCoopClickerXPLabel.text = "⭐ +\(HatchCoopClickerXPEarned) XP"
    }
    
    @objc private func HatchCoopClickerContinueTapped() {
        dismiss(animated: true) {
            self.HatchCoopClickerOnContinue?()
        }
    }
} 