import Foundation

struct HatchCoopClickerChicken: Codable {
    let HatchCoopClickerId: String
    let HatchCoopClickerName: String
    let HatchCoopClickerEmoji: String
    let HatchCoopClickerRarity: String
    let HatchCoopClickerCost: Int
}

struct HatchCoopClickerPuzzle: Codable {
    let HatchCoopClickerId: String
    let HatchCoopClickerName: String
    let HatchCoopClickerEmoji: String
    let HatchCoopClickerDifficulty: Int
    let HatchCoopClickerReward: Int
    var HatchCoopClickerIsCompleted: Bool
}

struct HatchCoopClickerAchievement: Codable {
    let HatchCoopClickerId: String
    let HatchCoopClickerName: String
    let HatchCoopClickerDescription: String
    let HatchCoopClickerEmoji: String
    let HatchCoopClickerRequirement: Int
    var HatchCoopClickerIsUnlocked: Bool
    let HatchCoopClickerFarmBotQuip: String
    let HatchCoopClickerType: String // "eggs", "chickens", "puzzles", "coins", "quizzes", "level"
}

class HatchCoopClickerGameData {
    static let HatchCoopClickerShared = HatchCoopClickerGameData()
    
    private let HatchCoopClickerUserDefaults = UserDefaults.standard
    
    var HatchCoopClickerRanchCoins: Int {
        get { HatchCoopClickerUserDefaults.integer(forKey: "HatchCoopClickerRanchCoins") }
        set { HatchCoopClickerUserDefaults.set(newValue, forKey: "HatchCoopClickerRanchCoins") }
    }
    
    var HatchCoopClickerEggCount: Int {
        get { HatchCoopClickerUserDefaults.integer(forKey: "HatchCoopClickerEggCount") }
        set { HatchCoopClickerUserDefaults.set(newValue, forKey: "HatchCoopClickerEggCount") }
    }
    
    var HatchCoopClickerXP: Int {
        get { HatchCoopClickerUserDefaults.integer(forKey: "HatchCoopClickerXP") }
        set { HatchCoopClickerUserDefaults.set(newValue, forKey: "HatchCoopClickerXP") }
    }
    
    var HatchCoopClickerFeedStock: Int {
        get { HatchCoopClickerUserDefaults.integer(forKey: "HatchCoopClickerFeedStock") }
        set { HatchCoopClickerUserDefaults.set(newValue, forKey: "HatchCoopClickerFeedStock") }
    }
    
    var HatchCoopClickerChickensOwned: Int {
        get { HatchCoopClickerUserDefaults.integer(forKey: "HatchCoopClickerChickensOwned") }
        set { HatchCoopClickerUserDefaults.set(newValue, forKey: "HatchCoopClickerChickensOwned") }
    }
    
    // Achievement progress tracking
    var HatchCoopClickerTotalEggsCollected: Int {
        get { HatchCoopClickerUserDefaults.integer(forKey: "HatchCoopClickerTotalEggsCollected") }
        set { HatchCoopClickerUserDefaults.set(newValue, forKey: "HatchCoopClickerTotalEggsCollected") }
    }
    
    var HatchCoopClickerTotalChickensHatched: Int {
        get { HatchCoopClickerUserDefaults.integer(forKey: "HatchCoopClickerTotalChickensHatched") }
        set { HatchCoopClickerUserDefaults.set(newValue, forKey: "HatchCoopClickerTotalChickensHatched") }
    }
    
    var HatchCoopClickerTotalPuzzlesSolved: Int {
        get { HatchCoopClickerUserDefaults.integer(forKey: "HatchCoopClickerTotalPuzzlesSolved") }
        set { HatchCoopClickerUserDefaults.set(newValue, forKey: "HatchCoopClickerTotalPuzzlesSolved") }
    }
    
    var HatchCoopClickerTotalCoinsEarned: Int {
        get { HatchCoopClickerUserDefaults.integer(forKey: "HatchCoopClickerTotalCoinsEarned") }
        set { HatchCoopClickerUserDefaults.set(newValue, forKey: "HatchCoopClickerTotalCoinsEarned") }
    }
    
    var HatchCoopClickerTotalQuizzesCompleted: Int {
        get { HatchCoopClickerUserDefaults.integer(forKey: "HatchCoopClickerTotalQuizzesCompleted") }
        set { HatchCoopClickerUserDefaults.set(newValue, forKey: "HatchCoopClickerTotalQuizzesCompleted") }
    }
    
