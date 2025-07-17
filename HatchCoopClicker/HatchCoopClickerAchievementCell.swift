import UIKit

class HatchCoopClickerAchievementCell: UICollectionViewCell {
    
    private lazy var HatchCoopClickerCardView: UIView = {
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
    
    private lazy var HatchCoopClickerEmojiLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerProgressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.progressTintColor = UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 1.0)
        progressView.trackTintColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        progressView.layer.cornerRadius = 4
        progressView.clipsToBounds = true
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    private lazy var HatchCoopClickerProgressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerStatusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerLockIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "lock.fill")
        imageView.tintColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        HatchCoopClickerSetupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func HatchCoopClickerSetupUI() {
        contentView.addSubview(HatchCoopClickerCardView)
        HatchCoopClickerCardView.addSubview(HatchCoopClickerEmojiLabel)
        HatchCoopClickerCardView.addSubview(HatchCoopClickerTitleLabel)
        HatchCoopClickerCardView.addSubview(HatchCoopClickerProgressView)
        HatchCoopClickerCardView.addSubview(HatchCoopClickerProgressLabel)
        HatchCoopClickerCardView.addSubview(HatchCoopClickerStatusLabel)
        HatchCoopClickerCardView.addSubview(HatchCoopClickerLockIcon)
        
        NSLayoutConstraint.activate([
            HatchCoopClickerCardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            HatchCoopClickerCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            HatchCoopClickerCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            HatchCoopClickerCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            HatchCoopClickerEmojiLabel.topAnchor.constraint(equalTo: HatchCoopClickerCardView.topAnchor, constant: 15),
            HatchCoopClickerEmojiLabel.centerXAnchor.constraint(equalTo: HatchCoopClickerCardView.centerXAnchor),
            
            HatchCoopClickerTitleLabel.topAnchor.constraint(equalTo: HatchCoopClickerEmojiLabel.bottomAnchor, constant: 8),
            HatchCoopClickerTitleLabel.leadingAnchor.constraint(equalTo: HatchCoopClickerCardView.leadingAnchor, constant: 10),
            HatchCoopClickerTitleLabel.trailingAnchor.constraint(equalTo: HatchCoopClickerCardView.trailingAnchor, constant: -10),
            
            HatchCoopClickerProgressView.topAnchor.constraint(equalTo: HatchCoopClickerTitleLabel.bottomAnchor, constant: 8),
            HatchCoopClickerProgressView.leadingAnchor.constraint(equalTo: HatchCoopClickerCardView.leadingAnchor, constant: 15),
            HatchCoopClickerProgressView.trailingAnchor.constraint(equalTo: HatchCoopClickerCardView.trailingAnchor, constant: -15),
            HatchCoopClickerProgressView.heightAnchor.constraint(equalToConstant: 6),
            
            HatchCoopClickerProgressLabel.topAnchor.constraint(equalTo: HatchCoopClickerProgressView.bottomAnchor, constant: 4),
            HatchCoopClickerProgressLabel.leadingAnchor.constraint(equalTo: HatchCoopClickerCardView.leadingAnchor, constant: 10),
            HatchCoopClickerProgressLabel.trailingAnchor.constraint(equalTo: HatchCoopClickerCardView.trailingAnchor, constant: -10),
            
            HatchCoopClickerStatusLabel.topAnchor.constraint(equalTo: HatchCoopClickerProgressLabel.bottomAnchor, constant: 6),
            HatchCoopClickerStatusLabel.centerXAnchor.constraint(equalTo: HatchCoopClickerCardView.centerXAnchor),
            HatchCoopClickerStatusLabel.heightAnchor.constraint(equalToConstant: 20),
            HatchCoopClickerStatusLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 60),
            HatchCoopClickerStatusLabel.bottomAnchor.constraint(lessThanOrEqualTo: HatchCoopClickerCardView.bottomAnchor, constant: -10),
            
            HatchCoopClickerLockIcon.topAnchor.constraint(equalTo: HatchCoopClickerCardView.topAnchor, constant: 10),
            HatchCoopClickerLockIcon.trailingAnchor.constraint(equalTo: HatchCoopClickerCardView.trailingAnchor, constant: -10),
            HatchCoopClickerLockIcon.widthAnchor.constraint(equalToConstant: 16),
            HatchCoopClickerLockIcon.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    func HatchCoopClickerConfigure(with achievement: HatchCoopClickerAchievement) {
        HatchCoopClickerEmojiLabel.text = achievement.HatchCoopClickerEmoji
        HatchCoopClickerTitleLabel.text = achievement.HatchCoopClickerName
        
    
        let currentProgress = HatchCoopClickerGetCurrentProgress(for: achievement.HatchCoopClickerType)
        let progress = min(Double(currentProgress) / Double(achievement.HatchCoopClickerRequirement), 1.0)
        
        HatchCoopClickerProgressView.progress = Float(progress)
        HatchCoopClickerProgressLabel.text = "\(currentProgress)/\(achievement.HatchCoopClickerRequirement)"
        
        if achievement.HatchCoopClickerIsUnlocked {
            HatchCoopClickerStatusLabel.text = "✅ Unlocked"
            HatchCoopClickerStatusLabel.backgroundColor = UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 0.2)
            HatchCoopClickerStatusLabel.textColor = UIColor(red: 0.2, green: 0.6, blue: 0.2, alpha: 1.0)
            HatchCoopClickerLockIcon.isHidden = true
            HatchCoopClickerCardView.layer.borderWidth = 0
            HatchCoopClickerCardView.backgroundColor = UIColor(red: 1.0, green: 0.98, blue: 0.95, alpha: 1.0)
        } else {

            HatchCoopClickerStatusLabel.text = "🔒 Locked"
            HatchCoopClickerStatusLabel.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.3)
            HatchCoopClickerStatusLabel.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
            HatchCoopClickerLockIcon.isHidden = false
            HatchCoopClickerCardView.layer.borderWidth = 1
            HatchCoopClickerCardView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
            HatchCoopClickerCardView.backgroundColor = UIColor(red: 0.98, green: 0.96, blue: 0.93, alpha: 1.0)
        }
        
       
        HatchCoopClickerAnimateProgressBar()
    }
    
    private func HatchCoopClickerGetCurrentProgress(for type: String) -> Int {
        let gameData = HatchCoopClickerGameData.HatchCoopClickerShared
        
        switch type {
        case "eggs":
            return gameData.HatchCoopClickerTotalEggsCollected
        case "chickens":
            return gameData.HatchCoopClickerChickensOwned
        case "puzzles":
            return gameData.HatchCoopClickerTotalPuzzlesSolved
        case "coins":
            return gameData.HatchCoopClickerTotalCoinsEarned
        case "quizzes":
            return gameData.HatchCoopClickerTotalQuizzesCompleted
        case "level":
            return gameData.HatchCoopClickerMaxLevelReached
        case "wordBuilder":
            return gameData.HatchCoopClickerWordBuilderGamesPlayed
        case "ticTacToe":
            return gameData.HatchCoopClickerTicTacToeGamesPlayed
        case "minesweeper":
            return gameData.HatchCoopClickerMinesweeperGamesPlayed
        case "mapChickens":
            return gameData.HatchCoopClickerMapChickensBought
        default:
            return 0
        }
    }
    
    private func HatchCoopClickerAnimateProgressBar() {
        let currentProgress = HatchCoopClickerProgressView.progress
        HatchCoopClickerProgressView.progress = 0
        
        UIView.animate(withDuration: 0.8, delay: 0.2, options: .curveEaseInOut, animations: {
            self.HatchCoopClickerProgressView.setProgress(currentProgress, animated: true)
        })
    }
} 
