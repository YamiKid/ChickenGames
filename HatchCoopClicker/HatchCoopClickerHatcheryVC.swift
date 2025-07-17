import UIKit

class HatchCoopClickerHatcheryVC: UIViewController {
    
    private let HatchCoopClickerSharedGameData = HatchCoopClickerGameData.HatchCoopClickerShared
    private var HatchCoopClickerViewModel: HatchCoopClickerHatcheryViewModel!
    
    struct HatchCoopClickerChickenFact {
        let title: String
        let shortDescription: String
        let fullDescription: String
        let emoji: String
    }
    
    private let HatchCoopClickerChickenFacts: [HatchCoopClickerChickenFact] = [
        HatchCoopClickerChickenFact(
            title: "Egg Production",
            shortDescription: "Chickens can lay up to 300 eggs per year",
            fullDescription: "A healthy hen can lay between 250-300 eggs per year, depending on the breed. The most productive breeds include Leghorns, Rhode Island Reds, and Sussex chickens. Egg production is influenced by factors like daylight hours, nutrition, and stress levels.",
            emoji: "🥚"
        ),
        HatchCoopClickerChickenFact(
            title: "Color Vision",
            shortDescription: "Chickens have excellent color vision",
            fullDescription: "Chickens can see more colors than humans! They have four types of color receptors in their eyes compared to our three. This means they can see ultraviolet light and distinguish between colors that look identical to us. This enhanced vision helps them find food and avoid predators.",
            emoji: "👁️"
        ),
        HatchCoopClickerChickenFact(
            title: "Memory & Intelligence",
            shortDescription: "Chickens are smarter than you think",
            fullDescription: "Chickens have excellent memories and can recognize over 100 different faces, both human and chicken. They can solve complex problems, understand cause and effect, and even show empathy. Studies have shown they can count, understand object permanence, and learn from watching other chickens.",
            emoji: "🧠"
        ),
        HatchCoopClickerChickenFact(
            title: "Social Hierarchy",
            shortDescription: "Chickens have a pecking order",
            fullDescription: "Chickens establish a strict social hierarchy called the 'pecking order.' Each chicken knows its place in the flock, and this order determines who gets to eat first, where they can roost, and even who they can mate with. The hierarchy is maintained through subtle body language and occasional pecks.",
            emoji: "👑"
        ),
        HatchCoopClickerChickenFact(
            title: "Dreaming Chickens",
            shortDescription: "Chickens experience REM sleep",
            fullDescription: "Chickens, like humans, experience REM (Rapid Eye Movement) sleep, which means they likely dream! During REM sleep, their eyes move rapidly under closed eyelids, and their brain activity increases. This suggests they process memories and experiences during sleep, just like we do.",
            emoji: "💤"
        ),
        HatchCoopClickerChickenFact(
            title: "Communication",
            shortDescription: "Chickens have over 30 vocalizations",
            fullDescription: "Chickens are highly communicative animals with over 30 different vocalizations. They have specific calls for danger, food discovery, mating, and even different sounds for different types of predators. Mother hens also communicate with their chicks while they're still in the egg!",
            emoji: "🗣️"
        ),
        HatchCoopClickerChickenFact(
            title: "Temperature Control",
            shortDescription: "Chickens can't sweat",
            fullDescription: "Unlike humans, chickens can't sweat to cool down. Instead, they regulate their body temperature by panting, spreading their wings, and seeking shade. Their normal body temperature is around 105°F (40.5°C), which is higher than humans. They're most comfortable between 65-75°F (18-24°C).",
            emoji: "🌡️"
        ),
        HatchCoopClickerChickenFact(
            title: "Egg Development",
            shortDescription: "It takes 21 days to hatch an egg",
            fullDescription: "A fertilized chicken egg takes exactly 21 days to hatch under ideal conditions. The mother hen turns the eggs regularly to ensure even development and maintains a constant temperature of 99.5°F (37.5°C). During this time, the chick develops all its organs, feathers, and even starts making sounds inside the egg!",
            emoji: "🐣"
        ),
        HatchCoopClickerChickenFact(
            title: "Feather Colors",
            shortDescription: "Chicken feathers come in many colors",
            fullDescription: "Chickens can have feathers in almost any color combination: white, black, red, brown, gold, silver, blue, and even green! The color is determined by genetics and can be influenced by diet. Some breeds, like the Araucana, even lay blue or green eggs due to a pigment called biliverdin.",
            emoji: "🌈"
        ),
        HatchCoopClickerChickenFact(
            title: "Life Span",
            shortDescription: "Chickens can live 5-10 years",
            fullDescription: "The average lifespan of a chicken is 5-10 years, though some have been known to live up to 20 years! Factors affecting lifespan include breed, diet, living conditions, and whether they're kept for egg production or as pets. Heritage breeds tend to live longer than commercial laying hens.",
            emoji: "⏰"
        )
    ]
    
    private lazy var HatchCoopClickerFactsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: 160, height: 180)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(red: 1.0, green: 0.95, blue: 0.88, alpha: 1.0)
        collectionView.register(HatchCoopClickerFactCell.self, forCellWithReuseIdentifier: "HatchCoopClickerFactCell")
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
        title = "🐔 Hatchery"
        
        view.addSubview(HatchCoopClickerFactsCollectionView)
        
        NSLayoutConstraint.activate([
            HatchCoopClickerFactsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            HatchCoopClickerFactsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            HatchCoopClickerFactsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            HatchCoopClickerFactsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func HatchCoopClickerSetupViewModel() {
        HatchCoopClickerViewModel = HatchCoopClickerHatcheryViewModel()
        HatchCoopClickerViewModel.HatchCoopClickerOnDataUpdated = { [weak self] in
            self?.HatchCoopClickerUpdateUI()
        }
        HatchCoopClickerViewModel.HatchCoopClickerUpdateData()
    }
    
    private func HatchCoopClickerUpdateUI() {
        // Update UI if needed
    }
}

extension HatchCoopClickerHatcheryVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HatchCoopClickerChickenFacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HatchCoopClickerFactCell", for: indexPath) as! HatchCoopClickerFactCell
        let fact = HatchCoopClickerChickenFacts[indexPath.item]
        cell.HatchCoopClickerConfigure(with: fact)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fact = HatchCoopClickerChickenFacts[indexPath.item]
        let detailVC = HatchCoopClickerFactDetailVC()
        detailVC.HatchCoopClickerFact = fact
        navigationController?.pushViewController(detailVC, animated: true)
    }
} 