import UIKit
import SafariServices

class HatchCoopClickerSettingsVC: UIViewController {
    
    private let HatchCoopClickerSharedGameData = HatchCoopClickerGameData.HatchCoopClickerShared
    private var HatchCoopClickerViewModel: HatchCoopClickerSettingsViewModel!
    
    private lazy var HatchCoopClickerScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var HatchCoopClickerContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var HatchCoopClickerModeCardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1.0, green: 0.98, blue: 0.95, alpha: 1.0)
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var HatchCoopClickerModeControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["🎮 Casual", "⏰ Timed", "🔇 Silent"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = UIColor(red: 0.95, green: 0.93, blue: 0.9, alpha: 1.0)
        segmentedControl.selectedSegmentTintColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0), .font: UIFont.systemFont(ofSize: 14, weight: .medium)], for: .normal)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 14, weight: .semibold)], for: .selected)
        segmentedControl.addTarget(self, action: #selector(HatchCoopClickerModeChanged), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    private lazy var HatchCoopClickerModeLabel: UILabel = {
        let label = UILabel()
        label.text = "🎯 Game Mode"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerStatsCardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1.0, green: 0.98, blue: 0.95, alpha: 1.0)
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var HatchCoopClickerStatsLabel: UILabel = {
        let label = UILabel()
        label.text = "📊 Game Statistics"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerStatsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var HatchCoopClickerXPView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.95, green: 0.93, blue: 0.9, alpha: 1.0)
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var HatchCoopClickerXPLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerCoinsView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.95, green: 0.93, blue: 0.9, alpha: 1.0)
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var HatchCoopClickerCoinsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerChickensView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.95, green: 0.93, blue: 0.9, alpha: 1.0)
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var HatchCoopClickerChickensLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerResetCardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1.0, green: 0.98, blue: 0.95, alpha: 1.0)
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var HatchCoopClickerResetAllDataButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("🗑️ Reset All Data", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 8
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.addTarget(self, action: #selector(HatchCoopClickerResetDataTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var HatchCoopClickerLegalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 30
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var HatchCoopClickerPrivacyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("🔒 Privacy Policy", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0), for: .normal)
        button.backgroundColor = UIColor(red: 0.95, green: 0.93, blue: 0.9, alpha: 1.0)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(HatchCoopClickerPrivacyTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var HatchCoopClickerTermsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("📋 Terms of Service", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0), for: .normal)
        button.backgroundColor = UIColor(red: 0.95, green: 0.93, blue: 0.9, alpha: 1.0)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(HatchCoopClickerTermsTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HatchCoopClickerSetupUI()
        HatchCoopClickerSetupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        HatchCoopClickerViewModel.HatchCoopClickerUpdateData()
    }
    
    private func HatchCoopClickerSetupUI() {
        view.backgroundColor = UIColor(red: 1.0, green: 0.95, blue: 0.88, alpha: 1.0)
        title = "⚙️ Settings"
        
        view.addSubview(HatchCoopClickerScrollView)
        HatchCoopClickerScrollView.addSubview(HatchCoopClickerContentView)
        
        HatchCoopClickerContentView.addSubview(HatchCoopClickerModeCardView)
        HatchCoopClickerModeCardView.addSubview(HatchCoopClickerModeLabel)
        HatchCoopClickerModeCardView.addSubview(HatchCoopClickerModeControl)
        
        HatchCoopClickerContentView.addSubview(HatchCoopClickerStatsCardView)
        HatchCoopClickerStatsCardView.addSubview(HatchCoopClickerStatsLabel)
        HatchCoopClickerStatsCardView.addSubview(HatchCoopClickerStatsStackView)
        
        HatchCoopClickerStatsStackView.addArrangedSubview(HatchCoopClickerXPView)
        HatchCoopClickerXPView.addSubview(HatchCoopClickerXPLabel)
        
        HatchCoopClickerStatsStackView.addArrangedSubview(HatchCoopClickerCoinsView)
        HatchCoopClickerCoinsView.addSubview(HatchCoopClickerCoinsLabel)
        
        HatchCoopClickerStatsStackView.addArrangedSubview(HatchCoopClickerChickensView)
        HatchCoopClickerChickensView.addSubview(HatchCoopClickerChickensLabel)
        
        HatchCoopClickerContentView.addSubview(HatchCoopClickerResetCardView)
        HatchCoopClickerResetCardView.addSubview(HatchCoopClickerResetAllDataButton)
        
        HatchCoopClickerContentView.addSubview(HatchCoopClickerLegalStackView)
        HatchCoopClickerLegalStackView.addArrangedSubview(HatchCoopClickerPrivacyButton)
        HatchCoopClickerLegalStackView.addArrangedSubview(HatchCoopClickerTermsButton)
        
        NSLayoutConstraint.activate([
            HatchCoopClickerScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            HatchCoopClickerScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            HatchCoopClickerScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            HatchCoopClickerScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            HatchCoopClickerContentView.topAnchor.constraint(equalTo: HatchCoopClickerScrollView.topAnchor),
            HatchCoopClickerContentView.leadingAnchor.constraint(equalTo: HatchCoopClickerScrollView.leadingAnchor),
            HatchCoopClickerContentView.trailingAnchor.constraint(equalTo: HatchCoopClickerScrollView.trailingAnchor),
            HatchCoopClickerContentView.bottomAnchor.constraint(equalTo: HatchCoopClickerScrollView.bottomAnchor),
            HatchCoopClickerContentView.widthAnchor.constraint(equalTo: HatchCoopClickerScrollView.widthAnchor),
            
            // Mode Card
            HatchCoopClickerModeCardView.topAnchor.constraint(equalTo: HatchCoopClickerContentView.topAnchor, constant: 20),
            HatchCoopClickerModeCardView.leadingAnchor.constraint(equalTo: HatchCoopClickerContentView.leadingAnchor, constant: 20),
            HatchCoopClickerModeCardView.trailingAnchor.constraint(equalTo: HatchCoopClickerContentView.trailingAnchor, constant: -20),
            HatchCoopClickerModeCardView.heightAnchor.constraint(equalToConstant: 120),
            
            HatchCoopClickerModeLabel.topAnchor.constraint(equalTo: HatchCoopClickerModeCardView.topAnchor, constant: 20),
            HatchCoopClickerModeLabel.leadingAnchor.constraint(equalTo: HatchCoopClickerModeCardView.leadingAnchor, constant: 20),
            
            HatchCoopClickerModeControl.topAnchor.constraint(equalTo: HatchCoopClickerModeLabel.bottomAnchor, constant: 15),
            HatchCoopClickerModeControl.leadingAnchor.constraint(equalTo: HatchCoopClickerModeCardView.leadingAnchor, constant: 20),
            HatchCoopClickerModeControl.trailingAnchor.constraint(equalTo: HatchCoopClickerModeCardView.trailingAnchor, constant: -20),
            HatchCoopClickerModeControl.heightAnchor.constraint(equalToConstant: 40),
            
            // Stats Card
            HatchCoopClickerStatsCardView.topAnchor.constraint(equalTo: HatchCoopClickerModeCardView.bottomAnchor, constant: 20),
            HatchCoopClickerStatsCardView.leadingAnchor.constraint(equalTo: HatchCoopClickerContentView.leadingAnchor, constant: 20),
            HatchCoopClickerStatsCardView.trailingAnchor.constraint(equalTo: HatchCoopClickerContentView.trailingAnchor, constant: -20),
            HatchCoopClickerStatsCardView.heightAnchor.constraint(equalToConstant: 250),
            
            HatchCoopClickerStatsLabel.topAnchor.constraint(equalTo: HatchCoopClickerStatsCardView.topAnchor, constant: 20),
            HatchCoopClickerStatsLabel.leadingAnchor.constraint(equalTo: HatchCoopClickerStatsCardView.leadingAnchor, constant: 20),
            
            HatchCoopClickerStatsStackView.topAnchor.constraint(equalTo: HatchCoopClickerStatsLabel.bottomAnchor, constant: 15),
            HatchCoopClickerStatsStackView.leadingAnchor.constraint(equalTo: HatchCoopClickerStatsCardView.leadingAnchor, constant: 20),
            HatchCoopClickerStatsStackView.trailingAnchor.constraint(equalTo: HatchCoopClickerStatsCardView.trailingAnchor, constant: -20),
            HatchCoopClickerStatsStackView.bottomAnchor.constraint(equalTo: HatchCoopClickerStatsCardView.bottomAnchor, constant: -20),
            
            // XP View
            HatchCoopClickerXPLabel.topAnchor.constraint(equalTo: HatchCoopClickerXPView.topAnchor, constant: 12),
            HatchCoopClickerXPLabel.leadingAnchor.constraint(equalTo: HatchCoopClickerXPView.leadingAnchor, constant: 15),
            HatchCoopClickerXPLabel.trailingAnchor.constraint(equalTo: HatchCoopClickerXPView.trailingAnchor, constant: -15),
            HatchCoopClickerXPView.heightAnchor.constraint(equalToConstant: 45),
            
            // Coins View
            HatchCoopClickerCoinsLabel.topAnchor.constraint(equalTo: HatchCoopClickerCoinsView.topAnchor, constant: 12),
            HatchCoopClickerCoinsLabel.leadingAnchor.constraint(equalTo: HatchCoopClickerCoinsView.leadingAnchor, constant: 15),
            HatchCoopClickerCoinsLabel.trailingAnchor.constraint(equalTo: HatchCoopClickerCoinsView.trailingAnchor, constant: -15),
            HatchCoopClickerCoinsView.heightAnchor.constraint(equalToConstant: 45),
            
            // Chickens View
            HatchCoopClickerChickensLabel.topAnchor.constraint(equalTo: HatchCoopClickerChickensView.topAnchor, constant: 12),
            HatchCoopClickerChickensLabel.leadingAnchor.constraint(equalTo: HatchCoopClickerChickensView.leadingAnchor, constant: 15),
            HatchCoopClickerChickensLabel.trailingAnchor.constraint(equalTo: HatchCoopClickerChickensView.trailingAnchor, constant: -15),
            HatchCoopClickerChickensView.heightAnchor.constraint(equalToConstant: 45),
            
            // Reset Card
            HatchCoopClickerResetCardView.topAnchor.constraint(equalTo: HatchCoopClickerStatsCardView.bottomAnchor, constant: 20),
            HatchCoopClickerResetCardView.leadingAnchor.constraint(equalTo: HatchCoopClickerContentView.leadingAnchor, constant: 20),
            HatchCoopClickerResetCardView.trailingAnchor.constraint(equalTo: HatchCoopClickerContentView.trailingAnchor, constant: -20),
            HatchCoopClickerResetCardView.heightAnchor.constraint(equalToConstant: 100),
            
            HatchCoopClickerResetAllDataButton.centerXAnchor.constraint(equalTo: HatchCoopClickerResetCardView.centerXAnchor),
            HatchCoopClickerResetAllDataButton.centerYAnchor.constraint(equalTo: HatchCoopClickerResetCardView.centerYAnchor),
            HatchCoopClickerResetAllDataButton.widthAnchor.constraint(equalToConstant: 200),
            HatchCoopClickerResetAllDataButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Legal Stack
            HatchCoopClickerLegalStackView.topAnchor.constraint(equalTo: HatchCoopClickerResetCardView.bottomAnchor, constant: 30),
            HatchCoopClickerLegalStackView.leadingAnchor.constraint(equalTo: HatchCoopClickerContentView.leadingAnchor, constant: 20),
            HatchCoopClickerLegalStackView.trailingAnchor.constraint(equalTo: HatchCoopClickerContentView.trailingAnchor, constant: -20),
            HatchCoopClickerLegalStackView.heightAnchor.constraint(equalToConstant: 45),
            HatchCoopClickerLegalStackView.bottomAnchor.constraint(equalTo: HatchCoopClickerContentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func HatchCoopClickerSetupViewModel() {
        HatchCoopClickerViewModel = HatchCoopClickerSettingsViewModel()
        HatchCoopClickerViewModel.HatchCoopClickerOnDataUpdated = { [weak self] in
            self?.HatchCoopClickerUpdateUI()
        }
        HatchCoopClickerViewModel.HatchCoopClickerUpdateData()
    }
    
    private func HatchCoopClickerUpdateUI() {
        HatchCoopClickerXPLabel.text = "⭐ Experience: \(HatchCoopClickerViewModel.HatchCoopClickerXP) XP"
        HatchCoopClickerCoinsLabel.text = "🪙 Coins: \(HatchCoopClickerViewModel.HatchCoopClickerRanchCoins)"
        HatchCoopClickerChickensLabel.text = "🐔 Chickens Owned: \(HatchCoopClickerViewModel.HatchCoopClickerChickensOwned)"
    }
    
    @objc private func HatchCoopClickerModeChanged() {
        let HatchCoopClickerModes = ["Casual", "Timed", "Silent"]
        let HatchCoopClickerSelectedMode = HatchCoopClickerModes[HatchCoopClickerModeControl.selectedSegmentIndex]
        HatchCoopClickerViewModel.HatchCoopClickerSetGameMode(HatchCoopClickerSelectedMode)
    }
    
    @objc private func HatchCoopClickerResetDataTapped() {
        let HatchCoopClickerAlert = UIAlertController(title: "Reset All Data", message: "This will permanently delete all your progress. Are you sure?", preferredStyle: .alert)
        HatchCoopClickerAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        HatchCoopClickerAlert.addAction(UIAlertAction(title: "Reset", style: .destructive) { [weak self] _ in
            self?.HatchCoopClickerViewModel.HatchCoopClickerResetAllData()
        })
        present(HatchCoopClickerAlert, animated: true)
    }
    
    @objc private func HatchCoopClickerPrivacyTapped() {
        if let HatchCoopClickerURL = URL(string: "https://example.com/privacy") {
            let HatchCoopClickerSafariVC = SFSafariViewController(url: HatchCoopClickerURL)
            present(HatchCoopClickerSafariVC, animated: true)
        }
    }
    
    @objc private func HatchCoopClickerTermsTapped() {
        if let HatchCoopClickerURL = URL(string: "https://example.com/terms") {
            let HatchCoopClickerSafariVC = SFSafariViewController(url: HatchCoopClickerURL)
            present(HatchCoopClickerSafariVC, animated: true)
        }
    }
} 
