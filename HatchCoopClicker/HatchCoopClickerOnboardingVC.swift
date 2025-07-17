import UIKit

class HatchCoopClickerOnboardingVC: UIViewController {
    
    private let HatchCoopClickerScrollView = UIScrollView()
    private let HatchCoopClickerContentView = UIView()
    private let HatchCoopClickerPageControl = UIPageControl()
    private let HatchCoopClickerNextButton = UIButton()
    private let HatchCoopClickerSkipButton = UIButton()
    
    private let HatchCoopClickerOnboardingPages = [
        HatchCoopClickerOnboardingPage(
            HatchCoopClickerEmoji: "🐔",
            HatchCoopClickerTitle: "Welcome to HatchCoop Clicker!",
            HatchCoopClickerDescription: "Start your chicken farming adventure! Click eggs to collect them and watch your coop grow with adorable chickens."
        ),
        HatchCoopClickerOnboardingPage(
            HatchCoopClickerEmoji: "🏠",
            HatchCoopClickerTitle: "Build Your Coop",
            HatchCoopClickerDescription: "Upgrade your coop to house more chickens and increase your passive income. The bigger the coop, the more chickens you can have!"
        ),
        HatchCoopClickerOnboardingPage(
            HatchCoopClickerEmoji: "🧩",
            HatchCoopClickerTitle: "Fun Mini-Games",
            HatchCoopClickerDescription: "Enjoy exciting puzzles and games! Word Builder, Tic Tac Toe, Minesweeper, and Drawing challenges await you."
        ),
        HatchCoopClickerOnboardingPage(
            HatchCoopClickerEmoji: "🏆",
            HatchCoopClickerTitle: "Earn Achievements",
            HatchCoopClickerDescription: "Complete various tasks and unlock achievements. Track your progress and earn rewards as you become a chicken farming master!"
        ),
        HatchCoopClickerOnboardingPage(
            HatchCoopClickerEmoji: "🗺️",
            HatchCoopClickerTitle: "Explore the Map",
            HatchCoopClickerDescription: "Discover chickens on the map and purchase them to expand your collection. New chickens appear regularly for you to find!"
        )
    ]
    
    private var HatchCoopClickerCurrentPage = 0
    private var HatchCoopClickerPageViews: [HatchCoopClickerOnboardingPageView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HatchCoopClickerSetupUI()
        HatchCoopClickerSetupPages()
    }
    