    var HatchCoopClickerMaxLevelReached: Int {
        get { HatchCoopClickerUserDefaults.integer(forKey: "HatchCoopClickerMaxLevelReached") }
        set { HatchCoopClickerUserDefaults.set(newValue, forKey: "HatchCoopClickerMaxLevelReached") }
    }
    
    // New achievement counters
    var HatchCoopClickerWordBuilderGamesPlayed: Int {
        get { HatchCoopClickerUserDefaults.integer(forKey: "HatchCoopClickerWordBuilderGamesPlayed") }
        set { HatchCoopClickerUserDefaults.set(newValue, forKey: "HatchCoopClickerWordBuilderGamesPlayed") }
    }
    
    var HatchCoopClickerTicTacToeGamesPlayed: Int {
        get { HatchCoopClickerUserDefaults.integer(forKey: "HatchCoopClickerTicTacToeGamesPlayed") }
        set { HatchCoopClickerUserDefaults.set(newValue, forKey: "HatchCoopClickerTicTacToeGamesPlayed") }
    }
    
    var HatchCoopClickerMinesweeperGamesPlayed: Int {
        get { HatchCoopClickerUserDefaults.integer(forKey: "HatchCoopClickerMinesweeperGamesPlayed") }
        set { HatchCoopClickerUserDefaults.set(newValue, forKey: "HatchCoopClickerMinesweeperGamesPlayed") }
    }
    
    var HatchCoopClickerMapChickensBought: Int {
        get { HatchCoopClickerUserDefaults.integer(forKey: "HatchCoopClickerMapChickensBought") }
        set { HatchCoopClickerUserDefaults.set(newValue, forKey: "HatchCoopClickerMapChickensBought") }
    }
    
    func HatchCoopClickerUpdateMaxLevel() {
        let currentLevel = HatchCoopClickerXP / 100 + 1
        if currentLevel > HatchCoopClickerMaxLevelReached {
            HatchCoopClickerMaxLevelReached = currentLevel
        }
    }
    
    var HatchCoopClickerCoopLevel: Int {
        get { HatchCoopClickerUserDefaults.integer(forKey: "HatchCoopClickerCoopLevel") }
        set { HatchCoopClickerUserDefaults.set(newValue, forKey: "HatchCoopClickerCoopLevel") }
    }
    
