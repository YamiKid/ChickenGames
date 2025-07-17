import Foundation

class HatchCoopClickerHatcheryViewModel {
    
    private let HatchCoopClickerSharedGameData = HatchCoopClickerGameData.HatchCoopClickerShared
    
    var HatchCoopClickerOnDataUpdated: (() -> Void)?
    
    private var HatchCoopClickerHatchProgress: Double = 0.0
    
    var HatchCoopClickerEggCount: Int {
        return HatchCoopClickerSharedGameData.HatchCoopClickerEggCount
    }
    
    var HatchCoopClickerProgress: Double {
        return HatchCoopClickerHatchProgress
    }
    
    var HatchCoopClickerHatchCost: Int {
        return 10
    }
    
    var HatchCoopClickerCanHatch: Bool {
        return HatchCoopClickerSharedGameData.HatchCoopClickerEggCount >= HatchCoopClickerHatchCost
    }
    
    private let HatchCoopClickerAvailableChickens = [
        HatchCoopClickerChicken(HatchCoopClickerId: "rhodeIslandRed", HatchCoopClickerName: "Rhode Island Red", HatchCoopClickerEmoji: "🐔", HatchCoopClickerRarity: "Common", HatchCoopClickerCost: 10),
        HatchCoopClickerChicken(HatchCoopClickerId: "silkie", HatchCoopClickerName: "Silkie", HatchCoopClickerEmoji: "🐤", HatchCoopClickerRarity: "Uncommon", HatchCoopClickerCost: 25),
        HatchCoopClickerChicken(HatchCoopClickerId: "leghorn", HatchCoopClickerName: "Leghorn", HatchCoopClickerEmoji: "🐓", HatchCoopClickerRarity: "Rare", HatchCoopClickerCost: 50),
        HatchCoopClickerChicken(HatchCoopClickerId: "golden", HatchCoopClickerName: "Golden Chicken", HatchCoopClickerEmoji: "🐥", HatchCoopClickerRarity: "Epic", HatchCoopClickerCost: 100),
        HatchCoopClickerChicken(HatchCoopClickerId: "rainbow", HatchCoopClickerName: "Rainbow Chicken", HatchCoopClickerEmoji: "🦚", HatchCoopClickerRarity: "Legendary", HatchCoopClickerCost: 250)
    ]
    
    func HatchCoopClickerUpdateData() {
        // Update achievements
        let achievementsViewModel = HatchCoopClickerAchievementsViewModel()
        achievementsViewModel.HatchCoopClickerUpdateData()
        
        HatchCoopClickerOnDataUpdated?()
    }
    
    func HatchCoopClickerTapEgg() {
        HatchCoopClickerSharedGameData.HatchCoopClickerEggCount += 1
        HatchCoopClickerSharedGameData.HatchCoopClickerTotalEggsCollected += 1
        HatchCoopClickerSharedGameData.HatchCoopClickerXP += 1
        HatchCoopClickerSharedGameData.HatchCoopClickerUpdateMaxLevel()
        HatchCoopClickerHatchProgress += 0.05
        
        if HatchCoopClickerHatchProgress >= 1.0 {
            HatchCoopClickerHatchProgress = 1.0
        }
        
        // Update achievements
        let achievementsViewModel = HatchCoopClickerAchievementsViewModel()
        achievementsViewModel.HatchCoopClickerUpdateData()
        
        HatchCoopClickerOnDataUpdated?()
    }
    
    func HatchCoopClickerHatchChicken() {
        guard HatchCoopClickerCanHatch else { return }
        
        HatchCoopClickerSharedGameData.HatchCoopClickerEggCount -= HatchCoopClickerHatchCost
        HatchCoopClickerSharedGameData.HatchCoopClickerRanchCoins += 5
        HatchCoopClickerSharedGameData.HatchCoopClickerTotalCoinsEarned += 5
        HatchCoopClickerSharedGameData.HatchCoopClickerXP += 10
        HatchCoopClickerSharedGameData.HatchCoopClickerUpdateMaxLevel()
        HatchCoopClickerSharedGameData.HatchCoopClickerTotalChickensHatched += 1
        HatchCoopClickerSharedGameData.HatchCoopClickerChickensOwned += 1
        
        let HatchCoopClickerRandomChicken = HatchCoopClickerAvailableChickens.randomElement()!
        var HatchCoopClickerCurrentChickens = HatchCoopClickerSharedGameData.HatchCoopClickerUnlockedChickens
        
        if !HatchCoopClickerCurrentChickens.contains(where: { $0.HatchCoopClickerId == HatchCoopClickerRandomChicken.HatchCoopClickerId }) {
            HatchCoopClickerCurrentChickens.append(HatchCoopClickerRandomChicken)
            HatchCoopClickerSharedGameData.HatchCoopClickerUnlockedChickens = HatchCoopClickerCurrentChickens
        }
        
        HatchCoopClickerHatchProgress = 0.0
        
        // Update achievements
        let achievementsViewModel = HatchCoopClickerAchievementsViewModel()
        achievementsViewModel.HatchCoopClickerUpdateData()
        
        HatchCoopClickerOnDataUpdated?()
    }
} 