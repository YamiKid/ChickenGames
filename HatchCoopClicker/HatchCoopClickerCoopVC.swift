import UIKit

class HatchCoopClickerCoopVC: UIViewController {
    
    private let HatchCoopClickerSharedGameData = HatchCoopClickerGameData.HatchCoopClickerShared
    private var HatchCoopClickerViewModel: HatchCoopClickerFeedPuzzlesViewModel!
    
    private lazy var HatchCoopClickerUserStatsCard: UIView = {
        let card = UIView()
        card.backgroundColor = UIColor(red: 1.0, green: 0.98, blue: 0.95, alpha: 1.0)
        card.layer.cornerRadius = 15
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOpacity = 0.1
        card.layer.shadowRadius = 8
        card.layer.shadowOffset = CGSize(width: 0, height: 4)
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()
    
    private lazy var HatchCoopClickerLevelLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerCoinsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = UIColor(red: 1.0, green: 0.84, blue: 0.31, alpha: 1.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerXPProgressBar: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.progressTintColor = UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 1.0)
        progressView.trackTintColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        progressView.layer.cornerRadius = 5
        progressView.clipsToBounds = true
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    private lazy var HatchCoopClickerXPLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerQuizButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("🧠 Take Quiz", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.4, green: 0.2, blue: 0.8, alpha: 1.0)
        button.layer.cornerRadius = 12
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 6
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(HatchCoopClickerQuizButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var HatchCoopClickerGamesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: 160, height: 120)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(red: 1.0, green: 0.95, blue: 0.88, alpha: 1.0)
        collectionView.register(HatchCoopClickerGameCell.self, forCellWithReuseIdentifier: "HatchCoopClickerGameCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
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
        title = "🐔 Coop"
        
        view.addSubview(HatchCoopClickerUserStatsCard)
        view.addSubview(HatchCoopClickerQuizButton)
        view.addSubview(HatchCoopClickerGamesCollectionView)
        
        HatchCoopClickerUserStatsCard.addSubview(HatchCoopClickerLevelLabel)
        HatchCoopClickerUserStatsCard.addSubview(HatchCoopClickerCoinsLabel)
        HatchCoopClickerUserStatsCard.addSubview(HatchCoopClickerXPProgressBar)
        HatchCoopClickerUserStatsCard.addSubview(HatchCoopClickerXPLabel)
        
        NSLayoutConstraint.activate([
            HatchCoopClickerUserStatsCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            HatchCoopClickerUserStatsCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            HatchCoopClickerUserStatsCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            HatchCoopClickerUserStatsCard.heightAnchor.constraint(equalToConstant: 100),
            
            HatchCoopClickerLevelLabel.topAnchor.constraint(equalTo: HatchCoopClickerUserStatsCard.topAnchor, constant: 15),
            HatchCoopClickerLevelLabel.leadingAnchor.constraint(equalTo: HatchCoopClickerUserStatsCard.leadingAnchor, constant: 20),
            HatchCoopClickerLevelLabel.trailingAnchor.constraint(equalTo: HatchCoopClickerUserStatsCard.trailingAnchor, constant: -20),
            
            HatchCoopClickerCoinsLabel.topAnchor.constraint(equalTo: HatchCoopClickerLevelLabel.bottomAnchor, constant: 5),
            HatchCoopClickerCoinsLabel.leadingAnchor.constraint(equalTo: HatchCoopClickerUserStatsCard.leadingAnchor, constant: 20),
            HatchCoopClickerCoinsLabel.trailingAnchor.constraint(equalTo: HatchCoopClickerUserStatsCard.trailingAnchor, constant: -20),
            
            HatchCoopClickerXPProgressBar.topAnchor.constraint(equalTo: HatchCoopClickerCoinsLabel.bottomAnchor, constant: 8),
            HatchCoopClickerXPProgressBar.leadingAnchor.constraint(equalTo: HatchCoopClickerUserStatsCard.leadingAnchor, constant: 20),
            HatchCoopClickerXPProgressBar.trailingAnchor.constraint(equalTo: HatchCoopClickerUserStatsCard.trailingAnchor, constant: -20),
            HatchCoopClickerXPProgressBar.heightAnchor.constraint(equalToConstant: 6),
            
            HatchCoopClickerXPLabel.topAnchor.constraint(equalTo: HatchCoopClickerXPProgressBar.bottomAnchor, constant: 4),
            HatchCoopClickerXPLabel.leadingAnchor.constraint(equalTo: HatchCoopClickerUserStatsCard.leadingAnchor, constant: 20),
            HatchCoopClickerXPLabel.trailingAnchor.constraint(equalTo: HatchCoopClickerUserStatsCard.trailingAnchor, constant: -20),
            
            HatchCoopClickerQuizButton.topAnchor.constraint(equalTo: HatchCoopClickerUserStatsCard.bottomAnchor, constant: 20),
            HatchCoopClickerQuizButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            HatchCoopClickerQuizButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            HatchCoopClickerQuizButton.heightAnchor.constraint(equalToConstant: 50),
            
            HatchCoopClickerGamesCollectionView.topAnchor.constraint(equalTo: HatchCoopClickerQuizButton.bottomAnchor, constant: 20),
            HatchCoopClickerGamesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            HatchCoopClickerGamesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            HatchCoopClickerGamesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    @objc private func HatchCoopClickerQuizButtonTapped() {
        let HatchCoopClickerQuizVC = HatchCoopClickerQuizVC()
        HatchCoopClickerQuizVC.HatchCoopClickerOnQuizCompleted = { [weak self] coins, xp in
            self?.HatchCoopClickerViewModel.HatchCoopClickerAddRewards(coins: coins, xp: xp)
        }
        navigationController?.pushViewController(HatchCoopClickerQuizVC, animated: true)
    }
    
    private func HatchCoopClickerSetupViewModel() {
        HatchCoopClickerViewModel = HatchCoopClickerFeedPuzzlesViewModel()
        HatchCoopClickerViewModel.HatchCoopClickerOnDataUpdated = { [weak self] in
            self?.HatchCoopClickerUpdateUI()
        }
        HatchCoopClickerViewModel.HatchCoopClickerUpdateData()
    }
    
    private func HatchCoopClickerUpdateUI() {
        let HatchCoopClickerCurrentLevel = HatchCoopClickerViewModel.HatchCoopClickerCurrentLevel
        let HatchCoopClickerXPProgress = HatchCoopClickerViewModel.HatchCoopClickerXPProgress
        
        HatchCoopClickerLevelLabel.text = "Level \(HatchCoopClickerCurrentLevel)"
        HatchCoopClickerCoinsLabel.text = "💰 \(HatchCoopClickerViewModel.HatchCoopClickerRanchCoins) RanchCoins"
        HatchCoopClickerXPProgressBar.progress = Float(HatchCoopClickerXPProgress)
        HatchCoopClickerXPLabel.text = "XP: \(HatchCoopClickerViewModel.HatchCoopClickerXP) / \(HatchCoopClickerCurrentLevel * 100)"
        HatchCoopClickerGamesCollectionView.reloadData()
    }
}

extension HatchCoopClickerCoopVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HatchCoopClickerViewModel.HatchCoopClickerGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HatchCoopClickerGameCell", for: indexPath) as! HatchCoopClickerGameCell
        let game = HatchCoopClickerViewModel.HatchCoopClickerGames[indexPath.item]
        cell.HatchCoopClickerConfigure(with: game)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let game = HatchCoopClickerViewModel.HatchCoopClickerGames[indexPath.item]
        
        switch game.HatchCoopClickerId {
        case "wordGame":
            let HatchCoopClickerWordGameVC = HatchCoopClickerWordGameVC()
            HatchCoopClickerWordGameVC.HatchCoopClickerOnGameCompleted = { [weak self] coins, xp in
                self?.HatchCoopClickerViewModel.HatchCoopClickerAddRewards(coins: coins, xp: xp)
            }
            navigationController?.pushViewController(HatchCoopClickerWordGameVC, animated: true)
            
        case "drawingGame":
            let HatchCoopClickerDrawingGameVC = HatchCoopClickerDrawingGameVC()
            HatchCoopClickerDrawingGameVC.HatchCoopClickerOnGameCompleted = { [weak self] coins, xp in
                self?.HatchCoopClickerViewModel.HatchCoopClickerAddRewards(coins: coins, xp: xp)
            }
            navigationController?.pushViewController(HatchCoopClickerDrawingGameVC, animated: true)
            
        case "tictactoeGame":
            let HatchCoopClickerTicTacToeGameVC = HatchCoopClickerTicTacToeGameVC()
            HatchCoopClickerTicTacToeGameVC.HatchCoopClickerOnGameCompleted = { [weak self] coins, xp in
                self?.HatchCoopClickerViewModel.HatchCoopClickerAddRewards(coins: coins, xp: xp)
            }
            navigationController?.pushViewController(HatchCoopClickerTicTacToeGameVC, animated: true)
            
        case "minesweeperGame":
            let HatchCoopClickerMinesweeperGameVC = HatchCoopClickerMinesweeperGameVC()
            HatchCoopClickerMinesweeperGameVC.HatchCoopClickerOnGameCompleted = { [weak self] coins, xp in
                self?.HatchCoopClickerViewModel.HatchCoopClickerAddRewards(coins: coins, xp: xp)
            }
            navigationController?.pushViewController(HatchCoopClickerMinesweeperGameVC, animated: true)
            
        default:
            break
        }
    }
} 