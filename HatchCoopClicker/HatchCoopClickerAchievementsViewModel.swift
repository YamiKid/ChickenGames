import Foundation

class HatchCoopClickerAchievementsViewModel {
    
    private let HatchCoopClickerSharedGameData = HatchCoopClickerGameData.HatchCoopClickerShared
    
    var HatchCoopClickerOnDataUpdated: (() -> Void)?
    
    var HatchCoopClickerAchievements: [HatchCoopClickerAchievement] {
        return HatchCoopClickerSharedGameData.HatchCoopClickerAchievements
    }
    
    func HatchCoopClickerUpdateData() {
        HatchCoopClickerCheckAchievements()
        HatchCoopClickerOnDataUpdated?()
    }
    
    private func HatchCoopClickerCheckAchievements() {
        var HatchCoopClickerCurrentAchievements = HatchCoopClickerSharedGameData.HatchCoopClickerAchievements
        var HatchCoopClickerAchievementsUpdated = false
        
        for (HatchCoopClickerIndex, achievement) in HatchCoopClickerCurrentAchievements.enumerated() {
            if !achievement.HatchCoopClickerIsUnlocked {
                let HatchCoopClickerShouldUnlock = HatchCoopClickerCheckAchievementCondition(achievement: achievement)
                if HatchCoopClickerShouldUnlock {
                    HatchCoopClickerCurrentAchievements[HatchCoopClickerIndex].HatchCoopClickerIsUnlocked = true
                    HatchCoopClickerAchievementsUpdated = true
                }
            }
        }
        
        if HatchCoopClickerAchievementsUpdated {
            HatchCoopClickerSharedGameData.HatchCoopClickerAchievements = HatchCoopClickerCurrentAchievements
        }
    }
    
    private func HatchCoopClickerCheckAchievementCondition(achievement: HatchCoopClickerAchievement) -> Bool {
        switch achievement.HatchCoopClickerType {
        case "eggs":
            return HatchCoopClickerSharedGameData.HatchCoopClickerTotalEggsCollected >= achievement.HatchCoopClickerRequirement
        case "chickens":
            return HatchCoopClickerSharedGameData.HatchCoopClickerChickensOwned >= achievement.HatchCoopClickerRequirement
        case "puzzles":
            return HatchCoopClickerSharedGameData.HatchCoopClickerTotalPuzzlesSolved >= achievement.HatchCoopClickerRequirement
        case "coins":
            return HatchCoopClickerSharedGameData.HatchCoopClickerTotalCoinsEarned >= achievement.HatchCoopClickerRequirement
        case "quizzes":
            return HatchCoopClickerSharedGameData.HatchCoopClickerTotalQuizzesCompleted >= achievement.HatchCoopClickerRequirement
        case "level":
            return HatchCoopClickerSharedGameData.HatchCoopClickerMaxLevelReached >= achievement.HatchCoopClickerRequirement
        case "wordBuilder":
            return HatchCoopClickerSharedGameData.HatchCoopClickerWordBuilderGamesPlayed >= achievement.HatchCoopClickerRequirement
        case "ticTacToe":
            return HatchCoopClickerSharedGameData.HatchCoopClickerTicTacToeGamesPlayed >= achievement.HatchCoopClickerRequirement
        case "minesweeper":
            return HatchCoopClickerSharedGameData.HatchCoopClickerMinesweeperGamesPlayed >= achievement.HatchCoopClickerRequirement
        case "mapChickens":
            return HatchCoopClickerSharedGameData.HatchCoopClickerMapChickensBought >= achievement.HatchCoopClickerRequirement
        default:
            return false
        }
    }
} 