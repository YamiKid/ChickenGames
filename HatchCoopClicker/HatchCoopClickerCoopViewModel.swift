import Foundation

class HatchCoopClickerCoopViewModel {
    
    private let HatchCoopClickerSharedGameData = HatchCoopClickerGameData.HatchCoopClickerShared
    
    var HatchCoopClickerOnDataUpdated: (() -> Void)?
    
    var HatchCoopClickerRanchCoins: Int {
        return HatchCoopClickerSharedGameData.HatchCoopClickerRanchCoins
    }
    
    var HatchCoopClickerXP: Int {
        return HatchCoopClickerSharedGameData.HatchCoopClickerXP
    }
    
    var HatchCoopClickerXPProgress: Double {
        let HatchCoopClickerCurrentLevel = HatchCoopClickerXP / 100
        let HatchCoopClickerXPForCurrentLevel = HatchCoopClickerCurrentLevel * 100
        let HatchCoopClickerXPInCurrentLevel = HatchCoopClickerXP - HatchCoopClickerXPForCurrentLevel
        return Double(HatchCoopClickerXPInCurrentLevel) / 100.0
    }
    
    var HatchCoopClickerChickens: [HatchCoopClickerChicken] {
        return HatchCoopClickerSharedGameData.HatchCoopClickerUnlockedChickens
    }
    
    var HatchCoopClickerUpgradeCost: Int {
        return HatchCoopClickerSharedGameData.HatchCoopClickerCoopLevel * 50
    }
    
    func HatchCoopClickerUpdateData() {
        
        let achievementsViewModel = HatchCoopClickerAchievementsViewModel()
        achievementsViewModel.HatchCoopClickerUpdateData()
        
        HatchCoopClickerOnDataUpdated?()
    }
    
    func HatchCoopClickerUpgradeCoop() {
        let HatchCoopClickerCost = HatchCoopClickerUpgradeCost
        if HatchCoopClickerSharedGameData.HatchCoopClickerRanchCoins >= HatchCoopClickerCost {
            HatchCoopClickerSharedGameData.HatchCoopClickerRanchCoins -= HatchCoopClickerCost
            HatchCoopClickerSharedGameData.HatchCoopClickerCoopLevel += 1
            HatchCoopClickerSharedGameData.HatchCoopClickerXP += 25
            HatchCoopClickerSharedGameData.HatchCoopClickerTotalCoinsEarned += HatchCoopClickerCost
            

            let achievementsViewModel = HatchCoopClickerAchievementsViewModel()
            achievementsViewModel.HatchCoopClickerUpdateData()
            
            HatchCoopClickerOnDataUpdated?()
        }
    }
} 