    var HatchCoopClickerUnlockedChickens: [HatchCoopClickerChicken] {
        get {
            guard let data = HatchCoopClickerUserDefaults.data(forKey: "HatchCoopClickerUnlockedChickens"),
                  let chickens = try? JSONDecoder().decode([HatchCoopClickerChicken].self, from: data) else {
                return []
            }
            return chickens
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                HatchCoopClickerUserDefaults.set(data, forKey: "HatchCoopClickerUnlockedChickens")
            }
        }
    }
    
    var HatchCoopClickerPuzzles: [HatchCoopClickerPuzzle] {
        get {
            guard let data = HatchCoopClickerUserDefaults.data(forKey: "HatchCoopClickerPuzzles"),
                  let puzzles = try? JSONDecoder().decode([HatchCoopClickerPuzzle].self, from: data) else {
                return HatchCoopClickerDefaultPuzzles()
            }
            return puzzles
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                HatchCoopClickerUserDefaults.set(data, forKey: "HatchCoopClickerPuzzles")
            }
        }
    }
    
    var HatchCoopClickerAchievements: [HatchCoopClickerAchievement] {
        get {
            guard let data = HatchCoopClickerUserDefaults.data(forKey: "HatchCoopClickerAchievements"),
                  let achievements = try? JSONDecoder().decode([HatchCoopClickerAchievement].self, from: data) else {
                return HatchCoopClickerDefaultAchievements()
            }
            return achievements
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                HatchCoopClickerUserDefaults.set(data, forKey: "HatchCoopClickerAchievements")
            }
        }
    }
    
    private func HatchCoopClickerDefaultPuzzles() -> [HatchCoopClickerPuzzle] {
        return [
            HatchCoopClickerPuzzle(HatchCoopClickerId: "puzzle1", HatchCoopClickerName: "Apple Match", HatchCoopClickerEmoji: "🍎", HatchCoopClickerDifficulty: 1, HatchCoopClickerReward: 10, HatchCoopClickerIsCompleted: false),
            HatchCoopClickerPuzzle(HatchCoopClickerId: "puzzle2", HatchCoopClickerName: "Corn Swap", HatchCoopClickerEmoji: "🌽", HatchCoopClickerDifficulty: 2, HatchCoopClickerReward: 20, HatchCoopClickerIsCompleted: false),
            HatchCoopClickerPuzzle(HatchCoopClickerId: "puzzle3", HatchCoopClickerName: "Grain Slide", HatchCoopClickerEmoji: "🌾", HatchCoopClickerDifficulty: 3, HatchCoopClickerReward: 30, HatchCoopClickerIsCompleted: false)
        ]
    }
    
    private func HatchCoopClickerDefaultAchievements() -> [HatchCoopClickerAchievement] {
        return [
            HatchCoopClickerAchievement(HatchCoopClickerId: "firstHatch", HatchCoopClickerName: "First Hatch", HatchCoopClickerDescription: "Hatch your first chicken", HatchCoopClickerEmoji: "🐣", HatchCoopClickerRequirement: 1, HatchCoopClickerIsUnlocked: false, HatchCoopClickerFarmBotQuip: "Welcome to the flock!", HatchCoopClickerType: "chickens"),
            HatchCoopClickerAchievement(HatchCoopClickerId: "chickenFarmer", HatchCoopClickerName: "Chicken Farmer", HatchCoopClickerDescription: "Own 10 chickens", HatchCoopClickerEmoji: "🐔", HatchCoopClickerRequirement: 10, HatchCoopClickerIsUnlocked: false, HatchCoopClickerFarmBotQuip: "You're building quite a flock!", HatchCoopClickerType: "chickens"),
            HatchCoopClickerAchievement(HatchCoopClickerId: "chickenRancher", HatchCoopClickerName: "Chicken Rancher", HatchCoopClickerDescription: "Own 50 chickens", HatchCoopClickerEmoji: "🏠", HatchCoopClickerRequirement: 50, HatchCoopClickerIsUnlocked: false, HatchCoopClickerFarmBotQuip: "Your coop is getting crowded!", HatchCoopClickerType: "chickens"),
            HatchCoopClickerAchievement(HatchCoopClickerId: "puzzlePro", HatchCoopClickerName: "Puzzle Pro", HatchCoopClickerDescription: "Solve 5 mini-games", HatchCoopClickerEmoji: "🧩", HatchCoopClickerRequirement: 5, HatchCoopClickerIsUnlocked: false, HatchCoopClickerFarmBotQuip: "Your brain is as sharp as a beak!", HatchCoopClickerType: "puzzles"),
            HatchCoopClickerAchievement(HatchCoopClickerId: "puzzleMaster", HatchCoopClickerName: "Puzzle Master", HatchCoopClickerDescription: "Solve 20 mini-games", HatchCoopClickerEmoji: "🏆", HatchCoopClickerRequirement: 20, HatchCoopClickerIsUnlocked: false, HatchCoopClickerFarmBotQuip: "You're a puzzle-solving genius!", HatchCoopClickerType: "puzzles"),
            HatchCoopClickerAchievement(HatchCoopClickerId: "coinCollector", HatchCoopClickerName: "Coin Collector", HatchCoopClickerDescription: "Earn 500 coins", HatchCoopClickerEmoji: "🪙", HatchCoopClickerRequirement: 500, HatchCoopClickerIsUnlocked: false, HatchCoopClickerFarmBotQuip: "Money makes the farm go round!", HatchCoopClickerType: "coins"),
            HatchCoopClickerAchievement(HatchCoopClickerId: "coinMillionaire", HatchCoopClickerName: "Coin Millionaire", HatchCoopClickerDescription: "Earn 2,000 coins", HatchCoopClickerEmoji: "💎", HatchCoopClickerRequirement: 2000, HatchCoopClickerIsUnlocked: false, HatchCoopClickerFarmBotQuip: "You're filthy rich in farm currency!", HatchCoopClickerType: "coins"),
            HatchCoopClickerAchievement(HatchCoopClickerId: "quizScholar", HatchCoopClickerName: "Quiz Scholar", HatchCoopClickerDescription: "Complete 3 quizzes", HatchCoopClickerEmoji: "📚", HatchCoopClickerRequirement: 3, HatchCoopClickerIsUnlocked: false, HatchCoopClickerFarmBotQuip: "Knowledge is power!", HatchCoopClickerType: "quizzes"),
            HatchCoopClickerAchievement(HatchCoopClickerId: "quizMaster", HatchCoopClickerName: "Quiz Master", HatchCoopClickerDescription: "Complete 10 quizzes", HatchCoopClickerEmoji: "🎓", HatchCoopClickerRequirement: 10, HatchCoopClickerIsUnlocked: false, HatchCoopClickerFarmBotQuip: "You're a true scholar!", HatchCoopClickerType: "quizzes"),
            HatchCoopClickerAchievement(HatchCoopClickerId: "levelUp", HatchCoopClickerName: "Level Up!", HatchCoopClickerDescription: "Reach level 5", HatchCoopClickerEmoji: "⭐", HatchCoopClickerRequirement: 5, HatchCoopClickerIsUnlocked: false, HatchCoopClickerFarmBotQuip: "You're growing stronger!", HatchCoopClickerType: "level"),
            HatchCoopClickerAchievement(HatchCoopClickerId: "coopKing", HatchCoopClickerName: "Coop King", HatchCoopClickerDescription: "Reach level 15", HatchCoopClickerEmoji: "👑", HatchCoopClickerRequirement: 15, HatchCoopClickerIsUnlocked: false, HatchCoopClickerFarmBotQuip: "You rule the roost!", HatchCoopClickerType: "level"),
            HatchCoopClickerAchievement(HatchCoopClickerId: "wordBuilder", HatchCoopClickerName: "Word Builder", HatchCoopClickerDescription: "Play Word Builder 5 times", HatchCoopClickerEmoji: "📝", HatchCoopClickerRequirement: 5, HatchCoopClickerIsUnlocked: false, HatchCoopClickerFarmBotQuip: "Words are your friends!", HatchCoopClickerType: "wordBuilder"),
            HatchCoopClickerAchievement(HatchCoopClickerId: "ticTacToe", HatchCoopClickerName: "Tic Tac Toe Pro", HatchCoopClickerDescription: "Play Tic Tac Toe 5 times", HatchCoopClickerEmoji: "⭕", HatchCoopClickerRequirement: 5, HatchCoopClickerIsUnlocked: false, HatchCoopClickerFarmBotQuip: "X marks the spot!", HatchCoopClickerType: "ticTacToe"),
            HatchCoopClickerAchievement(HatchCoopClickerId: "minesweeper", HatchCoopClickerName: "Minesweeper", HatchCoopClickerDescription: "Play Minesweeper 5 times", HatchCoopClickerEmoji: "💣", HatchCoopClickerRequirement: 5, HatchCoopClickerIsUnlocked: false, HatchCoopClickerFarmBotQuip: "Watch out for those mines!", HatchCoopClickerType: "minesweeper"),
            HatchCoopClickerAchievement(HatchCoopClickerId: "mapExplorer", HatchCoopClickerName: "Map Explorer", HatchCoopClickerDescription: "Buy 10 chickens from map", HatchCoopClickerEmoji: "🗺️", HatchCoopClickerRequirement: 10, HatchCoopClickerIsUnlocked: false, HatchCoopClickerFarmBotQuip: "The world is your chicken farm!", HatchCoopClickerType: "mapChickens")
        ]
    }
    
    func HatchCoopClickerResetAllData() {
        HatchCoopClickerRanchCoins = 0
        HatchCoopClickerEggCount = 0
        HatchCoopClickerXP = 0
        HatchCoopClickerFeedStock = 0
        HatchCoopClickerChickensOwned = 0
        HatchCoopClickerCoopLevel = 1
        HatchCoopClickerUnlockedChickens = []
        HatchCoopClickerPuzzles = HatchCoopClickerDefaultPuzzles()
        HatchCoopClickerAchievements = HatchCoopClickerDefaultAchievements()
        
        // Reset achievement progress
        HatchCoopClickerTotalEggsCollected = 0
        HatchCoopClickerTotalChickensHatched = 0
        HatchCoopClickerTotalPuzzlesSolved = 0
        HatchCoopClickerTotalCoinsEarned = 0
        HatchCoopClickerTotalQuizzesCompleted = 0
        HatchCoopClickerMaxLevelReached = 1
        HatchCoopClickerWordBuilderGamesPlayed = 0
        HatchCoopClickerTicTacToeGamesPlayed = 0
        HatchCoopClickerMinesweeperGamesPlayed = 0
        HatchCoopClickerMapChickensBought = 0
    }
} 