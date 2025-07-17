import UIKit

class HatchCoopClickerTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HatchCoopClickerSetupTabs()
        HatchCoopClickerConfigureAppearance()
    }
    
    private func HatchCoopClickerSetupTabs() {
        let HatchCoopClickerCoopVC = HatchCoopClickerCoopVC()
        let HatchCoopClickerCoopNav = UINavigationController(rootViewController: HatchCoopClickerCoopVC)
        HatchCoopClickerCoopNav.tabBarItem = UITabBarItem(title: "Coop", image: UIImage(systemName: "house.fill"), tag: 0)
        
        let HatchCoopClickerHatcheryVC = HatchCoopClickerHatcheryVC()
        let HatchCoopClickerHatcheryNav = UINavigationController(rootViewController: HatchCoopClickerHatcheryVC)
        HatchCoopClickerHatcheryNav.tabBarItem = UITabBarItem(title: "Hatchery", image: UIImage(systemName: "bird.fill"), tag: 1)
        
        let HatchCoopClickerFeedPuzzlesVC = HatchCoopClickerFeedPuzzlesVC()
        let HatchCoopClickerFeedPuzzlesNav = UINavigationController(rootViewController: HatchCoopClickerFeedPuzzlesVC)
        HatchCoopClickerFeedPuzzlesNav.tabBarItem = UITabBarItem(title: "Chicken Map", image: UIImage(systemName: "map.fill"), tag: 2)
        
        let HatchCoopClickerAchievementsVC = HatchCoopClickerAchievementsVC()
        let HatchCoopClickerAchievementsNav = UINavigationController(rootViewController: HatchCoopClickerAchievementsVC)
        HatchCoopClickerAchievementsNav.tabBarItem = UITabBarItem(title: "Achievements", image: UIImage(systemName: "trophy.fill"), tag: 3)
        
        let HatchCoopClickerSettingsVC = HatchCoopClickerSettingsVC()
        let HatchCoopClickerSettingsNav = UINavigationController(rootViewController: HatchCoopClickerSettingsVC)
        HatchCoopClickerSettingsNav.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape.fill"), tag: 4)
        
        viewControllers = [HatchCoopClickerCoopNav, HatchCoopClickerHatcheryNav, HatchCoopClickerFeedPuzzlesNav, HatchCoopClickerAchievementsNav, HatchCoopClickerSettingsNav]
    }
    
    private func HatchCoopClickerConfigureAppearance() {
        tabBar.tintColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0)
        tabBar.backgroundColor = UIColor(red: 1.0, green: 0.95, blue: 0.88, alpha: 1.0)
        tabBar.unselectedItemTintColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Ensure tab bar is visible and interactive
        tabBar.isHidden = false
        tabBar.isUserInteractionEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Ensure tab bar is visible and interactive
        tabBar.isHidden = false
        tabBar.isUserInteractionEnabled = true
    }
} 