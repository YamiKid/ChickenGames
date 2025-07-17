import UIKit

class HatchCoopClickerPurchaseAlertVC: UIViewController {
    
    var HatchCoopClickerIsSuccess: Bool = false
    var HatchCoopClickerMessage: String = ""
    
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
    
    private lazy var HatchCoopClickerIconLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 60)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerMessageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerContinueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
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
        HatchCoopClickerUpdateContent()
        HatchCoopClickerAnimateIn()
    }
    
    private func HatchCoopClickerSetupUI() {
        view.backgroundColor = .clear
        
        view.addSubview(HatchCoopClickerBackgroundView)
        view.addSubview(HatchCoopClickerMainCard)
        
        HatchCoopClickerMainCard.addSubview(HatchCoopClickerIconLabel)
        HatchCoopClickerMainCard.addSubview(HatchCoopClickerTitleLabel)
        HatchCoopClickerMainCard.addSubview(HatchCoopClickerMessageLabel)
        HatchCoopClickerMainCard.addSubview(HatchCoopClickerContinueButton)
        
        NSLayoutConstraint.activate([
            HatchCoopClickerBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            HatchCoopClickerBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            HatchCoopClickerBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            HatchCoopClickerBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            HatchCoopClickerMainCard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            HatchCoopClickerMainCard.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            HatchCoopClickerMainCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            HatchCoopClickerMainCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            HatchCoopClickerIconLabel.topAnchor.constraint(equalTo: HatchCoopClickerMainCard.topAnchor, constant: 30),
            HatchCoopClickerIconLabel.centerXAnchor.constraint(equalTo: HatchCoopClickerMainCard.centerXAnchor),
            
            HatchCoopClickerTitleLabel.topAnchor.constraint(equalTo: HatchCoopClickerIconLabel.bottomAnchor, constant: 20),
            HatchCoopClickerTitleLabel.leadingAnchor.constraint(equalTo: HatchCoopClickerMainCard.leadingAnchor, constant: 20),
            HatchCoopClickerTitleLabel.trailingAnchor.constraint(equalTo: HatchCoopClickerMainCard.trailingAnchor, constant: -20),
            
            HatchCoopClickerMessageLabel.topAnchor.constraint(equalTo: HatchCoopClickerTitleLabel.bottomAnchor, constant: 15),
            HatchCoopClickerMessageLabel.leadingAnchor.constraint(equalTo: HatchCoopClickerMainCard.leadingAnchor, constant: 20),
            HatchCoopClickerMessageLabel.trailingAnchor.constraint(equalTo: HatchCoopClickerMainCard.trailingAnchor, constant: -20),
            
            HatchCoopClickerContinueButton.topAnchor.constraint(equalTo: HatchCoopClickerMessageLabel.bottomAnchor, constant: 25),
            HatchCoopClickerContinueButton.leadingAnchor.constraint(equalTo: HatchCoopClickerMainCard.leadingAnchor, constant: 40),
            HatchCoopClickerContinueButton.trailingAnchor.constraint(equalTo: HatchCoopClickerMainCard.trailingAnchor, constant: -40),
            HatchCoopClickerContinueButton.heightAnchor.constraint(equalToConstant: 50),
            HatchCoopClickerContinueButton.bottomAnchor.constraint(equalTo: HatchCoopClickerMainCard.bottomAnchor, constant: -30)
        ])
    }
    
    private func HatchCoopClickerUpdateContent() {
        if HatchCoopClickerIsSuccess {
            HatchCoopClickerIconLabel.text = "🐔"
            HatchCoopClickerTitleLabel.text = "Success!"
            HatchCoopClickerTitleLabel.textColor = UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 1.0)
            HatchCoopClickerContinueButton.backgroundColor = UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 1.0)
        } else {
            HatchCoopClickerIconLabel.text = "💰"
            HatchCoopClickerTitleLabel.text = "Insufficient Funds"
            HatchCoopClickerTitleLabel.textColor = UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0)
            HatchCoopClickerContinueButton.backgroundColor = UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0)
        }
        
        HatchCoopClickerMessageLabel.text = HatchCoopClickerMessage
    }
    
    private func HatchCoopClickerAnimateIn() {
        // Initial state
        HatchCoopClickerMainCard.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        HatchCoopClickerMainCard.alpha = 0
        HatchCoopClickerBackgroundView.alpha = 0
        
        // Animate background
        UIView.animate(withDuration: 0.3, animations: {
            self.HatchCoopClickerBackgroundView.alpha = 1
        })
        
        // Animate card
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: [], animations: {
            self.HatchCoopClickerMainCard.transform = .identity
            self.HatchCoopClickerMainCard.alpha = 1
        })
        
        // Animate icon
        HatchCoopClickerIconLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.6, delay: 0.3, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
            self.HatchCoopClickerIconLabel.transform = .identity
        })
    }
    
    @objc private func HatchCoopClickerContinueTapped() {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 0
        }) { _ in
            self.dismiss(animated: false)
        }
    }
} 