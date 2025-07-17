import UIKit
import MapKit

class HatchCoopClickerFeedPuzzlesVC: UIViewController {
    
    private let HatchCoopClickerSharedGameData = HatchCoopClickerGameData.HatchCoopClickerShared
    private var HatchCoopClickerViewModel: HatchCoopClickerFeedPuzzlesViewModel!
    

    private var HatchCoopClickerMapView: MKMapView!
    private var HatchCoopClickerChickenAnnotations: [MKPointAnnotation] = []
    private var HatchCoopClickerSpawnTimer: Timer?
    
    private let HatchCoopClickerCityCenter = CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060)
    private let HatchCoopClickerSpawnRadius: Double = 0.01 
    
    private lazy var HatchCoopClickerStatsCard: UIView = {
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
    
    private lazy var HatchCoopClickerChickensOwnedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerPassiveIncomeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 1.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerCoinsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(red: 1.0, green: 0.84, blue: 0.31, alpha: 1.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HatchCoopClickerSetupUI()
        HatchCoopClickerSetupViewModel()
        HatchCoopClickerSetupMap()
        HatchCoopClickerStartSpawning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        HatchCoopClickerViewModel.HatchCoopClickerUpdateData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        HatchCoopClickerSpawnTimer?.invalidate()
        HatchCoopClickerSpawnTimer = nil
    }
    
    private func HatchCoopClickerSetupUI() {
        view.backgroundColor = UIColor(red: 1.0, green: 0.95, blue: 0.88, alpha: 1.0)
        title = "🗺️ Chicken Map"
        
        // Setup map view
        HatchCoopClickerMapView = MKMapView()
        HatchCoopClickerMapView.delegate = self
        HatchCoopClickerMapView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(HatchCoopClickerMapView)
        view.addSubview(HatchCoopClickerStatsCard)
        
        HatchCoopClickerStatsCard.addSubview(HatchCoopClickerChickensOwnedLabel)
        HatchCoopClickerStatsCard.addSubview(HatchCoopClickerPassiveIncomeLabel)
        HatchCoopClickerStatsCard.addSubview(HatchCoopClickerCoinsLabel)
        
        NSLayoutConstraint.activate([
            HatchCoopClickerMapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            HatchCoopClickerMapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            HatchCoopClickerMapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            HatchCoopClickerMapView.bottomAnchor.constraint(equalTo: HatchCoopClickerStatsCard.topAnchor, constant: -20),
            
            HatchCoopClickerStatsCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            HatchCoopClickerStatsCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            HatchCoopClickerStatsCard.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            HatchCoopClickerStatsCard.heightAnchor.constraint(equalToConstant: 100),
            
            HatchCoopClickerChickensOwnedLabel.topAnchor.constraint(equalTo: HatchCoopClickerStatsCard.topAnchor, constant: 15),
            HatchCoopClickerChickensOwnedLabel.leadingAnchor.constraint(equalTo: HatchCoopClickerStatsCard.leadingAnchor, constant: 20),
            HatchCoopClickerChickensOwnedLabel.trailingAnchor.constraint(equalTo: HatchCoopClickerStatsCard.trailingAnchor, constant: -20),
            
            HatchCoopClickerPassiveIncomeLabel.topAnchor.constraint(equalTo: HatchCoopClickerChickensOwnedLabel.bottomAnchor, constant: 8),
            HatchCoopClickerPassiveIncomeLabel.leadingAnchor.constraint(equalTo: HatchCoopClickerStatsCard.leadingAnchor, constant: 20),
            HatchCoopClickerPassiveIncomeLabel.trailingAnchor.constraint(equalTo: HatchCoopClickerStatsCard.trailingAnchor, constant: -20),
            
            HatchCoopClickerCoinsLabel.topAnchor.constraint(equalTo: HatchCoopClickerPassiveIncomeLabel.bottomAnchor, constant: 8),
            HatchCoopClickerCoinsLabel.leadingAnchor.constraint(equalTo: HatchCoopClickerStatsCard.leadingAnchor, constant: 20),
            HatchCoopClickerCoinsLabel.trailingAnchor.constraint(equalTo: HatchCoopClickerStatsCard.trailingAnchor, constant: -20)
        ])
    }
    
    private func HatchCoopClickerSetupMap() {
        // Set initial region to New York City
        let region = MKCoordinateRegion(
            center: HatchCoopClickerCityCenter,
            latitudinalMeters: 2000,
            longitudinalMeters: 2000
        )
        HatchCoopClickerMapView.setRegion(region, animated: false)
        
        // Add tap gesture to map
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(HatchCoopClickerMapTapped(_:)))
        HatchCoopClickerMapView.addGestureRecognizer(tapGesture)
    }
    
    private func HatchCoopClickerStartSpawning() {
        // Spawn initial chickens
        HatchCoopClickerSpawnChickens()
        
        // Set up timer for spawning every 5 seconds
        HatchCoopClickerSpawnTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
            self?.HatchCoopClickerSpawnChickens()
        }
    }
    
    private func HatchCoopClickerSpawnChickens() {
        // Remove old annotations
        HatchCoopClickerMapView.removeAnnotations(HatchCoopClickerChickenAnnotations)
        HatchCoopClickerChickenAnnotations.removeAll()
        
        // Spawn 3-6 new chickens
        let chickenCount = Int.random(in: 3...6)
        
        for _ in 0..<chickenCount {
            let annotation = MKPointAnnotation()
            
            // Generate random coordinates within spawn radius
            let randomLat = HatchCoopClickerCityCenter.latitude + Double.random(in: -HatchCoopClickerSpawnRadius...HatchCoopClickerSpawnRadius)
            let randomLon = HatchCoopClickerCityCenter.longitude + Double.random(in: -HatchCoopClickerSpawnRadius...HatchCoopClickerSpawnRadius)
            
            annotation.coordinate = CLLocationCoordinate2D(latitude: randomLat, longitude: randomLon)
            annotation.title = "🐔 Chicken for Sale"
            annotation.subtitle = "Tap to buy for 50 coins"
            
            HatchCoopClickerChickenAnnotations.append(annotation)
        }
        
        HatchCoopClickerMapView.addAnnotations(HatchCoopClickerChickenAnnotations)
    }
    
    @objc private func HatchCoopClickerMapTapped(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: HatchCoopClickerMapView)
        let coordinate = HatchCoopClickerMapView.convert(point, toCoordinateFrom: HatchCoopClickerMapView)
        
        // Check if tap is near any chicken annotation
        for annotation in HatchCoopClickerChickenAnnotations {
            let annotationPoint = HatchCoopClickerMapView.convert(annotation.coordinate, toPointTo: HatchCoopClickerMapView)
            let distance = sqrt(pow(point.x - annotationPoint.x, 2) + pow(point.y - annotationPoint.y, 2))
            
            if distance < 50 { // 50 points radius for tap detection
                HatchCoopClickerTryBuyChicken()
                break
            }
        }
    }
    
    private func HatchCoopClickerTryBuyChicken() {
        let chickenCost = 50
        let currentCoins = HatchCoopClickerViewModel.HatchCoopClickerRanchCoins
        
        if currentCoins >= chickenCost {
            // Success - buy chicken
            HatchCoopClickerViewModel.HatchCoopClickerAddRewards(coins: -chickenCost, xp: 0)
            HatchCoopClickerViewModel.HatchCoopClickerBuyChicken()
            HatchCoopClickerShowSuccessAlert()
        } else {
            // Not enough coins
            HatchCoopClickerShowInsufficientFundsAlert()
        }
    }
    
    private func HatchCoopClickerShowSuccessAlert() {
        let alertVC = HatchCoopClickerPurchaseAlertVC()
        alertVC.HatchCoopClickerIsSuccess = true
        alertVC.HatchCoopClickerMessage = "Chicken purchased successfully! 🐔\nYour passive income has increased."
        alertVC.modalPresentationStyle = .overFullScreen
        present(alertVC, animated: true)
    }
    
    private func HatchCoopClickerShowInsufficientFundsAlert() {
        let alertVC = HatchCoopClickerPurchaseAlertVC()
        alertVC.HatchCoopClickerIsSuccess = false
        alertVC.HatchCoopClickerMessage = "Not enough coins! 💰\nYou need 50 coins to buy a chicken.\nCurrent balance: \(HatchCoopClickerViewModel.HatchCoopClickerRanchCoins) coins"
        alertVC.modalPresentationStyle = .overFullScreen
        present(alertVC, animated: true)
    }
    
    private func HatchCoopClickerSetupViewModel() {
        HatchCoopClickerViewModel = HatchCoopClickerFeedPuzzlesViewModel()
        HatchCoopClickerViewModel.HatchCoopClickerOnDataUpdated = { [weak self] in
            self?.HatchCoopClickerUpdateUI()
        }
        HatchCoopClickerViewModel.HatchCoopClickerUpdateData()
    }
    
    private func HatchCoopClickerUpdateUI() {
        let chickensOwned = HatchCoopClickerViewModel.HatchCoopClickerChickensOwned
        let passiveIncome = chickensOwned * 2 // 2 coins per chicken per minute
        let currentCoins = HatchCoopClickerViewModel.HatchCoopClickerRanchCoins
        
        HatchCoopClickerChickensOwnedLabel.text = "🐔 Chickens Owned: \(chickensOwned)"
        HatchCoopClickerPassiveIncomeLabel.text = "💰 Passive Income: \(passiveIncome) coins/min"
        HatchCoopClickerCoinsLabel.text = "💎 Current Balance: \(currentCoins) coins"
    }
}

extension HatchCoopClickerFeedPuzzlesVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else { return nil }
        
        let identifier = "ChickenAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        // Set custom chicken emoji as annotation
        annotationView?.image = HatchCoopClickerCreateChickenAnnotationImage()
        
        return annotationView
    }
    
    private func HatchCoopClickerCreateChickenAnnotationImage() -> UIImage? {
        let size = CGSize(width: 40, height: 40)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor(red: 1.0, green: 0.98, blue: 0.95, alpha: 1.0).cgColor)
        context?.fillEllipse(in: CGRect(origin: .zero, size: size))
        
        let emoji = "🐔"
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 24)
        ]
        
        let emojiSize = emoji.size(withAttributes: attributes)
        let emojiRect = CGRect(
            x: (size.width - emojiSize.width) / 2,
            y: (size.height - emojiSize.height) / 2,
            width: emojiSize.width,
            height: emojiSize.height
        )
        
        emoji.draw(in: emojiRect, withAttributes: attributes)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
} 
