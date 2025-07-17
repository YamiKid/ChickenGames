import UIKit

class HatchCoopClickerTicTacToeGameVC: UIViewController {
    
    var HatchCoopClickerOnGameCompleted: ((Int, Int) -> Void)?
    
    private var HatchCoopClickerBoard: [[String]] = Array(repeating: Array(repeating: "", count: 3), count: 3)
    private var HatchCoopClickerCurrentPlayer: String = "X"
    private var HatchCoopClickerGameOver: Bool = false
    private var HatchCoopClickerMovesCount: Int = 0
    private var HatchCoopClickerCells: [[UIButton]] = Array(repeating: Array(repeating: UIButton(), count: 3), count: 3)
    
    private lazy var HatchCoopClickerStatusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0)
        label.textAlignment = .center
        label.text = "Your turn (X)"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerBoardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1.0, green: 0.98, blue: 0.95, alpha: 1.0)
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var HatchCoopClickerResetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("New Game", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(HatchCoopClickerResetGame), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HatchCoopClickerSetupUI()
        HatchCoopClickerSetupBoard()
    }
    
    private func HatchCoopClickerSetupUI() {
        view.backgroundColor = UIColor(red: 1.0, green: 0.95, blue: 0.88, alpha: 1.0)
        title = "⭕ Tic Tac Toe"
        
        view.addSubview(HatchCoopClickerStatusLabel)
        view.addSubview(HatchCoopClickerBoardView)
        view.addSubview(HatchCoopClickerResetButton)
        
        NSLayoutConstraint.activate([
            HatchCoopClickerStatusLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            HatchCoopClickerStatusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            HatchCoopClickerStatusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            HatchCoopClickerBoardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            HatchCoopClickerBoardView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            HatchCoopClickerBoardView.widthAnchor.constraint(equalToConstant: 300),
            HatchCoopClickerBoardView.heightAnchor.constraint(equalToConstant: 300),
            
            HatchCoopClickerResetButton.topAnchor.constraint(equalTo: HatchCoopClickerBoardView.bottomAnchor, constant: 30),
            HatchCoopClickerResetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            HatchCoopClickerResetButton.widthAnchor.constraint(equalToConstant: 150),
            HatchCoopClickerResetButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func HatchCoopClickerSetupBoard() {
        print("Setting up board...")
        
        // Create a stack view for the board
        let HatchCoopClickerBoardStackView = UIStackView()
        HatchCoopClickerBoardStackView.axis = .vertical
        HatchCoopClickerBoardStackView.spacing = 0
        HatchCoopClickerBoardStackView.distribution = .fillEqually
        HatchCoopClickerBoardStackView.translatesAutoresizingMaskIntoConstraints = false
        
        HatchCoopClickerBoardView.addSubview(HatchCoopClickerBoardStackView)
        
        // Create 3 rows
        for row in 0..<3 {
            let HatchCoopClickerRowStackView = UIStackView()
            HatchCoopClickerRowStackView.axis = .horizontal
            HatchCoopClickerRowStackView.spacing = 0
            HatchCoopClickerRowStackView.distribution = .fillEqually
            
            // Create 3 cells per row
            for col in 0..<3 {
                let HatchCoopClickerCell = UIButton(type: .system)
                HatchCoopClickerCell.backgroundColor = UIColor(red: 1.0, green: 0.98, blue: 0.95, alpha: 1.0)
                HatchCoopClickerCell.layer.borderWidth = 3
                HatchCoopClickerCell.layer.borderColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0).cgColor
                HatchCoopClickerCell.titleLabel?.font = UIFont.systemFont(ofSize: 48, weight: .bold)
                HatchCoopClickerCell.setTitleColor(UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0), for: .normal)
                HatchCoopClickerCell.titleLabel?.textAlignment = .center
                HatchCoopClickerCell.contentHorizontalAlignment = .center
                HatchCoopClickerCell.contentVerticalAlignment = .center
                HatchCoopClickerCell.tag = row * 3 + col
                HatchCoopClickerCell.addTarget(self, action: #selector(HatchCoopClickerCellTapped(_:)), for: .touchUpInside)
                
                // Store reference to cell
                HatchCoopClickerCells[row][col] = HatchCoopClickerCell
                
                print("Created cell at (\(row), \(col)) with tag \(HatchCoopClickerCell.tag)")
                
                HatchCoopClickerRowStackView.addArrangedSubview(HatchCoopClickerCell)
            }
            
            HatchCoopClickerBoardStackView.addArrangedSubview(HatchCoopClickerRowStackView)
        }
        
        // Set up constraints for the board stack view
        NSLayoutConstraint.activate([
            HatchCoopClickerBoardStackView.topAnchor.constraint(equalTo: HatchCoopClickerBoardView.topAnchor),
            HatchCoopClickerBoardStackView.leadingAnchor.constraint(equalTo: HatchCoopClickerBoardView.leadingAnchor),
            HatchCoopClickerBoardStackView.trailingAnchor.constraint(equalTo: HatchCoopClickerBoardView.trailingAnchor),
            HatchCoopClickerBoardStackView.bottomAnchor.constraint(equalTo: HatchCoopClickerBoardView.bottomAnchor)
        ])
        
        print("Board setup complete")
    }
    
    @objc private func HatchCoopClickerCellTapped(_ sender: UIButton) {
        let HatchCoopClickerRow = sender.tag / 3
        let HatchCoopClickerCol = sender.tag % 3
        
        print("Cell tapped: row \(HatchCoopClickerRow), col \(HatchCoopClickerCol), tag \(sender.tag)")
        
        if HatchCoopClickerBoard[HatchCoopClickerRow][HatchCoopClickerCol].isEmpty && !HatchCoopClickerGameOver {
            print("Making move: X at (\(HatchCoopClickerRow), \(HatchCoopClickerCol))")
            HatchCoopClickerMakeMove(row: HatchCoopClickerRow, col: HatchCoopClickerCol, player: "X")
            
            if !HatchCoopClickerGameOver {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                    self?.HatchCoopClickerMakeAIMove()
                }
            }
        } else {
            print("Cell already occupied or game over")
        }
    }
    
    private func HatchCoopClickerMakeMove(row: Int, col: Int, player: String) {
        print("MakeMove called: row \(row), col \(col), player \(player)")
        
        HatchCoopClickerBoard[row][col] = player
        HatchCoopClickerMovesCount += 1
        
        // Use direct cell reference instead of searching by tag
        let HatchCoopClickerCell = HatchCoopClickerCells[row][col]
        print("Setting title '\(player)' for cell at (\(row), \(col))")
        
        HatchCoopClickerCell.setTitle(player, for: .normal)
        HatchCoopClickerCell.titleLabel?.textAlignment = .center
        HatchCoopClickerCell.contentHorizontalAlignment = .center
        HatchCoopClickerCell.contentVerticalAlignment = .center
        HatchCoopClickerCell.isEnabled = false
        
        // Force layout update
        HatchCoopClickerCell.setNeedsLayout()
        HatchCoopClickerCell.layoutIfNeeded()
        
        // Add a subtle animation
        UIView.animate(withDuration: 0.2) {
            HatchCoopClickerCell.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } completion: { _ in
            UIView.animate(withDuration: 0.1) {
                HatchCoopClickerCell.transform = .identity
            }
        }
        
        if HatchCoopClickerCheckWin(for: player) {
            HatchCoopClickerGameOver = true
            HatchCoopClickerStatusLabel.text = "\(player) wins!"
            HatchCoopClickerEndGame(playerWon: player == "X")
        } else if HatchCoopClickerMovesCount == 9 {
            HatchCoopClickerGameOver = true
            HatchCoopClickerStatusLabel.text = "It's a tie!"
            HatchCoopClickerEndGame(playerWon: false)
        } else {
            HatchCoopClickerCurrentPlayer = HatchCoopClickerCurrentPlayer == "X" ? "O" : "X"
            HatchCoopClickerStatusLabel.text = HatchCoopClickerCurrentPlayer == "X" ? "Your turn (X)" : "AI thinking..."
        }
    }
    
    private func HatchCoopClickerMakeAIMove() {
        let HatchCoopClickerAvailableMoves = HatchCoopClickerGetAvailableMoves()
        
        if let HatchCoopClickerBestMove = HatchCoopClickerGetBestMove() {
            HatchCoopClickerMakeMove(row: HatchCoopClickerBestMove.0, col: HatchCoopClickerBestMove.1, player: "O")
        } else if let HatchCoopClickerRandomMove = HatchCoopClickerAvailableMoves.randomElement() {
            HatchCoopClickerMakeMove(row: HatchCoopClickerRandomMove.0, col: HatchCoopClickerRandomMove.1, player: "O")
        }
    }
    
    private func HatchCoopClickerGetAvailableMoves() -> [(Int, Int)] {
        var HatchCoopClickerMoves: [(Int, Int)] = []
        for row in 0..<3 {
            for col in 0..<3 {
                if HatchCoopClickerBoard[row][col].isEmpty {
                    HatchCoopClickerMoves.append((row, col))
                }
            }
        }
        return HatchCoopClickerMoves
    }
    
    private func HatchCoopClickerGetBestMove() -> (Int, Int)? {
        let HatchCoopClickerAvailableMoves = HatchCoopClickerGetAvailableMoves()
        
        for move in HatchCoopClickerAvailableMoves {
            HatchCoopClickerBoard[move.0][move.1] = "O"
            if HatchCoopClickerCheckWin(for: "O") {
                HatchCoopClickerBoard[move.0][move.1] = ""
                return move
            }
            HatchCoopClickerBoard[move.0][move.1] = ""
        }
        
        for move in HatchCoopClickerAvailableMoves {
            HatchCoopClickerBoard[move.0][move.1] = "X"
            if HatchCoopClickerCheckWin(for: "X") {
                HatchCoopClickerBoard[move.0][move.1] = ""
                return move
            }
            HatchCoopClickerBoard[move.0][move.1] = ""
        }
        
        return nil
    }
    
    private func HatchCoopClickerCheckWin(for player: String) -> Bool {
        for i in 0..<3 {
            if HatchCoopClickerBoard[i][0] == player && HatchCoopClickerBoard[i][1] == player && HatchCoopClickerBoard[i][2] == player {
                return true
            }
            if HatchCoopClickerBoard[0][i] == player && HatchCoopClickerBoard[1][i] == player && HatchCoopClickerBoard[2][i] == player {
                return true
            }
        }
        
        if HatchCoopClickerBoard[0][0] == player && HatchCoopClickerBoard[1][1] == player && HatchCoopClickerBoard[2][2] == player {
            return true
        }
        
        if HatchCoopClickerBoard[0][2] == player && HatchCoopClickerBoard[1][1] == player && HatchCoopClickerBoard[2][0] == player {
            return true
        }
        
        return false
    }
    
    private func HatchCoopClickerEndGame(playerWon: Bool) {
        // Increment Tic Tac Toe games played counter
        let HatchCoopClickerSharedGameData = HatchCoopClickerGameData.HatchCoopClickerShared
        HatchCoopClickerSharedGameData.HatchCoopClickerTicTacToeGamesPlayed += 1
        
        let HatchCoopClickerCoinsEarned = playerWon ? 20 : 5
        let HatchCoopClickerXPEarned = playerWon ? 50 : 10
        
        let HatchCoopClickerResultVC = HatchCoopClickerGameResultVC()
        HatchCoopClickerResultVC.HatchCoopClickerIsWin = playerWon
        HatchCoopClickerResultVC.HatchCoopClickerCoinsEarned = HatchCoopClickerCoinsEarned
        HatchCoopClickerResultVC.HatchCoopClickerXPEarned = HatchCoopClickerXPEarned
        HatchCoopClickerResultVC.HatchCoopClickerGameName = "Tic Tac Toe"
        HatchCoopClickerResultVC.HatchCoopClickerOnContinue = { [weak self] in
            self?.HatchCoopClickerOnGameCompleted?(HatchCoopClickerCoinsEarned, HatchCoopClickerXPEarned)
            self?.navigationController?.popViewController(animated: true)
        }
        
        HatchCoopClickerResultVC.modalPresentationStyle = .overFullScreen
        present(HatchCoopClickerResultVC, animated: true)
    }
    
    @objc private func HatchCoopClickerResetGame() {
        HatchCoopClickerBoard = Array(repeating: Array(repeating: "", count: 3), count: 3)
        HatchCoopClickerCurrentPlayer = "X"
        HatchCoopClickerGameOver = false
        HatchCoopClickerMovesCount = 0
        
        for row in 0..<3 {
            for col in 0..<3 {
                let HatchCoopClickerCell = HatchCoopClickerCells[row][col]
                HatchCoopClickerCell.setTitle("", for: .normal)
                HatchCoopClickerCell.titleLabel?.textAlignment = .center
                HatchCoopClickerCell.contentHorizontalAlignment = .center
                HatchCoopClickerCell.contentVerticalAlignment = .center
                HatchCoopClickerCell.isEnabled = true
                HatchCoopClickerCell.transform = .identity
            }
        }
        
        HatchCoopClickerStatusLabel.text = "Your turn (X)"
    }
} 