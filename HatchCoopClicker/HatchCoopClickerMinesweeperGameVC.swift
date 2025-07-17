import UIKit

class HatchCoopClickerMinesweeperGameVC: UIViewController {
    
    var HatchCoopClickerOnGameCompleted: ((Int, Int) -> Void)?
    
    private var HatchCoopClickerBoard: [[HatchCoopClickerCell]] = []
    private var HatchCoopClickerMines: Set<String> = []
    private var HatchCoopClickerRevealed: Set<String> = []
    private var HatchCoopClickerFlagged: Set<String> = []
    private var HatchCoopClickerGameOver: Bool = false
    private var HatchCoopClickerFirstClick: Bool = true
    
    private let HatchCoopClickerGridSize = 9
    private let HatchCoopClickerMineCount = 10
    
    private lazy var HatchCoopClickerStatusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0)
        label.textAlignment = .center
        label.text = "💣 Mines: \(HatchCoopClickerMineCount)"
        label.backgroundColor = UIColor(red: 1.0, green: 0.98, blue: 0.95, alpha: 1.0)
        label.layer.cornerRadius = 15
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.1
        label.layer.shadowRadius = 8
        label.layer.shadowOffset = CGSize(width: 0, height: 4)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerBoardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1.0, green: 0.98, blue: 0.95, alpha: 1.0)
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 6
        view.layer.borderColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0).cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.shadowRadius = 12
        view.layer.shadowOffset = CGSize(width: 0, height: 6)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var HatchCoopClickerFlagButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("🚩", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 0.9, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 6
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.addTarget(self, action: #selector(HatchCoopClickerToggleFlagMode), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var HatchCoopClickerResetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("🔄", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 6
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.addTarget(self, action: #selector(HatchCoopClickerResetGame), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var HatchCoopClickerFlagMode: Bool = false
    
    struct HatchCoopClickerCell {
        var HatchCoopClickerIsMine: Bool = false
        var HatchCoopClickerNeighborMines: Int = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HatchCoopClickerSetupUI()
        HatchCoopClickerInitializeGame()
    }
    
    private func HatchCoopClickerSetupUI() {
        view.backgroundColor = UIColor(red: 1.0, green: 0.95, blue: 0.88, alpha: 1.0)
        title = "💣 Minesweeper"
        
        view.addSubview(HatchCoopClickerStatusLabel)
        view.addSubview(HatchCoopClickerBoardView)
        view.addSubview(HatchCoopClickerFlagButton)
        view.addSubview(HatchCoopClickerResetButton)
        
        NSLayoutConstraint.activate([
            HatchCoopClickerStatusLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            HatchCoopClickerStatusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            HatchCoopClickerStatusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            HatchCoopClickerStatusLabel.heightAnchor.constraint(equalToConstant: 50),
            
            HatchCoopClickerBoardView.topAnchor.constraint(equalTo: HatchCoopClickerStatusLabel.bottomAnchor, constant: 25),
            HatchCoopClickerBoardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            HatchCoopClickerBoardView.widthAnchor.constraint(equalToConstant: 280),
            HatchCoopClickerBoardView.heightAnchor.constraint(equalToConstant: 280),
            
            HatchCoopClickerFlagButton.topAnchor.constraint(equalTo: HatchCoopClickerBoardView.bottomAnchor, constant: 25),
            HatchCoopClickerFlagButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            HatchCoopClickerFlagButton.widthAnchor.constraint(equalToConstant: 80),
            HatchCoopClickerFlagButton.heightAnchor.constraint(equalToConstant: 40),
            
            HatchCoopClickerResetButton.topAnchor.constraint(equalTo: HatchCoopClickerBoardView.bottomAnchor, constant: 25),
            HatchCoopClickerResetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            HatchCoopClickerResetButton.widthAnchor.constraint(equalToConstant: 80),
            HatchCoopClickerResetButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func HatchCoopClickerInitializeGame() {
        HatchCoopClickerBoard = Array(repeating: Array(repeating: HatchCoopClickerCell(), count: HatchCoopClickerGridSize), count: HatchCoopClickerGridSize)
        HatchCoopClickerMines.removeAll()
        HatchCoopClickerRevealed.removeAll()
        HatchCoopClickerFlagged.removeAll()
        HatchCoopClickerGameOver = false
        HatchCoopClickerFirstClick = true
        
        HatchCoopClickerSetupBoard()
    }
    
    private func HatchCoopClickerSetupBoard() {
        let HatchCoopClickerCellSize: CGFloat = 31
        
        for row in 0..<HatchCoopClickerGridSize {
            for col in 0..<HatchCoopClickerGridSize {
                let HatchCoopClickerCell = UIButton(type: .system)
                HatchCoopClickerCell.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
                HatchCoopClickerCell.layer.borderWidth = 1.5
                HatchCoopClickerCell.layer.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0).cgColor
                HatchCoopClickerCell.layer.cornerRadius = 2
                HatchCoopClickerCell.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
                HatchCoopClickerCell.setTitleColor(UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0), for: .normal)
                HatchCoopClickerCell.tag = row * HatchCoopClickerGridSize + col
                HatchCoopClickerCell.addTarget(self, action: #selector(HatchCoopClickerCellTapped(_:)), for: .touchUpInside)
                
                // Add subtle shadow to cells
                HatchCoopClickerCell.layer.shadowColor = UIColor.black.cgColor
                HatchCoopClickerCell.layer.shadowOpacity = 0.05
                HatchCoopClickerCell.layer.shadowRadius = 2
                HatchCoopClickerCell.layer.shadowOffset = CGSize(width: 0, height: 1)
                
                HatchCoopClickerCell.frame = CGRect(
                    x: CGFloat(col) * HatchCoopClickerCellSize,
                    y: CGFloat(row) * HatchCoopClickerCellSize,
                    width: HatchCoopClickerCellSize,
                    height: HatchCoopClickerCellSize
                )
                
                HatchCoopClickerBoardView.addSubview(HatchCoopClickerCell)
            }
        }
    }
    
    private func HatchCoopClickerPlaceMines(excludingRow: Int, excludingCol: Int) {
        var HatchCoopClickerAvailablePositions: [(Int, Int)] = []
        
        for row in 0..<HatchCoopClickerGridSize {
            for col in 0..<HatchCoopClickerGridSize {
                if row != excludingRow || col != excludingCol {
                    HatchCoopClickerAvailablePositions.append((row, col))
                }
            }
        }
        
        HatchCoopClickerAvailablePositions.shuffle()
        
        for i in 0..<HatchCoopClickerMineCount {
            let HatchCoopClickerPosition = HatchCoopClickerAvailablePositions[i]
            HatchCoopClickerBoard[HatchCoopClickerPosition.0][HatchCoopClickerPosition.1].HatchCoopClickerIsMine = true
            HatchCoopClickerMines.insert("\(HatchCoopClickerPosition.0),\(HatchCoopClickerPosition.1)")
        }
        
        HatchCoopClickerCalculateNeighborMines()
    }
    
    private func HatchCoopClickerCalculateNeighborMines() {
        for row in 0..<HatchCoopClickerGridSize {
            for col in 0..<HatchCoopClickerGridSize {
                if !HatchCoopClickerBoard[row][col].HatchCoopClickerIsMine {
                    var HatchCoopClickerCount = 0
                    
                    for HatchCoopClickerDRow in -1...1 {
                        for HatchCoopClickerDCol in -1...1 {
                            let HatchCoopClickerNewRow = row + HatchCoopClickerDRow
                            let HatchCoopClickerNewCol = col + HatchCoopClickerDCol
                            
                            if HatchCoopClickerNewRow >= 0 && HatchCoopClickerNewRow < HatchCoopClickerGridSize &&
                               HatchCoopClickerNewCol >= 0 && HatchCoopClickerNewCol < HatchCoopClickerGridSize {
                                if HatchCoopClickerBoard[HatchCoopClickerNewRow][HatchCoopClickerNewCol].HatchCoopClickerIsMine {
                                    HatchCoopClickerCount += 1
                                }
                            }
                        }
                    }
                    
                    HatchCoopClickerBoard[row][col].HatchCoopClickerNeighborMines = HatchCoopClickerCount
                }
            }
        }
    }
    
    @objc private func HatchCoopClickerCellTapped(_ sender: UIButton) {
        let HatchCoopClickerRow = sender.tag / HatchCoopClickerGridSize
        let HatchCoopClickerCol = sender.tag % HatchCoopClickerGridSize
        let HatchCoopClickerKey = "\(HatchCoopClickerRow),\(HatchCoopClickerCol)"
        
        if HatchCoopClickerGameOver || HatchCoopClickerRevealed.contains(HatchCoopClickerKey) {
            return
        }
        
        if HatchCoopClickerFlagMode {
            HatchCoopClickerToggleFlag(row: HatchCoopClickerRow, col: HatchCoopClickerCol, key: HatchCoopClickerKey, button: sender)
        } else {
            if HatchCoopClickerFlagged.contains(HatchCoopClickerKey) {
                return
            }
            
            if HatchCoopClickerFirstClick {
                HatchCoopClickerPlaceMines(excludingRow: HatchCoopClickerRow, excludingCol: HatchCoopClickerCol)
                HatchCoopClickerFirstClick = false
            }
            
            HatchCoopClickerRevealCell(row: HatchCoopClickerRow, col: HatchCoopClickerCol, key: HatchCoopClickerKey, button: sender)
        }
    }
    
    private func HatchCoopClickerToggleFlag(row: Int, col: Int, key: String, button: UIButton) {
        if HatchCoopClickerFlagged.contains(key) {
            HatchCoopClickerFlagged.remove(key)
            button.setTitle("", for: .normal)
            button.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
            button.layer.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0).cgColor
        } else {
            HatchCoopClickerFlagged.insert(key)
            button.setTitle("🚩", for: .normal)
            button.backgroundColor = UIColor(red: 1.0, green: 0.9, blue: 0.9, alpha: 1.0)
            button.layer.borderColor = UIColor(red: 0.8, green: 0.3, blue: 0.3, alpha: 1.0).cgColor
        }
        
        HatchCoopClickerUpdateStatus()
    }
    
    private func HatchCoopClickerRevealCell(row: Int, col: Int, key: String, button: UIButton) {
        HatchCoopClickerRevealed.insert(key)
        
        if HatchCoopClickerBoard[row][col].HatchCoopClickerIsMine {
            HatchCoopClickerGameOver = true
            button.setTitle("💣", for: .normal)
            button.backgroundColor = UIColor(red: 1.0, green: 0.2, blue: 0.2, alpha: 1.0)
            button.layer.borderColor = UIColor(red: 0.8, green: 0.1, blue: 0.1, alpha: 1.0).cgColor
            HatchCoopClickerRevealAllMines()
            HatchCoopClickerEndGame(won: false)
        } else {
            let HatchCoopClickerNeighborMines = HatchCoopClickerBoard[row][col].HatchCoopClickerNeighborMines
            button.backgroundColor = UIColor(red: 1.0, green: 0.98, blue: 0.95, alpha: 1.0)
            button.layer.borderColor = UIColor(red: 0.9, green: 0.85, blue: 0.8, alpha: 1.0).cgColor
            
            if HatchCoopClickerNeighborMines > 0 {
                button.setTitle("\(HatchCoopClickerNeighborMines)", for: .normal)
                button.setTitleColor(HatchCoopClickerGetNumberColor(HatchCoopClickerNeighborMines), for: .normal)
            } else {
                HatchCoopClickerRevealNeighbors(row: row, col: col)
            }
            
            if HatchCoopClickerCheckWin() {
                HatchCoopClickerEndGame(won: true)
            }
        }
    }
    
    private func HatchCoopClickerRevealNeighbors(row: Int, col: Int) {
        for HatchCoopClickerDRow in -1...1 {
            for HatchCoopClickerDCol in -1...1 {
                let HatchCoopClickerNewRow = row + HatchCoopClickerDRow
                let HatchCoopClickerNewCol = col + HatchCoopClickerDCol
                let HatchCoopClickerKey = "\(HatchCoopClickerNewRow),\(HatchCoopClickerNewCol)"
                
                if HatchCoopClickerNewRow >= 0 && HatchCoopClickerNewRow < HatchCoopClickerGridSize &&
                   HatchCoopClickerNewCol >= 0 && HatchCoopClickerNewCol < HatchCoopClickerGridSize &&
                   !HatchCoopClickerRevealed.contains(HatchCoopClickerKey) &&
                   !HatchCoopClickerFlagged.contains(HatchCoopClickerKey) {
                    
                    if let HatchCoopClickerButton = HatchCoopClickerBoardView.viewWithTag(HatchCoopClickerNewRow * HatchCoopClickerGridSize + HatchCoopClickerNewCol) as? UIButton {
                        HatchCoopClickerRevealCell(row: HatchCoopClickerNewRow, col: HatchCoopClickerNewCol, key: HatchCoopClickerKey, button: HatchCoopClickerButton)
                    }
                }
            }
        }
    }
    
    private func HatchCoopClickerRevealAllMines() {
        for row in 0..<HatchCoopClickerGridSize {
            for col in 0..<HatchCoopClickerGridSize {
                let HatchCoopClickerKey = "\(row),\(col)"
                if HatchCoopClickerBoard[row][col].HatchCoopClickerIsMine && !HatchCoopClickerRevealed.contains(HatchCoopClickerKey) {
                    if let HatchCoopClickerButton = HatchCoopClickerBoardView.viewWithTag(row * HatchCoopClickerGridSize + col) as? UIButton {
                        HatchCoopClickerButton.setTitle("💣", for: .normal)
                        HatchCoopClickerButton.backgroundColor = UIColor(red: 1.0, green: 0.2, blue: 0.2, alpha: 1.0)
                    }
                }
            }
        }
    }
    
    private func HatchCoopClickerCheckWin() -> Bool {
        return HatchCoopClickerRevealed.count == HatchCoopClickerGridSize * HatchCoopClickerGridSize - HatchCoopClickerMineCount
    }
    
    private func HatchCoopClickerGetNumberColor(_ number: Int) -> UIColor {
        switch number {
        case 1: return .blue
        case 2: return .green
        case 3: return .red
        case 4: return .purple
        case 5: return .orange
        case 6: return .cyan
        case 7: return .black
        case 8: return .gray
        default: return .black
        }
    }
    
    private func HatchCoopClickerUpdateStatus() {
        let HatchCoopClickerRemainingMines = HatchCoopClickerMineCount - HatchCoopClickerFlagged.count
        HatchCoopClickerStatusLabel.text = "Mines: \(HatchCoopClickerRemainingMines)"
    }
    
    @objc private func HatchCoopClickerToggleFlagMode() {
        HatchCoopClickerFlagMode.toggle()
        
        if HatchCoopClickerFlagMode {
            HatchCoopClickerFlagButton.backgroundColor = UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 1.0)
        } else {
            HatchCoopClickerFlagButton.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 0.9, alpha: 1.0)
        }
    }
    
    private func HatchCoopClickerEndGame(won: Bool) {
        HatchCoopClickerGameOver = true
        
        // Increment Minesweeper games played counter
        let HatchCoopClickerSharedGameData = HatchCoopClickerGameData.HatchCoopClickerShared
        HatchCoopClickerSharedGameData.HatchCoopClickerMinesweeperGamesPlayed += 1
        
        let HatchCoopClickerCoinsEarned = won ? 30 : 5
        let HatchCoopClickerXPEarned = won ? 75 : 10
        
        let HatchCoopClickerResultVC = HatchCoopClickerGameResultVC()
        HatchCoopClickerResultVC.HatchCoopClickerIsWin = won
        HatchCoopClickerResultVC.HatchCoopClickerCoinsEarned = HatchCoopClickerCoinsEarned
        HatchCoopClickerResultVC.HatchCoopClickerXPEarned = HatchCoopClickerXPEarned
        HatchCoopClickerResultVC.HatchCoopClickerGameName = "Minesweeper"
        HatchCoopClickerResultVC.HatchCoopClickerOnContinue = { [weak self] in
            self?.HatchCoopClickerOnGameCompleted?(HatchCoopClickerCoinsEarned, HatchCoopClickerXPEarned)
            self?.navigationController?.popViewController(animated: true)
        }
        
        HatchCoopClickerResultVC.modalPresentationStyle = .overFullScreen
        present(HatchCoopClickerResultVC, animated: true)
    }
    
    @objc private func HatchCoopClickerResetGame() {
        for subview in HatchCoopClickerBoardView.subviews {
            subview.removeFromSuperview()
        }
        HatchCoopClickerInitializeGame()
    }
} 