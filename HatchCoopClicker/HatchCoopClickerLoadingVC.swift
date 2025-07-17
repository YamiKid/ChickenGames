import UIKit

class HatchCoopClickerLoadingVC: UIViewController {
    
    private let HatchCoopClickerBackgroundView = UIView()
    private let HatchCoopClickerLogoLabel = UILabel()
    private let HatchCoopClickerLoadingLabel = UILabel()
    private let HatchCoopClickerEmojiContainer = UIView()
    private let HatchCoopClickerProgressView = UIProgressView()
    
    private let HatchCoopClickerEmojis = ["🐔", "🥚", "🏠", "🌾", "🎯", "🏆", "⭐", "💎", "🌟", "🎨", "🧩", "📚", "🎪", "🌈", "🎭", "🌻", "🌺", "🌸", "🍀", "🌿", "🌱", "🌲", "🌳", "🌴", "🌵", "🌾", "🌽", "🌻", "🌼", "🌷", "🌹", "🌺", "🌸", "🌼", "🌻", "🌺", "🌸", "🌼", "🌻", "🌺", "🌸"]
    private var HatchCoopClickerEmojiLabels: [UILabel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HatchCoopClickerSetupUI()
        HatchCoopClickerStartAnimations()
    }
    
    private func HatchCoopClickerSetupUI() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.98, blue: 1.0, alpha: 1.0)
        
        HatchCoopClickerBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(HatchCoopClickerBackgroundView)
        
        HatchCoopClickerLogoLabel.translatesAutoresizingMaskIntoConstraints = false
        HatchCoopClickerLogoLabel.text = "🐔 HatchCoop Clicker 🥚"
        HatchCoopClickerLogoLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        HatchCoopClickerLogoLabel.textColor = UIColor(red: 0.2, green: 0.4, blue: 0.8, alpha: 1.0)
        HatchCoopClickerLogoLabel.textAlignment = .center
        HatchCoopClickerLogoLabel.alpha = 0
        view.addSubview(HatchCoopClickerLogoLabel)
        
        HatchCoopClickerLoadingLabel.translatesAutoresizingMaskIntoConstraints = false
        HatchCoopClickerLoadingLabel.text = "Loading..."
        HatchCoopClickerLoadingLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        HatchCoopClickerLoadingLabel.textColor = UIColor(red: 0.4, green: 0.6, blue: 0.9, alpha: 1.0)
        HatchCoopClickerLoadingLabel.textAlignment = .center
        HatchCoopClickerLoadingLabel.alpha = 0
        view.addSubview(HatchCoopClickerLoadingLabel)
        
        HatchCoopClickerProgressView.translatesAutoresizingMaskIntoConstraints = false
        HatchCoopClickerProgressView.progressTintColor = UIColor(red: 0.2, green: 0.4, blue: 0.8, alpha: 1.0)
        HatchCoopClickerProgressView.trackTintColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        HatchCoopClickerProgressView.layer.cornerRadius = 4
        HatchCoopClickerProgressView.clipsToBounds = true
        HatchCoopClickerProgressView.progress = 0
        HatchCoopClickerProgressView.alpha = 0
        view.addSubview(HatchCoopClickerProgressView)
        
        HatchCoopClickerEmojiContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(HatchCoopClickerEmojiContainer)
        
        HatchCoopClickerSetupEmojis()
        HatchCoopClickerSetupConstraints()
    }
    
    private func HatchCoopClickerSetupEmojis() {
        for emoji in HatchCoopClickerEmojis {
            let HatchCoopClickerEmojiLabel = UILabel()
            HatchCoopClickerEmojiLabel.text = emoji
            HatchCoopClickerEmojiLabel.font = UIFont.systemFont(ofSize: CGFloat.random(in: 20...32))
            HatchCoopClickerEmojiLabel.alpha = CGFloat.random(in: 0.1...0.4)
            HatchCoopClickerEmojiLabel.translatesAutoresizingMaskIntoConstraints = false
            HatchCoopClickerEmojiContainer.addSubview(HatchCoopClickerEmojiLabel)
            HatchCoopClickerEmojiLabels.append(HatchCoopClickerEmojiLabel)
            
            let HatchCoopClickerRandomX = CGFloat.random(in: 0...1)
            let HatchCoopClickerRandomY = CGFloat.random(in: 0...1)
            
            NSLayoutConstraint.activate([
                HatchCoopClickerEmojiLabel.centerXAnchor.constraint(equalTo: HatchCoopClickerEmojiContainer.leadingAnchor, constant: HatchCoopClickerRandomX * 350),
                HatchCoopClickerEmojiLabel.centerYAnchor.constraint(equalTo: HatchCoopClickerEmojiContainer.topAnchor, constant: HatchCoopClickerRandomY * 700)
            ])
        }
    }
    
    private func HatchCoopClickerSetupConstraints() {
        NSLayoutConstraint.activate([
            HatchCoopClickerBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            HatchCoopClickerBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            HatchCoopClickerBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            HatchCoopClickerBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            HatchCoopClickerLogoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            HatchCoopClickerLogoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            
            HatchCoopClickerProgressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            HatchCoopClickerProgressView.topAnchor.constraint(equalTo: HatchCoopClickerLogoLabel.bottomAnchor, constant: 40),
            HatchCoopClickerProgressView.widthAnchor.constraint(equalToConstant: 200),
            HatchCoopClickerProgressView.heightAnchor.constraint(equalToConstant: 8),
            
            HatchCoopClickerLoadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            HatchCoopClickerLoadingLabel.topAnchor.constraint(equalTo: HatchCoopClickerProgressView.bottomAnchor, constant: 20),
            
            HatchCoopClickerEmojiContainer.topAnchor.constraint(equalTo: view.topAnchor),
            HatchCoopClickerEmojiContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            HatchCoopClickerEmojiContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            HatchCoopClickerEmojiContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func HatchCoopClickerStartAnimations() {
        UIView.animate(withDuration: 0.8, delay: 0.2, options: .curveEaseInOut) {
            self.HatchCoopClickerLogoLabel.alpha = 1
            self.HatchCoopClickerLogoLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.HatchCoopClickerLogoLabel.transform = .identity
            }
        }
        
        UIView.animate(withDuration: 0.6, delay: 0.6, options: .curveEaseInOut) {
            self.HatchCoopClickerProgressView.alpha = 1
            self.HatchCoopClickerLoadingLabel.alpha = 1
        }
        
        HatchCoopClickerAnimateProgress()
        HatchCoopClickerAnimateEmojis()
        HatchCoopClickerAnimateLoadingText()
    }
    
    private func HatchCoopClickerAnimateProgress() {
        var HatchCoopClickerProgress: Float = 0
        let HatchCoopClickerTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            HatchCoopClickerProgress += 0.02
            self.HatchCoopClickerProgressView.setProgress(HatchCoopClickerProgress, animated: true)
            
            if HatchCoopClickerProgress >= 1.0 {
                timer.invalidate()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.HatchCoopClickerCheckOnboarding()
                }
            }
        }
    }
    
    private func HatchCoopClickerAnimateEmojis() {
        for (index, HatchCoopClickerEmojiLabel) in HatchCoopClickerEmojiLabels.enumerated() {
            let HatchCoopClickerDelay = Double(index) * 0.2
            let HatchCoopClickerRandomX = CGFloat.random(in: -50...50)
            let HatchCoopClickerRandomY = CGFloat.random(in: -100...100)
            
            UIView.animate(withDuration: 2.0, delay: HatchCoopClickerDelay, options: [.repeat, .autoreverse, .curveEaseInOut]) {
                HatchCoopClickerEmojiLabel.transform = CGAffineTransform(translationX: HatchCoopClickerRandomX, y: HatchCoopClickerRandomY)
                HatchCoopClickerEmojiLabel.alpha = 0.7
            }
        }
    }
    
    private func HatchCoopClickerAnimateLoadingText() {
        let HatchCoopClickerLoadingTexts = ["Loading...", "Loading..", "Loading.", "Loading..", "Loading..."]
        var HatchCoopClickerTextIndex = 0
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            UIView.animate(withDuration: 0.2) {
                self.HatchCoopClickerLoadingLabel.alpha = 0
            } completion: { _ in
                self.HatchCoopClickerLoadingLabel.text = HatchCoopClickerLoadingTexts[HatchCoopClickerTextIndex]
                UIView.animate(withDuration: 0.2) {
                    self.HatchCoopClickerLoadingLabel.alpha = 1
                }
                HatchCoopClickerTextIndex = (HatchCoopClickerTextIndex + 1) % HatchCoopClickerLoadingTexts.count
            }
        }
    }
    
    private func HatchCoopClickerCheckOnboarding() {
        let HatchCoopClickerHasSeenOnboarding = UserDefaults.standard.bool(forKey: "HatchCoopClickerHasSeenOnboarding")
        
        if HatchCoopClickerHasSeenOnboarding {
            HatchCoopClickerShowMainApp()
        } else {
            HatchCoopClickerShowOnboarding()
        }
    }
    
    private func HatchCoopClickerShowOnboarding() {
        let HatchCoopClickerOnboardingVC = HatchCoopClickerOnboardingVC()
        HatchCoopClickerOnboardingVC.modalPresentationStyle = .fullScreen
        present(HatchCoopClickerOnboardingVC, animated: true)
    }
    
    private func HatchCoopClickerShowMainApp() {
        let HatchCoopClickerTabBarController = HatchCoopClickerTabBarController()
        HatchCoopClickerTabBarController.modalPresentationStyle = .fullScreen
        present(HatchCoopClickerTabBarController, animated: true)
    }
} 