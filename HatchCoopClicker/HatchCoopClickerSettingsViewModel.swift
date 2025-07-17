import Foundation

class HatchCoopClickerSettingsViewModel {
    
    private let HatchCoopClickerSharedGameData = HatchCoopClickerGameData.HatchCoopClickerShared
    
    var HatchCoopClickerOnDataUpdated: (() -> Void)?
    
    var HatchCoopClickerXP: Int {
        return HatchCoopClickerSharedGameData.HatchCoopClickerXP
    }
    
    var HatchCoopClickerRanchCoins: Int {
        return HatchCoopClickerSharedGameData.HatchCoopClickerRanchCoins
    }
    
    var HatchCoopClickerChickensOwned: Int {
        return HatchCoopClickerSharedGameData.HatchCoopClickerChickensOwned
    }
    
    func HatchCoopClickerUpdateData() {
        HatchCoopClickerOnDataUpdated?()
    }
    
    func HatchCoopClickerSetGameMode(_ mode: String) {
        UserDefaults.standard.set(mode, forKey: "HatchCoopClickerGameMode")
    }
    
    func HatchCoopClickerResetAllData() {
        HatchCoopClickerSharedGameData.HatchCoopClickerResetAllData()
        HatchCoopClickerOnDataUpdated?()
    }
} 