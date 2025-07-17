import UIKit

class HatchCoopClickerFeedGridView: UIView {
    
    var HatchCoopClickerOnPuzzleSolved: (() -> Void)?
    
    private var HatchCoopClickerGridSize: Int = 6
    private var HatchCoopClickerFeedTypes = ["🍎", "🌽", "🌾", "🥕"]
    private var HatchCoopClickerGridButtons: [[UIButton]] = []
    private var HatchCoopClickerGridData: [[String]] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        HatchCoopClickerSetupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func HatchCoopClickerSetupUI() {
        backgroundColor = UIColor(red: 1.0, green: 0.98, blue: 0.95, alpha: 1.0)
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0).cgColor
    }
    
    func HatchCoopClickerSetupPuzzle(difficulty: Int) {
        HatchCoopClickerGridSize = 4 + difficulty
        HatchCoopClickerCreateGrid()
        HatchCoopClickerPopulateGrid()
    }
    
    private func HatchCoopClickerCreateGrid() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
        
        HatchCoopClickerGridButtons.removeAll()
        HatchCoopClickerGridData.removeAll()
        
        let HatchCoopClickerButtonSize: CGFloat = 300.0 / CGFloat(HatchCoopClickerGridSize)
        
        for row in 0..<HatchCoopClickerGridSize {
            var HatchCoopClickerButtonRow: [UIButton] = []
            var HatchCoopClickerDataRow: [String] = []
            
            for col in 0..<HatchCoopClickerGridSize {
                let HatchCoopClickerButton = UIButton(type: .system)
                HatchCoopClickerButton.titleLabel?.font = UIFont.systemFont(ofSize: HatchCoopClickerButtonSize * 0.4)
                HatchCoopClickerButton.backgroundColor = UIColor(red: 1.0, green: 0.95, blue: 0.88, alpha: 1.0)
                HatchCoopClickerButton.layer.cornerRadius = 5
                HatchCoopClickerButton.layer.borderWidth = 1
                HatchCoopClickerButton.layer.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0).cgColor
                HatchCoopClickerButton.tag = row * HatchCoopClickerGridSize + col
                HatchCoopClickerButton.addTarget(self, action: #selector(HatchCoopClickerButtonTapped(_:)), for: .touchUpInside)
                
                HatchCoopClickerButton.frame = CGRect(
                    x: CGFloat(col) * HatchCoopClickerButtonSize,
                    y: CGFloat(row) * HatchCoopClickerButtonSize,
                    width: HatchCoopClickerButtonSize,
                    height: HatchCoopClickerButtonSize
                )
                
                addSubview(HatchCoopClickerButton)
                HatchCoopClickerButtonRow.append(HatchCoopClickerButton)
                HatchCoopClickerDataRow.append("")
            }
            
            HatchCoopClickerGridButtons.append(HatchCoopClickerButtonRow)
            HatchCoopClickerGridData.append(HatchCoopClickerDataRow)
        }
    }
    
    private func HatchCoopClickerPopulateGrid() {
        for row in 0..<HatchCoopClickerGridSize {
            for col in 0..<HatchCoopClickerGridSize {
                let HatchCoopClickerRandomFeed = HatchCoopClickerFeedTypes.randomElement()!
                HatchCoopClickerGridData[row][col] = HatchCoopClickerRandomFeed
                HatchCoopClickerGridButtons[row][col].setTitle(HatchCoopClickerRandomFeed, for: .normal)
            }
        }
    }
    
    @objc private func HatchCoopClickerButtonTapped(_ sender: UIButton) {
        let HatchCoopClickerRow = sender.tag / HatchCoopClickerGridSize
        let HatchCoopClickerCol = sender.tag % HatchCoopClickerGridSize
        
        HatchCoopClickerCheckMatches(row: HatchCoopClickerRow, col: HatchCoopClickerCol)
    }
    
    private func HatchCoopClickerCheckMatches(row: Int, col: Int) {
        let HatchCoopClickerTargetFeed = HatchCoopClickerGridData[row][col]
        var HatchCoopClickerMatchedPositions: [(Int, Int)] = []
        
        HatchCoopClickerMatchedPositions.append((row, col))
        
        for HatchCoopClickerDirection in [(0, 1), (1, 0), (0, -1), (-1, 0)] {
            var HatchCoopClickerCurrentRow = row + HatchCoopClickerDirection.0
            var HatchCoopClickerCurrentCol = col + HatchCoopClickerDirection.1
            
            while HatchCoopClickerCurrentRow >= 0 && HatchCoopClickerCurrentRow < HatchCoopClickerGridSize &&
                   HatchCoopClickerCurrentCol >= 0 && HatchCoopClickerCurrentCol < HatchCoopClickerGridSize &&
                   HatchCoopClickerGridData[HatchCoopClickerCurrentRow][HatchCoopClickerCurrentCol] == HatchCoopClickerTargetFeed {
                HatchCoopClickerMatchedPositions.append((HatchCoopClickerCurrentRow, HatchCoopClickerCurrentCol))
                HatchCoopClickerCurrentRow += HatchCoopClickerDirection.0
                HatchCoopClickerCurrentCol += HatchCoopClickerDirection.1
            }
        }
        
        if HatchCoopClickerMatchedPositions.count >= 3 {
            HatchCoopClickerRemoveMatches(positions: HatchCoopClickerMatchedPositions)
        }
    }
    
    private func HatchCoopClickerRemoveMatches(positions: [(Int, Int)]) {
        for (HatchCoopClickerRow, HatchCoopClickerCol) in positions {
            HatchCoopClickerGridButtons[HatchCoopClickerRow][HatchCoopClickerCol].setTitle("", for: .normal)
            HatchCoopClickerGridButtons[HatchCoopClickerRow][HatchCoopClickerCol].backgroundColor = UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 0.3)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.HatchCoopClickerRefillGrid()
        }
    }
    
    private func HatchCoopClickerRefillGrid() {
        for row in 0..<HatchCoopClickerGridSize {
            for col in 0..<HatchCoopClickerGridSize {
                if HatchCoopClickerGridButtons[row][col].title(for: .normal)?.isEmpty ?? true {
                    let HatchCoopClickerNewFeed = HatchCoopClickerFeedTypes.randomElement()!
                    HatchCoopClickerGridData[row][col] = HatchCoopClickerNewFeed
                    HatchCoopClickerGridButtons[row][col].setTitle(HatchCoopClickerNewFeed, for: .normal)
                    HatchCoopClickerGridButtons[row][col].backgroundColor = UIColor(red: 1.0, green: 0.95, blue: 0.88, alpha: 1.0)
                }
            }
        }
        
        HatchCoopClickerCheckWinCondition()
    }
    
    private func HatchCoopClickerCheckWinCondition() {
        var HatchCoopClickerEmptyCount = 0
        for row in 0..<HatchCoopClickerGridSize {
            for col in 0..<HatchCoopClickerGridSize {
                if HatchCoopClickerGridButtons[row][col].title(for: .normal)?.isEmpty ?? true {
                    HatchCoopClickerEmptyCount += 1
                }
            }
        }
        
        if HatchCoopClickerEmptyCount >= HatchCoopClickerGridSize * HatchCoopClickerGridSize / 2 {
            HatchCoopClickerOnPuzzleSolved?()
        }
    }
} 