    private func HatchCoopClickerSetupUI() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.98, blue: 1.0, alpha: 1.0)
        
        HatchCoopClickerScrollView.translatesAutoresizingMaskIntoConstraints = false
        HatchCoopClickerScrollView.isPagingEnabled = true
        HatchCoopClickerScrollView.showsHorizontalScrollIndicator = false
        HatchCoopClickerScrollView.delegate = self
        view.addSubview(HatchCoopClickerScrollView)
        
        HatchCoopClickerContentView.translatesAutoresizingMaskIntoConstraints = false
        HatchCoopClickerScrollView.addSubview(HatchCoopClickerContentView)
        
        HatchCoopClickerPageControl.translatesAutoresizingMaskIntoConstraints = false
        HatchCoopClickerPageControl.numberOfPages = HatchCoopClickerOnboardingPages.count
        HatchCoopClickerPageControl.currentPage = 0
        HatchCoopClickerPageControl.pageIndicatorTintColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
        HatchCoopClickerPageControl.currentPageIndicatorTintColor = UIColor(red: 0.2, green: 0.4, blue: 0.8, alpha: 1.0)
        HatchCoopClickerPageControl.addTarget(self, action: #selector(HatchCoopClickerPageControlChanged), for: .valueChanged)
        view.addSubview(HatchCoopClickerPageControl)
        
        HatchCoopClickerNextButton.translatesAutoresizingMaskIntoConstraints = false
        HatchCoopClickerNextButton.setTitle("Next", for: .normal)
        HatchCoopClickerNextButton.setTitleColor(.white, for: .normal)
        HatchCoopClickerNextButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        HatchCoopClickerNextButton.backgroundColor = UIColor(red: 0.2, green: 0.4, blue: 0.8, alpha: 1.0)
        HatchCoopClickerNextButton.layer.cornerRadius = 25
        HatchCoopClickerNextButton.layer.shadowColor = UIColor.black.cgColor
        HatchCoopClickerNextButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        HatchCoopClickerNextButton.layer.shadowRadius = 8
        HatchCoopClickerNextButton.layer.shadowOpacity = 0.3
        HatchCoopClickerNextButton.addTarget(self, action: #selector(HatchCoopClickerNextButtonTapped), for: .touchUpInside)
        view.addSubview(HatchCoopClickerNextButton)
        
        HatchCoopClickerSkipButton.translatesAutoresizingMaskIntoConstraints = false
        HatchCoopClickerSkipButton.setTitle("Skip", for: .normal)
        HatchCoopClickerSkipButton.setTitleColor(UIColor(red: 0.4, green: 0.6, blue: 0.9, alpha: 1.0), for: .normal)
        HatchCoopClickerSkipButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        HatchCoopClickerSkipButton.addTarget(self, action: #selector(HatchCoopClickerSkipButtonTapped), for: .touchUpInside)
        view.addSubview(HatchCoopClickerSkipButton)
        
        HatchCoopClickerSetupConstraints()
    }
    
    private func HatchCoopClickerSetupConstraints() {
        NSLayoutConstraint.activate([
            HatchCoopClickerScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            HatchCoopClickerScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            HatchCoopClickerScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            HatchCoopClickerScrollView.bottomAnchor.constraint(equalTo: HatchCoopClickerPageControl.topAnchor, constant: -30),
            
            HatchCoopClickerContentView.topAnchor.constraint(equalTo: HatchCoopClickerScrollView.topAnchor),
            HatchCoopClickerContentView.leadingAnchor.constraint(equalTo: HatchCoopClickerScrollView.leadingAnchor),
            HatchCoopClickerContentView.trailingAnchor.constraint(equalTo: HatchCoopClickerScrollView.trailingAnchor),
            HatchCoopClickerContentView.bottomAnchor.constraint(equalTo: HatchCoopClickerScrollView.bottomAnchor),
            HatchCoopClickerContentView.heightAnchor.constraint(equalTo: HatchCoopClickerScrollView.heightAnchor),
            
            HatchCoopClickerPageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            HatchCoopClickerPageControl.bottomAnchor.constraint(equalTo: HatchCoopClickerNextButton.topAnchor, constant: -30),
            
            HatchCoopClickerNextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            HatchCoopClickerNextButton.bottomAnchor.constraint(equalTo: HatchCoopClickerSkipButton.topAnchor, constant: -20),
            HatchCoopClickerNextButton.widthAnchor.constraint(equalToConstant: 200),
            HatchCoopClickerNextButton.heightAnchor.constraint(equalToConstant: 50),
            
            HatchCoopClickerSkipButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            HatchCoopClickerSkipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func HatchCoopClickerSetupPages() {
        for (index, HatchCoopClickerPage) in HatchCoopClickerOnboardingPages.enumerated() {
            let HatchCoopClickerPageView = HatchCoopClickerOnboardingPageView(HatchCoopClickerPage: HatchCoopClickerPage)
            HatchCoopClickerPageView.translatesAutoresizingMaskIntoConstraints = false
            HatchCoopClickerContentView.addSubview(HatchCoopClickerPageView)
            HatchCoopClickerPageViews.append(HatchCoopClickerPageView)
            
            NSLayoutConstraint.activate([
                HatchCoopClickerPageView.topAnchor.constraint(equalTo: HatchCoopClickerContentView.topAnchor),
                HatchCoopClickerPageView.bottomAnchor.constraint(equalTo: HatchCoopClickerContentView.bottomAnchor),
                HatchCoopClickerPageView.widthAnchor.constraint(equalTo: HatchCoopClickerScrollView.widthAnchor),
                HatchCoopClickerPageView.heightAnchor.constraint(equalTo: HatchCoopClickerScrollView.heightAnchor)
            ])
            
            if index == 0 {
                HatchCoopClickerPageView.leadingAnchor.constraint(equalTo: HatchCoopClickerContentView.leadingAnchor).isActive = true
            } else {
                HatchCoopClickerPageView.leadingAnchor.constraint(equalTo: HatchCoopClickerPageViews[index - 1].trailingAnchor).isActive = true
            }
            
            if index == HatchCoopClickerOnboardingPages.count - 1 {
                HatchCoopClickerPageView.trailingAnchor.constraint(equalTo: HatchCoopClickerContentView.trailingAnchor).isActive = true
            }
        }
    }
    
    @objc private func HatchCoopClickerNextButtonTapped() {
        if HatchCoopClickerCurrentPage < HatchCoopClickerOnboardingPages.count - 1 {
            HatchCoopClickerCurrentPage += 1
            HatchCoopClickerUpdateUI()
            HatchCoopClickerScrollToPage(HatchCoopClickerCurrentPage)
        } else {
            HatchCoopClickerFinishOnboarding()
        }
    }
    
    @objc private func HatchCoopClickerSkipButtonTapped() {
        HatchCoopClickerFinishOnboarding()
    }
    
    @objc private func HatchCoopClickerPageControlChanged() {
        HatchCoopClickerCurrentPage = HatchCoopClickerPageControl.currentPage
        HatchCoopClickerUpdateUI()
        HatchCoopClickerScrollToPage(HatchCoopClickerCurrentPage)
    }
    
    private func HatchCoopClickerUpdateUI() {
        HatchCoopClickerPageControl.currentPage = HatchCoopClickerCurrentPage
        
        if HatchCoopClickerCurrentPage == HatchCoopClickerOnboardingPages.count - 1 {
            HatchCoopClickerNextButton.setTitle("Get Started", for: .normal)
        } else {
            HatchCoopClickerNextButton.setTitle("Next", for: .normal)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.HatchCoopClickerNextButton.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        } completion: { _ in
            UIView.animate(withDuration: 0.2) {
                self.HatchCoopClickerNextButton.transform = .identity
            }
        }
    }
    
    private func HatchCoopClickerScrollToPage(_ HatchCoopClickerPage: Int) {
        let HatchCoopClickerOffset = CGPoint(x: CGFloat(HatchCoopClickerPage) * HatchCoopClickerScrollView.frame.width, y: 0)
        HatchCoopClickerScrollView.setContentOffset(HatchCoopClickerOffset, animated: true)
    }
    
    private func HatchCoopClickerFinishOnboarding() {
        UserDefaults.standard.set(true, forKey: "HatchCoopClickerHasSeenOnboarding")
        
        let HatchCoopClickerTabBarController = HatchCoopClickerTabBarController()
        HatchCoopClickerTabBarController.modalPresentationStyle = .fullScreen
        present(HatchCoopClickerTabBarController, animated: true)
    }
}

extension HatchCoopClickerOnboardingVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let HatchCoopClickerPage = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
        HatchCoopClickerCurrentPage = HatchCoopClickerPage
        HatchCoopClickerUpdateUI()
    }
}

struct HatchCoopClickerOnboardingPage {
    let HatchCoopClickerEmoji: String
    let HatchCoopClickerTitle: String
    let HatchCoopClickerDescription: String
}

class HatchCoopClickerOnboardingPageView: UIView {
    
    private let HatchCoopClickerEmojiLabel = UILabel()
    private let HatchCoopClickerTitleLabel = UILabel()
    private let HatchCoopClickerDescriptionLabel = UILabel()
    private let HatchCoopClickerBackgroundEmojis = ["🌟", "⭐", "💎", "🎨", "🧩", "📚", "🎪", "🌈", "🎭", "🎯", "🌻", "🌺", "🌸", "🍀", "🌿", "🌱", "🌲", "🌳", "🌴", "🌵", "🌾", "🌽", "🌻", "🌼", "🌷", "🌹", "🌺", "🌸", "🌼", "🌻", "🌺", "🌸", "🌼", "🌻", "🌺", "🌸", "🌼", "🌻", "🌺", "🌸", "🌼"]
    
    init(HatchCoopClickerPage: HatchCoopClickerOnboardingPage) {
        super.init(frame: .zero)
        HatchCoopClickerSetupUI(HatchCoopClickerPage: HatchCoopClickerPage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func HatchCoopClickerSetupUI(HatchCoopClickerPage: HatchCoopClickerOnboardingPage) {
        backgroundColor = UIColor(red: 0.95, green: 0.98, blue: 1.0, alpha: 1.0)
        
        HatchCoopClickerSetupBackgroundEmojis()
        
        HatchCoopClickerEmojiLabel.translatesAutoresizingMaskIntoConstraints = false
        HatchCoopClickerEmojiLabel.text = HatchCoopClickerPage.HatchCoopClickerEmoji
        HatchCoopClickerEmojiLabel.font = UIFont.systemFont(ofSize: 80)
        HatchCoopClickerEmojiLabel.textAlignment = .center
        addSubview(HatchCoopClickerEmojiLabel)
        
        HatchCoopClickerTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        HatchCoopClickerTitleLabel.text = HatchCoopClickerPage.HatchCoopClickerTitle
        HatchCoopClickerTitleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        HatchCoopClickerTitleLabel.textColor = UIColor(red: 0.2, green: 0.4, blue: 0.8, alpha: 1.0)
        HatchCoopClickerTitleLabel.textAlignment = .center
        HatchCoopClickerTitleLabel.numberOfLines = 0
        addSubview(HatchCoopClickerTitleLabel)
        
        HatchCoopClickerDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        HatchCoopClickerDescriptionLabel.text = HatchCoopClickerPage.HatchCoopClickerDescription
        HatchCoopClickerDescriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        HatchCoopClickerDescriptionLabel.textColor = UIColor(red: 0.4, green: 0.6, blue: 0.9, alpha: 1.0)
        HatchCoopClickerDescriptionLabel.textAlignment = .center
        HatchCoopClickerDescriptionLabel.numberOfLines = 0
        HatchCoopClickerDescriptionLabel.lineBreakMode = .byWordWrapping
        addSubview(HatchCoopClickerDescriptionLabel)
        
        NSLayoutConstraint.activate([
            HatchCoopClickerEmojiLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            HatchCoopClickerEmojiLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -80),
            
            HatchCoopClickerTitleLabel.topAnchor.constraint(equalTo: HatchCoopClickerEmojiLabel.bottomAnchor, constant: 30),
            HatchCoopClickerTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            HatchCoopClickerTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            HatchCoopClickerDescriptionLabel.topAnchor.constraint(equalTo: HatchCoopClickerTitleLabel.bottomAnchor, constant: 20),
            HatchCoopClickerDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            HatchCoopClickerDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)
        ])
        
        HatchCoopClickerStartAnimations()
    }
    
    private func HatchCoopClickerSetupBackgroundEmojis() {
        for emoji in HatchCoopClickerBackgroundEmojis {
            let HatchCoopClickerBackgroundEmojiLabel = UILabel()
            HatchCoopClickerBackgroundEmojiLabel.text = emoji
            HatchCoopClickerBackgroundEmojiLabel.font = UIFont.systemFont(ofSize: CGFloat.random(in: 24...36))
            HatchCoopClickerBackgroundEmojiLabel.alpha = CGFloat.random(in: 0.05...0.15)
            HatchCoopClickerBackgroundEmojiLabel.translatesAutoresizingMaskIntoConstraints = false
            addSubview(HatchCoopClickerBackgroundEmojiLabel)
            
            let HatchCoopClickerRandomX = CGFloat.random(in: 0...1)
            let HatchCoopClickerRandomY = CGFloat.random(in: 0...1)
            
            NSLayoutConstraint.activate([
                HatchCoopClickerBackgroundEmojiLabel.centerXAnchor.constraint(equalTo: leadingAnchor, constant: HatchCoopClickerRandomX * 350),
                HatchCoopClickerBackgroundEmojiLabel.centerYAnchor.constraint(equalTo: topAnchor, constant: HatchCoopClickerRandomY * 700)
            ])
        }
    }
    
    private func HatchCoopClickerStartAnimations() {
        HatchCoopClickerEmojiLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        HatchCoopClickerEmojiLabel.alpha = 0
        
        UIView.animate(withDuration: 0.8, delay: 0.2, options: .curveEaseOut) {
            self.HatchCoopClickerEmojiLabel.transform = .identity
            self.HatchCoopClickerEmojiLabel.alpha = 1
        }
        
        HatchCoopClickerTitleLabel.alpha = 0
        HatchCoopClickerTitleLabel.transform = CGAffineTransform(translationX: 0, y: 20)
        
        UIView.animate(withDuration: 0.6, delay: 0.6, options: .curveEaseOut) {
            self.HatchCoopClickerTitleLabel.alpha = 1
            self.HatchCoopClickerTitleLabel.transform = .identity
        }
        
        HatchCoopClickerDescriptionLabel.alpha = 0
        HatchCoopClickerDescriptionLabel.transform = CGAffineTransform(translationX: 0, y: 20)
        
        UIView.animate(withDuration: 0.6, delay: 0.8, options: .curveEaseOut) {
            self.HatchCoopClickerDescriptionLabel.alpha = 1
            self.HatchCoopClickerDescriptionLabel.transform = .identity
        }
    }
} 