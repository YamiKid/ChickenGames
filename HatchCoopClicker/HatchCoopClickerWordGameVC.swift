import UIKit

class HatchCoopClickerWordGameVC: UIViewController {
    
    var HatchCoopClickerOnGameCompleted: ((Int, Int) -> Void)?
    
    private var HatchCoopClickerLetters: [String] = []
    private var HatchCoopClickerCurrentWord: String = ""
    private var HatchCoopClickerFoundWords: [String] = []
    private var HatchCoopClickerTimeRemaining: Int = 60
    private var HatchCoopClickerTimer: Timer?
    private var HatchCoopClickerValidWords: Set<String> = []
    
    private lazy var HatchCoopClickerBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1.0, green: 0.95, blue: 0.88, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var HatchCoopClickerTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
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
    
    private lazy var HatchCoopClickerCurrentWordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Tap letters to form words!"
        label.backgroundColor = UIColor(red: 1.0, green: 0.98, blue: 0.95, alpha: 1.0)
        label.layer.cornerRadius = 15
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.1
        label.layer.shadowRadius = 8
        label.layer.shadowOffset = CGSize(width: 0, height: 4)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerLettersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 12
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(HatchCoopClickerLetterCell.self, forCellWithReuseIdentifier: "HatchCoopClickerLetterCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var HatchCoopClickerButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var HatchCoopClickerSubmitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit Word", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 8
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.addTarget(self, action: #selector(HatchCoopClickerSubmitWord), for: .touchUpInside)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var HatchCoopClickerClearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Clear", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 8
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.addTarget(self, action: #selector(HatchCoopClickerClearWord), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var HatchCoopClickerFoundWordsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Found words will appear here"
        label.backgroundColor = UIColor(red: 1.0, green: 0.98, blue: 0.95, alpha: 1.0)
        label.layer.cornerRadius = 15
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.1
        label.layer.shadowRadius = 6
        label.layer.shadowOffset = CGSize(width: 0, height: 3)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HatchCoopClickerSetupUI()
        HatchCoopClickerStartGame()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        HatchCoopClickerTimer?.invalidate()
    }
    
    private func HatchCoopClickerSetupUI() {
        view.backgroundColor = UIColor(red: 1.0, green: 0.95, blue: 0.88, alpha: 1.0)
        title = "📝 Word Builder"
        
        view.addSubview(HatchCoopClickerBackgroundView)
        HatchCoopClickerBackgroundView.addSubview(HatchCoopClickerTimeLabel)
        HatchCoopClickerBackgroundView.addSubview(HatchCoopClickerCurrentWordLabel)
        HatchCoopClickerBackgroundView.addSubview(HatchCoopClickerLettersCollectionView)
        HatchCoopClickerBackgroundView.addSubview(HatchCoopClickerButtonsStackView)
        HatchCoopClickerBackgroundView.addSubview(HatchCoopClickerFoundWordsLabel)
        
        HatchCoopClickerButtonsStackView.addArrangedSubview(HatchCoopClickerSubmitButton)
        HatchCoopClickerButtonsStackView.addArrangedSubview(HatchCoopClickerClearButton)
        
        NSLayoutConstraint.activate([
            HatchCoopClickerBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            HatchCoopClickerBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            HatchCoopClickerBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            HatchCoopClickerBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Center the content vertically
            HatchCoopClickerTimeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            HatchCoopClickerTimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            HatchCoopClickerTimeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            HatchCoopClickerTimeLabel.heightAnchor.constraint(equalToConstant: 60),
            
            HatchCoopClickerCurrentWordLabel.topAnchor.constraint(equalTo: HatchCoopClickerTimeLabel.bottomAnchor, constant: 25),
            HatchCoopClickerCurrentWordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            HatchCoopClickerCurrentWordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            HatchCoopClickerCurrentWordLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 120),
            
            HatchCoopClickerLettersCollectionView.topAnchor.constraint(equalTo: HatchCoopClickerCurrentWordLabel.bottomAnchor, constant: 35),
            HatchCoopClickerLettersCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            HatchCoopClickerLettersCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            HatchCoopClickerLettersCollectionView.heightAnchor.constraint(equalToConstant: 120),
            
            HatchCoopClickerButtonsStackView.topAnchor.constraint(equalTo: HatchCoopClickerLettersCollectionView.bottomAnchor, constant: 35),
            HatchCoopClickerButtonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            HatchCoopClickerButtonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            HatchCoopClickerButtonsStackView.heightAnchor.constraint(equalToConstant: 60),
            
            HatchCoopClickerFoundWordsLabel.topAnchor.constraint(equalTo: HatchCoopClickerButtonsStackView.bottomAnchor, constant: 35),
            HatchCoopClickerFoundWordsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            HatchCoopClickerFoundWordsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            HatchCoopClickerFoundWordsLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }
    
    private func HatchCoopClickerStartGame() {
        HatchCoopClickerLoadDictionary()
        HatchCoopClickerGenerateLetters()
        HatchCoopClickerStartTimer()
    }
    
    private func HatchCoopClickerLoadDictionary() {
        // Extensive English words dictionary
        let HatchCoopClickerPopularWords = [
            // 1-2 letter words
            "A", "AN", "AS", "AT", "BE", "BY", "DO", "GO", "HE", "IF", "IN", "IS", "IT", "ME", "MY", "NO", "OF", "ON", "OR", "SO", "TO", "UP", "WE", "AM", "AM", "AN", "AS", "AT", "BE", "BY", "DO", "GO", "HE", "IF", "IN", "IS", "IT", "ME", "MY", "NO", "OF", "ON", "OR", "SO", "TO", "UP", "WE", "AM", "AN", "AS", "AT", "BE", "BY", "DO", "GO", "HE", "IF", "IN", "IS", "IT", "ME", "MY", "NO", "OF", "ON", "OR", "SO", "TO", "UP", "WE",
            
            // 3 letter words
            "ACT", "ADD", "AGE", "AIR", "ALL", "ANY", "BAD", "BAG", "BIG", "BOX", "BOY", "CAN", "CAR", "CAT", "DAY", "DOG", "EAT", "END", "EYE", "FAR", "FEW", "FUN", "GET", "GOD", "GUN", "HAD", "HAS", "HER", "HIM", "HIS", "HOT", "HOW", "ICE", "JOB", "KEY", "LAW", "LET", "LOW", "MAN", "MAY", "NEW", "NOW", "OLD", "ONE", "OUT", "OWN", "PAY", "PUT", "RED", "RUN", "SAY", "SEE", "SHE", "SIT", "SIX", "SUN", "TEN", "THE", "TOO", "TOP", "TRY", "TWO", "USE", "WAY", "WHO", "WIN", "YES", "YOU", "ASK", "BET", "BIT", "BUT", "CUT", "DID", "DIE", "DUE", "EAT", "FIT", "FIX", "GOT", "HAS", "HAT", "HIT", "HOT", "JOB", "JOT", "KID", "LOT", "MAP", "MIX", "NOT", "NUT", "OFF", "OIL", "PEN", "PET", "PIT", "RAN", "RAT", "RIP", "SAT", "SET", "SIT", "SKI", "TAG", "TAP", "TIP", "TOP", "TUG", "WAR", "WAS", "WET", "WON", "ZOO",
            
            // 4 letter words
            "ABLE", "ACID", "AGED", "ALSO", "AREA", "ARMY", "AWAY", "BABY", "BACK", "BALL", "BANK", "BASE", "BEST", "BIRD", "BLUE", "BOOK", "BORN", "BOTH", "BUSY", "CALL", "CARD", "CARE", "CITY", "COLD", "COME", "COST", "DEAD", "DEAL", "DOOR", "DOWN", "DROP", "EACH", "EASY", "EDGE", "EVEN", "FACE", "FACT", "FALL", "FARM", "FAST", "FEEL", "FIND", "FINE", "FIRE", "FISH", "FIVE", "FOLD", "FOOD", "FREE", "FROM", "FULL", "GAME", "GAVE", "GIVE", "GOLD", "GONE", "GOOD", "GRAY", "HALF", "HAND", "HARD", "HAVE", "HEAD", "HEAR", "HELP", "HERE", "HIGH", "HOLD", "HOME", "HOPE", "HOUR", "IDEA", "INTO", "KEEP", "KIND", "KNOW", "LAND", "LAST", "LATE", "LEFT", "LIFE", "LINE", "LIVE", "LONG", "LOOK", "LOST", "LOTS", "MADE", "MAIN", "MAKE", "MANY", "MEAN", "MIND", "MISS", "MOVE", "MUCH", "MUST", "NAME", "NEAR", "NEED", "NEXT", "NINE", "ONCE", "ONLY", "OPEN", "OVER", "PART", "PASS", "PAST", "PLAY", "POOR", "PULL", "PUSH", "READ", "REAL", "REST", "RIDE", "ROAD", "ROCK", "ROOM", "SAFE", "SAID", "SAME", "SAVE", "SEEM", "SHOW", "SIDE", "SIGN", "SING", "SIZE", "SLOW", "SOON", "STOP", "SURE", "TAKE", "TALK", "TELL", "THAN", "THAT", "THEM", "THEN", "THEY", "THIS", "TIME", "TURN", "USED", "VERY", "WALK", "WANT", "WARM", "WASH", "WEEK", "WELL", "WENT", "WERE", "WHAT", "WHEN", "WILL", "WIND", "WISH", "WITH", "WORD", "WORK", "YEAR", "YOUR", "ABLE", "ACID", "AGED", "ALSO", "AREA", "ARMY", "AWAY", "BABY", "BACK", "BALL", "BANK", "BASE", "BEST", "BIRD", "BLUE", "BOOK", "BORN", "BOTH", "BUSY", "CALL", "CARD", "CARE", "CITY", "COLD", "COME", "COST", "DEAD", "DEAL", "DOOR", "DOWN", "DROP", "EACH", "EASY", "EDGE", "EVEN", "FACE", "FACT", "FALL", "FARM", "FAST", "FEEL", "FIND", "FINE", "FIRE", "FISH", "FIVE", "FOLD", "FOOD", "FREE", "FROM", "FULL", "GAME", "GAVE", "GIVE", "GOLD", "GONE", "GOOD", "GRAY", "HALF", "HAND", "HARD", "HAVE", "HEAD", "HEAR", "HELP", "HERE", "HIGH", "HOLD", "HOME", "HOPE", "HOUR", "IDEA", "INTO", "KEEP", "KIND", "KNOW", "LAND", "LAST", "LATE", "LEFT", "LIFE", "LINE", "LIVE", "LONG", "LOOK", "LOST", "LOTS", "MADE", "MAIN", "MAKE", "MANY", "MEAN", "MIND", "MISS", "MOVE", "MUCH", "MUST", "NAME", "NEAR", "NEED", "NEXT", "NINE", "ONCE", "ONLY", "OPEN", "OVER", "PART", "PASS", "PAST", "PLAY", "POOR", "PULL", "PUSH", "READ", "REAL", "REST", "RIDE", "ROAD", "ROCK", "ROOM", "SAFE", "SAID", "SAME", "SAVE", "SEEM", "SHOW", "SIDE", "SIGN", "SING", "SIZE", "SLOW", "SOON", "STOP", "SURE", "TAKE", "TALK", "TELL", "THAN", "THAT", "THEM", "THEN", "THEY", "THIS", "TIME", "TURN", "USED", "VERY", "WALK", "WANT", "WARM", "WASH", "WEEK", "WELL", "WENT", "WERE", "WHAT", "WHEN", "WILL", "WIND", "WISH", "WITH", "WORD", "WORK", "YEAR", "YOUR",
            
            // 5 letter words
            "ABOUT", "ABOVE", "AFTER", "AGAIN", "ALONG", "AMONG", "ANOTHER", "ANSWER", "AROUND", "BEFORE", "BEHIND", "BELOW", "BESIDE", "BETTER", "BETWEEN", "BOTTOM", "BREAK", "BRING", "BUILD", "CARRY", "CATCH", "CHANGE", "CHILD", "CLOSE", "COVER", "CROSS", "DURING", "EARLY", "EARTH", "EVERY", "FAMILY", "FATHER", "FRIEND", "GARDEN", "GATHER", "HAPPEN", "HARDER", "HORSE", "INSIDE", "LARGE", "LIGHT", "LITTLE", "MOTHER", "MUSIC", "NIGHT", "OFFICE", "OUTSIDE", "PERSON", "PICTURE", "PLACE", "PLANT", "POINT", "POWER", "QUICK", "REACH", "REASON", "RIGHT", "RIVER", "SECOND", "SHOULD", "SISTER", "SMALL", "SOUND", "SPACE", "SPEAK", "STILL", "STORY", "STUDY", "SURFACE", "SYSTEM", "THROUGH", "TOGETHER", "TOWARD", "UNDER", "UNDERSTAND", "WATER", "WOMAN", "WORLD", "WRITE", "WRONG", "YOUNG", "ABOUT", "ABOVE", "AFTER", "AGAIN", "ALONG", "AMONG", "ANOTHER", "ANSWER", "AROUND", "BEFORE", "BEHIND", "BELOW", "BESIDE", "BETTER", "BETWEEN", "BOTTOM", "BREAK", "BRING", "BUILD", "CARRY", "CATCH", "CHANGE", "CHILD", "CLOSE", "COVER", "CROSS", "DURING", "EARLY", "EARTH", "EVERY", "FAMILY", "FATHER", "FRIEND", "GARDEN", "GATHER", "HAPPEN", "HARDER", "HORSE", "INSIDE", "LARGE", "LIGHT", "LITTLE", "MOTHER", "MUSIC", "NIGHT", "OFFICE", "OUTSIDE", "PERSON", "PICTURE", "PLACE", "PLANT", "POINT", "POWER", "QUICK", "REACH", "REASON", "RIGHT", "RIVER", "SECOND", "SHOULD", "SISTER", "SMALL", "SOUND", "SPACE", "SPEAK", "STILL", "STORY", "STUDY", "SURFACE", "SYSTEM", "THROUGH", "TOGETHER", "TOWARD", "UNDER", "UNDERSTAND", "WATER", "WOMAN", "WORLD", "WRITE", "WRONG", "YOUNG",
            
            // 6+ letter words
            "ACCEPT", "ACCESS", "ACROSS", "ACTION", "ACTIVE", "ACTUAL", "ADVICE", "AGAINST", "ALMOST", "ALWAYS", "AMERICA", "ANOTHER", "ANYTHING", "AROUND", "BECAUSE", "BEFORE", "BEHIND", "BELIEVE", "BETTER", "BETWEEN", "BOTTOM", "BREAK", "BRING", "BUILD", "CARRY", "CATCH", "CHANGE", "CHILD", "CLOSE", "COVER", "CROSS", "DURING", "EARLY", "EARTH", "EVERY", "FAMILY", "FATHER", "FRIEND", "GARDEN", "GATHER", "HAPPEN", "HARDER", "HORSE", "INSIDE", "LARGE", "LIGHT", "LITTLE", "MOTHER", "MUSIC", "NIGHT", "OFFICE", "OUTSIDE", "PERSON", "PICTURE", "PLACE", "PLANT", "POINT", "POWER", "QUICK", "REACH", "REASON", "RIGHT", "RIVER", "SECOND", "SHOULD", "SISTER", "SMALL", "SOUND", "SPACE", "SPEAK", "STILL", "STORY", "STUDY", "SURFACE", "SYSTEM", "THROUGH", "TOGETHER", "TOWARD", "UNDER", "UNDERSTAND", "WATER", "WOMAN", "WORLD", "WRITE", "WRONG", "YOUNG", "ACCEPT", "ACCESS", "ACROSS", "ACTION", "ACTIVE", "ACTUAL", "ADVICE", "AGAINST", "ALMOST", "ALWAYS", "AMERICA", "ANOTHER", "ANYTHING", "AROUND", "BECAUSE", "BEFORE", "BEHIND", "BELIEVE", "BETTER", "BETWEEN", "BOTTOM", "BREAK", "BRING", "BUILD", "CARRY", "CATCH", "CHANGE", "CHILD", "CLOSE", "COVER", "CROSS", "DURING", "EARLY", "EARTH", "EVERY", "FAMILY", "FATHER", "FRIEND", "GARDEN", "GATHER", "HAPPEN", "HARDER", "HORSE", "INSIDE", "LARGE", "LIGHT", "LITTLE", "MOTHER", "MUSIC", "NIGHT", "OFFICE", "OUTSIDE", "PERSON", "PICTURE", "PLACE", "PLANT", "POINT", "POWER", "QUICK", "REACH", "REASON", "RIGHT", "RIVER", "SECOND", "SHOULD", "SISTER", "SMALL", "SOUND", "SPACE", "SPEAK", "STILL", "STORY", "STUDY", "SURFACE", "SYSTEM", "THROUGH", "TOGETHER", "TOWARD", "UNDER", "UNDERSTAND", "WATER", "WOMAN", "WORLD", "WRITE", "WRONG", "YOUNG",
            
            // Additional common words
            "ABLE", "ACID", "AGED", "ALSO", "AREA", "ARMY", "AWAY", "BABY", "BACK", "BALL", "BANK", "BASE", "BEST", "BIRD", "BLUE", "BOOK", "BORN", "BOTH", "BUSY", "CALL", "CARD", "CARE", "CITY", "COLD", "COME", "COST", "DEAD", "DEAL", "DOOR", "DOWN", "DROP", "EACH", "EASY", "EDGE", "EVEN", "FACE", "FACT", "FALL", "FARM", "FAST", "FEEL", "FIND", "FINE", "FIRE", "FISH", "FIVE", "FOLD", "FOOD", "FREE", "FROM", "FULL", "GAME", "GAVE", "GIVE", "GOLD", "GONE", "GOOD", "GRAY", "HALF", "HAND", "HARD", "HAVE", "HEAD", "HEAR", "HELP", "HERE", "HIGH", "HOLD", "HOME", "HOPE", "HOUR", "IDEA", "INTO", "KEEP", "KIND", "KNOW", "LAND", "LAST", "LATE", "LEFT", "LIFE", "LINE", "LIVE", "LONG", "LOOK", "LOST", "LOTS", "MADE", "MAIN", "MAKE", "MANY", "MEAN", "MIND", "MISS", "MOVE", "MUCH", "MUST", "NAME", "NEAR", "NEED", "NEXT", "NINE", "ONCE", "ONLY", "OPEN", "OVER", "PART", "PASS", "PAST", "PLAY", "POOR", "PULL", "PUSH", "READ", "REAL", "REST", "RIDE", "ROAD", "ROCK", "ROOM", "SAFE", "SAID", "SAME", "SAVE", "SEEM", "SHOW", "SIDE", "SIGN", "SING", "SIZE", "SLOW", "SOON", "STOP", "SURE", "TAKE", "TALK", "TELL", "THAN", "THAT", "THEM", "THEN", "THEY", "THIS", "TIME", "TURN", "USED", "VERY", "WALK", "WANT", "WARM", "WASH", "WEEK", "WELL", "WENT", "WERE", "WHAT", "WHEN", "WILL", "WIND", "WISH", "WITH", "WORD", "WORK", "YEAR", "YOUR", "ABLE", "ACID", "AGED", "ALSO", "AREA", "ARMY", "AWAY", "BABY", "BACK", "BALL", "BANK", "BASE", "BEST", "BIRD", "BLUE", "BOOK", "BORN", "BOTH", "BUSY", "CALL", "CARD", "CARE", "CITY", "COLD", "COME", "COST", "DEAD", "DEAL", "DOOR", "DOWN", "DROP", "EACH", "EASY", "EDGE", "EVEN", "FACE", "FACT", "FALL", "FARM", "FAST", "FEEL", "FIND", "FINE", "FIRE", "FISH", "FIVE", "FOLD", "FOOD", "FREE", "FROM", "FULL", "GAME", "GAVE", "GIVE", "GOLD", "GONE", "GOOD", "GRAY", "HALF", "HAND", "HARD", "HAVE", "HEAD", "HEAR", "HELP", "HERE", "HIGH", "HOLD", "HOME", "HOPE", "HOUR", "IDEA", "INTO", "KEEP", "KIND", "KNOW", "LAND", "LAST", "LATE", "LEFT", "LIFE", "LINE", "LIVE", "LONG", "LOOK", "LOST", "LOTS", "MADE", "MAIN", "MAKE", "MANY", "MEAN", "MIND", "MISS", "MOVE", "MUCH", "MUST", "NAME", "NEAR", "NEED", "NEXT", "NINE", "ONCE", "ONLY", "OPEN", "OVER", "PART", "PASS", "PAST", "PLAY", "POOR", "PULL", "PUSH", "READ", "REAL", "REST", "RIDE", "ROAD", "ROCK", "ROOM", "SAFE", "SAID", "SAME", "SAVE", "SEEM", "SHOW", "SIDE", "SIGN", "SING", "SIZE", "SLOW", "SOON", "STOP", "SURE", "TAKE", "TALK", "TELL", "THAN", "THAT", "THEM", "THEN", "THEY", "THIS", "TIME", "TURN", "USED", "VERY", "WALK", "WANT", "WARM", "WASH", "WEEK", "WELL", "WENT", "WERE", "WHAT", "WHEN", "WILL", "WIND", "WISH", "WITH", "WORD", "WORK", "YEAR", "YOUR",
            
            // More words for variety
            "ABOUT", "ABOVE", "AFTER", "AGAIN", "ALONG", "AMONG", "ANOTHER", "ANSWER", "AROUND", "BEFORE", "BEHIND", "BELOW", "BESIDE", "BETTER", "BETWEEN", "BOTTOM", "BREAK", "BRING", "BUILD", "CARRY", "CATCH", "CHANGE", "CHILD", "CLOSE", "COVER", "CROSS", "DURING", "EARLY", "EARTH", "EVERY", "FAMILY", "FATHER", "FRIEND", "GARDEN", "GATHER", "HAPPEN", "HARDER", "HORSE", "INSIDE", "LARGE", "LIGHT", "LITTLE", "MOTHER", "MUSIC", "NIGHT", "OFFICE", "OUTSIDE", "PERSON", "PICTURE", "PLACE", "PLANT", "POINT", "POWER", "QUICK", "REACH", "REASON", "RIGHT", "RIVER", "SECOND", "SHOULD", "SISTER", "SMALL", "SOUND", "SPACE", "SPEAK", "STILL", "STORY", "STUDY", "SURFACE", "SYSTEM", "THROUGH", "TOGETHER", "TOWARD", "UNDER", "UNDERSTAND", "WATER", "WOMAN", "WORLD", "WRITE", "WRONG", "YOUNG", "ABOUT", "ABOVE", "AFTER", "AGAIN", "ALONG", "AMONG", "ANOTHER", "ANSWER", "AROUND", "BEFORE", "BEHIND", "BELOW", "BESIDE", "BETTER", "BETWEEN", "BOTTOM", "BREAK", "BRING", "BUILD", "CARRY", "CATCH", "CHANGE", "CHILD", "CLOSE", "COVER", "CROSS", "DURING", "EARLY", "EARTH", "EVERY", "FAMILY", "FATHER", "FRIEND", "GARDEN", "GATHER", "HAPPEN", "HARDER", "HORSE", "INSIDE", "LARGE", "LIGHT", "LITTLE", "MOTHER", "MUSIC", "NIGHT", "OFFICE", "OUTSIDE", "PERSON", "PICTURE", "PLACE", "PLANT", "POINT", "POWER", "QUICK", "REACH", "REASON", "RIGHT", "RIVER", "SECOND", "SHOULD", "SISTER", "SMALL", "SOUND", "SPACE", "SPEAK", "STILL", "STORY", "STUDY", "SURFACE", "SYSTEM", "THROUGH", "TOGETHER", "TOWARD", "UNDER", "UNDERSTAND", "WATER", "WOMAN", "WORLD", "WRITE", "WRONG", "YOUNG"
        ]
        
        HatchCoopClickerValidWords = Set(HatchCoopClickerPopularWords.map { $0.uppercased() })
    }
    
    private func HatchCoopClickerGenerateLetters() {
        let HatchCoopClickerVowels = ["A", "E", "I", "O", "U"]
        let HatchCoopClickerConsonants = ["B", "C", "D", "F", "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "V", "W", "X", "Y", "Z"]
        
        HatchCoopClickerLetters = []
        
        // Generate exactly 10 letters (2 rows of 5)
        for _ in 0..<4 {
            HatchCoopClickerLetters.append(HatchCoopClickerVowels.randomElement()!)
        }
        
        for _ in 0..<6 {
            HatchCoopClickerLetters.append(HatchCoopClickerConsonants.randomElement()!)
        }
        
        HatchCoopClickerLetters.shuffle()
        
        // Ensure we have exactly 10 unique letters
        var HatchCoopClickerUniqueLetters: [String] = []
        for letter in HatchCoopClickerLetters {
            if !HatchCoopClickerUniqueLetters.contains(letter) && HatchCoopClickerUniqueLetters.count < 10 {
                HatchCoopClickerUniqueLetters.append(letter)
            }
        }
        
        // If we don't have 10 unique letters, add more
        while HatchCoopClickerUniqueLetters.count < 10 {
            let allLetters = HatchCoopClickerVowels + HatchCoopClickerConsonants
            let randomLetter = allLetters.randomElement()!
            if !HatchCoopClickerUniqueLetters.contains(randomLetter) {
                HatchCoopClickerUniqueLetters.append(randomLetter)
            }
        }
        
        HatchCoopClickerLetters = HatchCoopClickerUniqueLetters
        HatchCoopClickerLettersCollectionView.reloadData()
    }
    
    private func HatchCoopClickerStartTimer() {
        HatchCoopClickerTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.HatchCoopClickerUpdateTimer()
        }
    }
    
    private func HatchCoopClickerUpdateTimer() {
        HatchCoopClickerTimeRemaining -= 1
        HatchCoopClickerTimeLabel.text = "⏰ Time: \(HatchCoopClickerTimeRemaining)s"
        
        if HatchCoopClickerTimeRemaining <= 10 {
            HatchCoopClickerTimeLabel.textColor = UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0)
        }
        
        if HatchCoopClickerTimeRemaining <= 0 {
            HatchCoopClickerEndGame()
        }
    }
    
    @objc private func HatchCoopClickerSubmitWord() {
        guard HatchCoopClickerCurrentWord.count >= 2 else { return }
        
        // Check if word is valid
        if !HatchCoopClickerValidWords.contains(HatchCoopClickerCurrentWord.uppercased()) {
            HatchCoopClickerClearWord()
            return
        }
        
        if !HatchCoopClickerFoundWords.contains(HatchCoopClickerCurrentWord) {
            HatchCoopClickerFoundWords.append(HatchCoopClickerCurrentWord)
            HatchCoopClickerUpdateFoundWordsLabel()
            
            UIView.animate(withDuration: 0.3) {
                self.HatchCoopClickerCurrentWordLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            } completion: { _ in
                UIView.animate(withDuration: 0.2) {
                    self.HatchCoopClickerCurrentWordLabel.transform = .identity
                }
            }
        } else {
            HatchCoopClickerShowAlreadyFoundAlert()
            HatchCoopClickerClearWord()
        }
        
        HatchCoopClickerClearWord()
    }
    
    private func HatchCoopClickerShowInvalidWordAlert() {
        // Shake animation for invalid word
        UIView.animate(withDuration: 0.1, animations: {
            self.HatchCoopClickerCurrentWordLabel.transform = CGAffineTransform(translationX: -10, y: 0)
        }) { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.HatchCoopClickerCurrentWordLabel.transform = CGAffineTransform(translationX: 10, y: 0)
            }) { _ in
                UIView.animate(withDuration: 0.1) {
                    self.HatchCoopClickerCurrentWordLabel.transform = .identity
                }
            }
        }
    }
    
