import Foundation

struct HatchCoopClickerGame: Codable {
    let HatchCoopClickerId: String
    let HatchCoopClickerName: String
    let HatchCoopClickerEmoji: String
    let HatchCoopClickerDescription: String
}

class HatchCoopClickerFeedPuzzlesViewModel {
    
    private let HatchCoopClickerSharedGameData = HatchCoopClickerGameData.HatchCoopClickerShared
    
    var HatchCoopClickerOnDataUpdated: (() -> Void)?
    
    var HatchCoopClickerRanchCoins: Int {
        return HatchCoopClickerSharedGameData.HatchCoopClickerRanchCoins
    }
    
    var HatchCoopClickerXP: Int {
        return HatchCoopClickerSharedGameData.HatchCoopClickerXP
    }
    
    var HatchCoopClickerCurrentLevel: Int {
        return HatchCoopClickerXP / 100 + 1
    }
    
    var HatchCoopClickerXPProgress: Double {
        let HatchCoopClickerXPForCurrentLevel = (HatchCoopClickerCurrentLevel - 1) * 100
        let HatchCoopClickerXPInCurrentLevel = HatchCoopClickerXP - HatchCoopClickerXPForCurrentLevel
        return Double(HatchCoopClickerXPInCurrentLevel) / 100.0
    }
    
    var HatchCoopClickerFeedStock: Int {
        return HatchCoopClickerSharedGameData.HatchCoopClickerFeedStock
    }
    
    var HatchCoopClickerChickensOwned: Int {
        return HatchCoopClickerSharedGameData.HatchCoopClickerChickensOwned
    }
    
    var HatchCoopClickerGames: [HatchCoopClickerGame] {
        return [
            HatchCoopClickerGame(HatchCoopClickerId: "wordGame", HatchCoopClickerName: "Word Builder", HatchCoopClickerEmoji: "📝", HatchCoopClickerDescription: "Create words from letters"),
            HatchCoopClickerGame(HatchCoopClickerId: "drawingGame", HatchCoopClickerName: "Drawing Canvas", HatchCoopClickerEmoji: "🎨", HatchCoopClickerDescription: "Draw and create art"),
            HatchCoopClickerGame(HatchCoopClickerId: "tictactoeGame", HatchCoopClickerName: "Tic Tac Toe", HatchCoopClickerEmoji: "⭕", HatchCoopClickerDescription: "Classic X's and O's"),
            HatchCoopClickerGame(HatchCoopClickerId: "minesweeperGame", HatchCoopClickerName: "Minesweeper", HatchCoopClickerEmoji: "💣", HatchCoopClickerDescription: "Find hidden mines")
        ]
    }
    
    func HatchCoopClickerUpdateData() {
        HatchCoopClickerOnDataUpdated?()
    }
    
    func HatchCoopClickerAddRewards(coins: Int, xp: Int) {
        HatchCoopClickerSharedGameData.HatchCoopClickerRanchCoins += coins
        HatchCoopClickerSharedGameData.HatchCoopClickerTotalCoinsEarned += coins
        HatchCoopClickerSharedGameData.HatchCoopClickerXP += xp
        HatchCoopClickerSharedGameData.HatchCoopClickerUpdateMaxLevel()
        HatchCoopClickerSharedGameData.HatchCoopClickerTotalPuzzlesSolved += 1
        
        // Update achievements
        let achievementsViewModel = HatchCoopClickerAchievementsViewModel()
        achievementsViewModel.HatchCoopClickerUpdateData()
        
        HatchCoopClickerOnDataUpdated?()
    }
    
    func HatchCoopClickerBuyChicken() {
        HatchCoopClickerSharedGameData.HatchCoopClickerChickensOwned += 1
        HatchCoopClickerSharedGameData.HatchCoopClickerMapChickensBought += 1
        
        // Update achievements
        let achievementsViewModel = HatchCoopClickerAchievementsViewModel()
        achievementsViewModel.HatchCoopClickerUpdateData()
        
        HatchCoopClickerOnDataUpdated?()
    }
} 