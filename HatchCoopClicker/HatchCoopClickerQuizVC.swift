import UIKit

class HatchCoopClickerQuizVC: UIViewController {
    
    var HatchCoopClickerOnQuizCompleted: ((Int, Int) -> Void)?
    
    private var HatchCoopClickerCurrentQuestionIndex = 0
    private var HatchCoopClickerCorrectAnswers = 0
    private var HatchCoopClickerSelectedQuestions: [HatchCoopClickerQuizQuestion] = []
    private var HatchCoopClickerUserAnswers: [Int] = []
    
    private lazy var HatchCoopClickerProgressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0)
        label.textAlignment = .center
        label.backgroundColor = UIColor(red: 1.0, green: 0.98, blue: 0.95, alpha: 1.0)
        label.layer.cornerRadius = 15
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.1
        label.layer.shadowRadius = 8
        label.layer.shadowOffset = CGSize(width: 0, height: 4)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerQuestionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = UIColor(red: 1.0, green: 0.98, blue: 0.95, alpha: 1.0)
        label.layer.cornerRadius = 15
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.1
        label.layer.shadowRadius = 8
        label.layer.shadowOffset = CGSize(width: 0, height: 4)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerAnswerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var HatchCoopClickerAnswerButtons: [UIButton] = {
        var buttons: [UIButton] = []
        for i in 0..<4 {
            let button = UIButton(type: .system)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            button.backgroundColor = UIColor(red: 1.0, green: 0.98, blue: 0.95, alpha: 1.0)
            button.setTitleColor(UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0), for: .normal)
            button.layer.cornerRadius = 12
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0).cgColor
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOpacity = 0.1
            button.layer.shadowRadius = 6
            button.layer.shadowOffset = CGSize(width: 0, height: 3)
            button.tag = i
            button.addTarget(self, action: #selector(HatchCoopClickerAnswerSelected(_:)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            buttons.append(button)
        }
        return buttons
    }()
    
    private lazy var HatchCoopClickerNextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next Question", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = UIColor(red: 0.2, green: 0.6, blue: 0.9, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 8
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.addTarget(self, action: #selector(HatchCoopClickerNextQuestion), for: .touchUpInside)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    struct HatchCoopClickerQuizQuestion {
        let question: String
        let answers: [String]
        let correctAnswer: Int
    }
    
    private let HatchCoopClickerAllQuestions: [HatchCoopClickerQuizQuestion] = [
        HatchCoopClickerQuizQuestion(
            question: "What is the capital of France?",
            answers: ["London", "Berlin", "Paris", "Madrid"],
            correctAnswer: 2
        ),
        HatchCoopClickerQuizQuestion(
            question: "Which planet is known as the Red Planet?",
            answers: ["Venus", "Mars", "Jupiter", "Saturn"],
            correctAnswer: 1
        ),
        HatchCoopClickerQuizQuestion(
            question: "What is the largest ocean on Earth?",
            answers: ["Atlantic", "Indian", "Arctic", "Pacific"],
            correctAnswer: 3
        ),
        HatchCoopClickerQuizQuestion(
            question: "Who painted the Mona Lisa?",
            answers: ["Van Gogh", "Da Vinci", "Picasso", "Rembrandt"],
            correctAnswer: 1
        ),
        HatchCoopClickerQuizQuestion(
            question: "What is the chemical symbol for gold?",
            answers: ["Ag", "Au", "Fe", "Cu"],
            correctAnswer: 1
        ),
        HatchCoopClickerQuizQuestion(
            question: "How many sides does a hexagon have?",
            answers: ["5", "6", "7", "8"],
            correctAnswer: 1
        ),
        HatchCoopClickerQuizQuestion(
            question: "What is the main component of the sun?",
            answers: ["Liquid lava", "Molten iron", "Hot gas", "Solid rock"],
            correctAnswer: 2
        ),
        HatchCoopClickerQuizQuestion(
            question: "Which country is home to the kangaroo?",
            answers: ["New Zealand", "South Africa", "Australia", "India"],
            correctAnswer: 2
        ),
        HatchCoopClickerQuizQuestion(
            question: "What is the largest mammal?",
            answers: ["African Elephant", "Blue Whale", "Giraffe", "Hippopotamus"],
            correctAnswer: 1
        ),
        HatchCoopClickerQuizQuestion(
            question: "What year did World War II end?",
            answers: ["1943", "1944", "1945", "1946"],
            correctAnswer: 2
        ),
        HatchCoopClickerQuizQuestion(
            question: "What is the square root of 144?",
            answers: ["10", "11", "12", "13"],
            correctAnswer: 2
        ),
        HatchCoopClickerQuizQuestion(
            question: "Which element has the chemical symbol 'O'?",
            answers: ["Osmium", "Oxygen", "Oganesson", "Osmium"],
            correctAnswer: 1
        ),
        HatchCoopClickerQuizQuestion(
            question: "What is the name of the force that pulls objects toward Earth?",
            answers: ["Magnetism", "Gravity", "Friction", "Inertia"],
            correctAnswer: 1
        ),
        HatchCoopClickerQuizQuestion(
            question: "How many continents are there?",
            answers: ["5", "6", "7", "8"],
            correctAnswer: 2
        ),
        HatchCoopClickerQuizQuestion(
            question: "What is the largest desert in the world?",
            answers: ["Gobi", "Sahara", "Arabian", "Antarctic"],
            correctAnswer: 1
        ),
        HatchCoopClickerQuizQuestion(
            question: "Which famous scientist developed the theory of relativity?",
            answers: ["Newton", "Einstein", "Galileo", "Copernicus"],
            correctAnswer: 1
        ),
        HatchCoopClickerQuizQuestion(
            question: "What is the smallest prime number?",
            answers: ["0", "1", "2", "3"],
            correctAnswer: 2
        ),
        HatchCoopClickerQuizQuestion(
            question: "Which planet is closest to the Sun?",
            answers: ["Venus", "Mercury", "Earth", "Mars"],
            correctAnswer: 1
        ),
        HatchCoopClickerQuizQuestion(
            question: "What is the capital of Japan?",
            answers: ["Seoul", "Beijing", "Tokyo", "Bangkok"],
            correctAnswer: 2
        ),
        HatchCoopClickerQuizQuestion(
            question: "How many bones are in the human body?",
            answers: ["206", "212", "198", "220"],
            correctAnswer: 0
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HatchCoopClickerSetupUI()
        HatchCoopClickerStartQuiz()
    }
    
    private func HatchCoopClickerSetupUI() {
        view.backgroundColor = UIColor(red: 1.0, green: 0.95, blue: 0.88, alpha: 1.0)
        title = "📝 Quiz"
        
        view.addSubview(HatchCoopClickerProgressLabel)
        view.addSubview(HatchCoopClickerQuestionLabel)
        view.addSubview(HatchCoopClickerAnswerStackView)
        view.addSubview(HatchCoopClickerNextButton)
        
        for button in HatchCoopClickerAnswerButtons {
            HatchCoopClickerAnswerStackView.addArrangedSubview(button)
        }
        
        NSLayoutConstraint.activate([
            HatchCoopClickerProgressLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            HatchCoopClickerProgressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            HatchCoopClickerProgressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            HatchCoopClickerProgressLabel.heightAnchor.constraint(equalToConstant: 50),
            
            HatchCoopClickerQuestionLabel.topAnchor.constraint(equalTo: HatchCoopClickerProgressLabel.bottomAnchor, constant: 30),
            HatchCoopClickerQuestionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            HatchCoopClickerQuestionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            HatchCoopClickerQuestionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 120),
            
            HatchCoopClickerAnswerStackView.topAnchor.constraint(equalTo: HatchCoopClickerQuestionLabel.bottomAnchor, constant: 30),
            HatchCoopClickerAnswerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            HatchCoopClickerAnswerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            HatchCoopClickerAnswerStackView.heightAnchor.constraint(equalToConstant: 280),
            
            HatchCoopClickerNextButton.topAnchor.constraint(equalTo: HatchCoopClickerAnswerStackView.bottomAnchor, constant: 30),
            HatchCoopClickerNextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            HatchCoopClickerNextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            HatchCoopClickerNextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func HatchCoopClickerStartQuiz() {
        HatchCoopClickerCurrentQuestionIndex = 0
        HatchCoopClickerCorrectAnswers = 0
        HatchCoopClickerUserAnswers.removeAll()
        
        // Select 10 random questions from 20
        HatchCoopClickerSelectedQuestions = Array(HatchCoopClickerAllQuestions.shuffled().prefix(10))
        
        HatchCoopClickerShowQuestion()
    }
    
    private func HatchCoopClickerShowQuestion() {
        guard HatchCoopClickerCurrentQuestionIndex < HatchCoopClickerSelectedQuestions.count else {
            HatchCoopClickerShowResults()
            return
        }
        
        let question = HatchCoopClickerSelectedQuestions[HatchCoopClickerCurrentQuestionIndex]
        
        HatchCoopClickerProgressLabel.text = "Question \(HatchCoopClickerCurrentQuestionIndex + 1) of \(HatchCoopClickerSelectedQuestions.count)"
        HatchCoopClickerQuestionLabel.text = question.question
        
        for (index, button) in HatchCoopClickerAnswerButtons.enumerated() {
            button.setTitle(question.answers[index], for: .normal)
            button.backgroundColor = UIColor(red: 1.0, green: 0.98, blue: 0.95, alpha: 1.0)
            button.setTitleColor(UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0), for: .normal)
            button.layer.borderColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0).cgColor
            button.isEnabled = true
        }
        
        HatchCoopClickerNextButton.isEnabled = false
        HatchCoopClickerNextButton.setTitle("Next Question", for: .normal)
    }
    
    @objc private func HatchCoopClickerAnswerSelected(_ sender: UIButton) {
        let selectedAnswer = sender.tag
        
        // Disable all buttons
        for button in HatchCoopClickerAnswerButtons {
            button.isEnabled = false
        }
        
        // Show correct answer
        let question = HatchCoopClickerSelectedQuestions[HatchCoopClickerCurrentQuestionIndex]
        let correctButton = HatchCoopClickerAnswerButtons[question.correctAnswer]
        
        if selectedAnswer == question.correctAnswer {
            sender.backgroundColor = UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 1.0)
            sender.setTitleColor(.white, for: .normal)
            HatchCoopClickerCorrectAnswers += 1
        } else {
            sender.backgroundColor = UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0)
            sender.setTitleColor(.white, for: .normal)
            correctButton.backgroundColor = UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 1.0)
            correctButton.setTitleColor(.white, for: .normal)
        }
        
        HatchCoopClickerUserAnswers.append(selectedAnswer)
        HatchCoopClickerNextButton.isEnabled = true
        
        if HatchCoopClickerCurrentQuestionIndex == HatchCoopClickerSelectedQuestions.count - 1 {
            HatchCoopClickerNextButton.setTitle("See Results", for: .normal)
        }
    }
    
    @objc private func HatchCoopClickerNextQuestion() {
        HatchCoopClickerCurrentQuestionIndex += 1
        HatchCoopClickerShowQuestion()
    }
    
    private func HatchCoopClickerShowResults() {
        let resultsVC = HatchCoopClickerQuizResultsVC()
        resultsVC.HatchCoopClickerCorrectAnswers = HatchCoopClickerCorrectAnswers
        resultsVC.HatchCoopClickerTotalQuestions = HatchCoopClickerSelectedQuestions.count
        resultsVC.HatchCoopClickerOnContinue = { [weak self] in
            // Calculate rewards
            let coinsEarned = (self?.HatchCoopClickerCorrectAnswers ?? 0) * 5
            let xpEarned = (self?.HatchCoopClickerCorrectAnswers ?? 0) * 10
            
            // Update quiz completion count
            let gameData = HatchCoopClickerGameData.HatchCoopClickerShared
            gameData.HatchCoopClickerTotalQuizzesCompleted += 1
            
            // Update achievements
            let achievementsViewModel = HatchCoopClickerAchievementsViewModel()
            achievementsViewModel.HatchCoopClickerUpdateData()
            
            // Call completion handler
            self?.HatchCoopClickerOnQuizCompleted?(coinsEarned, xpEarned)
            
            // Dismiss the results and pop back to previous screen
            resultsVC.dismiss(animated: true) {
                self?.navigationController?.popViewController(animated: true)
            }
        }
        resultsVC.modalPresentationStyle = .overFullScreen
        present(resultsVC, animated: true)
    }
} 