    private func HatchCoopClickerShowAlreadyFoundAlert() {
        let alert = UIAlertController(title: "🔄 Already Found", message: "You've already found this word!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func HatchCoopClickerClearWord() {
        HatchCoopClickerCurrentWord = ""
        HatchCoopClickerCurrentWordLabel.text = "Tap letters to form words!"
        HatchCoopClickerSubmitButton.isEnabled = false
        HatchCoopClickerLettersCollectionView.reloadData()
    }
    
    private func HatchCoopClickerUpdateFoundWordsLabel() {
        if HatchCoopClickerFoundWords.isEmpty {
            HatchCoopClickerFoundWordsLabel.text = "Found words will appear here"
        } else {
            let HatchCoopClickerFormattedWords = HatchCoopClickerFoundWords.map { "✨ \($0)" }.joined(separator: "  ")
            HatchCoopClickerFoundWordsLabel.text = "Found words:\n\(HatchCoopClickerFormattedWords)"
        }
    }
    
    private func HatchCoopClickerEndGame() {
        HatchCoopClickerTimer?.invalidate()
        
        // Increment Word Builder games played counter
        let HatchCoopClickerSharedGameData = HatchCoopClickerGameData.HatchCoopClickerShared
        HatchCoopClickerSharedGameData.HatchCoopClickerWordBuilderGamesPlayed += 1
        
        let HatchCoopClickerCoinsEarned = HatchCoopClickerFoundWords.count * 5
        let HatchCoopClickerXPEarned = HatchCoopClickerFoundWords.count * 10
        
        let HatchCoopClickerResultVC = HatchCoopClickerGameResultVC()
        HatchCoopClickerResultVC.HatchCoopClickerIsWin = HatchCoopClickerFoundWords.count > 0
        HatchCoopClickerResultVC.HatchCoopClickerCoinsEarned = HatchCoopClickerCoinsEarned
        HatchCoopClickerResultVC.HatchCoopClickerXPEarned = HatchCoopClickerXPEarned
        HatchCoopClickerResultVC.HatchCoopClickerGameName = "Word Builder"
        HatchCoopClickerResultVC.HatchCoopClickerOnContinue = { [weak self] in
            self?.HatchCoopClickerOnGameCompleted?(HatchCoopClickerCoinsEarned, HatchCoopClickerXPEarned)
            self?.navigationController?.popViewController(animated: true)
        }
        
        HatchCoopClickerResultVC.modalPresentationStyle = .overFullScreen
        present(HatchCoopClickerResultVC, animated: true)
    }
}

extension HatchCoopClickerWordGameVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HatchCoopClickerLetters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HatchCoopClickerLetterCell", for: indexPath) as! HatchCoopClickerLetterCell
        let letter = HatchCoopClickerLetters[indexPath.item]
        // Don't mark letters as used since we allow multiple uses
        cell.HatchCoopClickerConfigure(with: letter, isUsed: false)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let letter = HatchCoopClickerLetters[indexPath.item]
        
        // Allow using the same letter multiple times
        HatchCoopClickerCurrentWord += letter
        HatchCoopClickerCurrentWordLabel.text = HatchCoopClickerCurrentWord
        HatchCoopClickerSubmitButton.isEnabled = HatchCoopClickerCurrentWord.count >= 2
        HatchCoopClickerLettersCollectionView.reloadData()
    }
} 