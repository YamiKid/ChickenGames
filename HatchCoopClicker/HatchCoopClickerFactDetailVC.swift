import UIKit

class HatchCoopClickerFactDetailVC: UIViewController {
    
    var HatchCoopClickerFact: HatchCoopClickerHatcheryVC.HatchCoopClickerChickenFact!
    
    private lazy var HatchCoopClickerScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor(red: 1.0, green: 0.95, blue: 0.88, alpha: 1.0)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var HatchCoopClickerContentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1.0, green: 0.95, blue: 0.88, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var HatchCoopClickerEmojiLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 80)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerDescriptionCard: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1.0, green: 0.98, blue: 0.95, alpha: 1.0)
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 12
        view.layer.shadowOffset = CGSize(width: 0, height: 6)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var HatchCoopClickerDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerBackButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("← Back to Facts", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 8
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.addTarget(self, action: #selector(HatchCoopClickerBackTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HatchCoopClickerSetupUI()
        HatchCoopClickerUpdateContent()
    }
    
    private func HatchCoopClickerSetupUI() {
        view.backgroundColor = UIColor(red: 1.0, green: 0.95, blue: 0.88, alpha: 1.0)
        title = "🐔 Chicken Fact"
        
        view.addSubview(HatchCoopClickerScrollView)
        HatchCoopClickerScrollView.addSubview(HatchCoopClickerContentView)
        
        HatchCoopClickerContentView.addSubview(HatchCoopClickerEmojiLabel)
        HatchCoopClickerContentView.addSubview(HatchCoopClickerTitleLabel)
        HatchCoopClickerContentView.addSubview(HatchCoopClickerDescriptionCard)
        HatchCoopClickerContentView.addSubview(HatchCoopClickerBackButton)
        
        HatchCoopClickerDescriptionCard.addSubview(HatchCoopClickerDescriptionLabel)
        
        NSLayoutConstraint.activate([
            HatchCoopClickerScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            HatchCoopClickerScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            HatchCoopClickerScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            HatchCoopClickerScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            HatchCoopClickerContentView.topAnchor.constraint(equalTo: HatchCoopClickerScrollView.topAnchor),
            HatchCoopClickerContentView.leadingAnchor.constraint(equalTo: HatchCoopClickerScrollView.leadingAnchor),
            HatchCoopClickerContentView.trailingAnchor.constraint(equalTo: HatchCoopClickerScrollView.trailingAnchor),
            HatchCoopClickerContentView.bottomAnchor.constraint(equalTo: HatchCoopClickerScrollView.bottomAnchor),
            HatchCoopClickerContentView.widthAnchor.constraint(equalTo: HatchCoopClickerScrollView.widthAnchor),
            
            HatchCoopClickerEmojiLabel.topAnchor.constraint(equalTo: HatchCoopClickerContentView.topAnchor, constant: 30),
            HatchCoopClickerEmojiLabel.centerXAnchor.constraint(equalTo: HatchCoopClickerContentView.centerXAnchor),
            
            HatchCoopClickerTitleLabel.topAnchor.constraint(equalTo: HatchCoopClickerEmojiLabel.bottomAnchor, constant: 20),
            HatchCoopClickerTitleLabel.leadingAnchor.constraint(equalTo: HatchCoopClickerContentView.leadingAnchor, constant: 20),
            HatchCoopClickerTitleLabel.trailingAnchor.constraint(equalTo: HatchCoopClickerContentView.trailingAnchor, constant: -20),
            
            HatchCoopClickerDescriptionCard.topAnchor.constraint(equalTo: HatchCoopClickerTitleLabel.bottomAnchor, constant: 30),
            HatchCoopClickerDescriptionCard.leadingAnchor.constraint(equalTo: HatchCoopClickerContentView.leadingAnchor, constant: 20),
            HatchCoopClickerDescriptionCard.trailingAnchor.constraint(equalTo: HatchCoopClickerContentView.trailingAnchor, constant: -20),
            
            HatchCoopClickerDescriptionLabel.topAnchor.constraint(equalTo: HatchCoopClickerDescriptionCard.topAnchor, constant: 25),
            HatchCoopClickerDescriptionLabel.leadingAnchor.constraint(equalTo: HatchCoopClickerDescriptionCard.leadingAnchor, constant: 20),
            HatchCoopClickerDescriptionLabel.trailingAnchor.constraint(equalTo: HatchCoopClickerDescriptionCard.trailingAnchor, constant: -20),
            HatchCoopClickerDescriptionLabel.bottomAnchor.constraint(equalTo: HatchCoopClickerDescriptionCard.bottomAnchor, constant: -25),
            
            HatchCoopClickerBackButton.topAnchor.constraint(equalTo: HatchCoopClickerDescriptionCard.bottomAnchor, constant: 40),
            HatchCoopClickerBackButton.leadingAnchor.constraint(equalTo: HatchCoopClickerContentView.leadingAnchor, constant: 40),
            HatchCoopClickerBackButton.trailingAnchor.constraint(equalTo: HatchCoopClickerContentView.trailingAnchor, constant: -40),
            HatchCoopClickerBackButton.heightAnchor.constraint(equalToConstant: 50),
            HatchCoopClickerBackButton.bottomAnchor.constraint(equalTo: HatchCoopClickerContentView.bottomAnchor, constant: -30)
        ])
    }
    
    private func HatchCoopClickerUpdateContent() {
        guard let fact = HatchCoopClickerFact else { return }
        
        HatchCoopClickerEmojiLabel.text = fact.emoji
        HatchCoopClickerTitleLabel.text = fact.title
        HatchCoopClickerDescriptionLabel.text = fact.fullDescription
    }
    
    @objc private func HatchCoopClickerBackTapped() {
        navigationController?.popViewController(animated: true)
    }
} 