import UIKit

class HatchCoopClickerAchievementsVC: UIViewController {
    
    private let HatchCoopClickerSharedGameData = HatchCoopClickerGameData.HatchCoopClickerShared
    private var HatchCoopClickerViewModel: HatchCoopClickerAchievementsViewModel!
    
    private lazy var HatchCoopClickerAchievementsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(red: 1.0, green: 0.95, blue: 0.88, alpha: 1.0)
        collectionView.register(HatchCoopClickerAchievementCell.self, forCellWithReuseIdentifier: "HatchCoopClickerAchievementCell")
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
        title = "🏅 Achievements"
        
        view.addSubview(HatchCoopClickerAchievementsCollectionView)
        
        NSLayoutConstraint.activate([
            HatchCoopClickerAchievementsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            HatchCoopClickerAchievementsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            HatchCoopClickerAchievementsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            HatchCoopClickerAchievementsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func HatchCoopClickerSetupViewModel() {
        HatchCoopClickerViewModel = HatchCoopClickerAchievementsViewModel()
        HatchCoopClickerViewModel.HatchCoopClickerOnDataUpdated = { [weak self] in
            self?.HatchCoopClickerUpdateUI()
        }
        HatchCoopClickerViewModel.HatchCoopClickerUpdateData()
    }
    
    private func HatchCoopClickerUpdateUI() {
        HatchCoopClickerAchievementsCollectionView.reloadData()
    }
}

extension HatchCoopClickerAchievementsVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HatchCoopClickerViewModel.HatchCoopClickerAchievements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HatchCoopClickerAchievementCell", for: indexPath) as! HatchCoopClickerAchievementCell
        let achievement = HatchCoopClickerViewModel.HatchCoopClickerAchievements[indexPath.item]
        cell.HatchCoopClickerConfigure(with: achievement)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let achievement = HatchCoopClickerViewModel.HatchCoopClickerAchievements[indexPath.item]
        if achievement.HatchCoopClickerIsUnlocked {
            let HatchCoopClickerAlert = UIAlertController(title: "🏆 \(achievement.HatchCoopClickerName)", message: "\(achievement.HatchCoopClickerDescription)\n\n🤖 FarmBot: \"\(achievement.HatchCoopClickerFarmBotQuip)\"", preferredStyle: .alert)
            HatchCoopClickerAlert.addAction(UIAlertAction(title: "Awesome!", style: .default))
            present(HatchCoopClickerAlert, animated: true)
        }
    }
}

extension HatchCoopClickerAchievementsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 40
        let spacing: CGFloat = 15
        let availableWidth = collectionView.frame.width - padding - spacing
        let itemWidth = availableWidth / 2
        return CGSize(width: itemWidth, height: 160)
    }
} 
