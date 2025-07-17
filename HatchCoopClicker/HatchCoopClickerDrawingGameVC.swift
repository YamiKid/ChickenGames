import UIKit

class HatchCoopClickerDrawingGameVC: UIViewController {
    
    var HatchCoopClickerOnGameCompleted: ((Int, Int) -> Void)?
    
    private var HatchCoopClickerLastPoint: CGPoint = .zero
    private var HatchCoopClickerBrushSize: CGFloat = 5.0
    private var HatchCoopClickerBrushColor: UIColor = .black
    private var HatchCoopClickerDrawingStarted: Bool = false
    private var HatchCoopClickerStrokeCount: Int = 0
    
    private lazy var HatchCoopClickerCanvasView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var HatchCoopClickerColorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var HatchCoopClickerSizeSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 20
        slider.value = 5
        slider.addTarget(self, action: #selector(HatchCoopClickerSizeChanged), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private lazy var HatchCoopClickerSizeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0)
        label.text = "Brush Size: 5"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerSaveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save Drawing", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(HatchCoopClickerSaveDrawing), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var HatchCoopClickerClearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Clear Canvas", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(HatchCoopClickerClearCanvas), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var HatchCoopClickerStrokeCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0)
        label.text = "Strokes: 0"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HatchCoopClickerSetupUI()
        HatchCoopClickerSetupColors()
    }
    
    private func HatchCoopClickerSetupUI() {
        view.backgroundColor = UIColor(red: 1.0, green: 0.95, blue: 0.88, alpha: 1.0)
        title = "🎨 Drawing Canvas"
        
        view.addSubview(HatchCoopClickerCanvasView)
        view.addSubview(HatchCoopClickerColorStackView)
        view.addSubview(HatchCoopClickerSizeSlider)
        view.addSubview(HatchCoopClickerSizeLabel)
        view.addSubview(HatchCoopClickerSaveButton)
        view.addSubview(HatchCoopClickerClearButton)
        view.addSubview(HatchCoopClickerStrokeCountLabel)
        
        NSLayoutConstraint.activate([
            HatchCoopClickerCanvasView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            HatchCoopClickerCanvasView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            HatchCoopClickerCanvasView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            HatchCoopClickerCanvasView.heightAnchor.constraint(equalToConstant: 400),
            
            HatchCoopClickerColorStackView.topAnchor.constraint(equalTo: HatchCoopClickerCanvasView.bottomAnchor, constant: 20),
            HatchCoopClickerColorStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            HatchCoopClickerColorStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            HatchCoopClickerColorStackView.heightAnchor.constraint(equalToConstant: 40),
            
            HatchCoopClickerSizeLabel.topAnchor.constraint(equalTo: HatchCoopClickerColorStackView.bottomAnchor, constant: 15),
            HatchCoopClickerSizeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            HatchCoopClickerSizeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            HatchCoopClickerSizeSlider.topAnchor.constraint(equalTo: HatchCoopClickerSizeLabel.bottomAnchor, constant: 10),
            HatchCoopClickerSizeSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            HatchCoopClickerSizeSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            HatchCoopClickerStrokeCountLabel.topAnchor.constraint(equalTo: HatchCoopClickerSizeSlider.bottomAnchor, constant: 15),
            HatchCoopClickerStrokeCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            HatchCoopClickerStrokeCountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            HatchCoopClickerSaveButton.topAnchor.constraint(equalTo: HatchCoopClickerStrokeCountLabel.bottomAnchor, constant: 20),
            HatchCoopClickerSaveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            HatchCoopClickerSaveButton.widthAnchor.constraint(equalToConstant: 120),
            HatchCoopClickerSaveButton.heightAnchor.constraint(equalToConstant: 40),
            
            HatchCoopClickerClearButton.topAnchor.constraint(equalTo: HatchCoopClickerStrokeCountLabel.bottomAnchor, constant: 20),
            HatchCoopClickerClearButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            HatchCoopClickerClearButton.widthAnchor.constraint(equalToConstant: 120),
            HatchCoopClickerClearButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        let HatchCoopClickerPanGesture = UIPanGestureRecognizer(target: self, action: #selector(HatchCoopClickerHandlePan(_:)))
        HatchCoopClickerCanvasView.addGestureRecognizer(HatchCoopClickerPanGesture)
    }
    
    private func HatchCoopClickerSetupColors() {
        let HatchCoopClickerColors: [UIColor] = [.black, .red, .blue, .green, .yellow, .purple, .orange, .brown]
        
        for color in HatchCoopClickerColors {
            let HatchCoopClickerColorButton = UIButton(type: .system)
            HatchCoopClickerColorButton.backgroundColor = color
            HatchCoopClickerColorButton.layer.cornerRadius = 15
            HatchCoopClickerColorButton.layer.borderWidth = 2
            HatchCoopClickerColorButton.layer.borderColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0).cgColor
            HatchCoopClickerColorButton.addTarget(self, action: #selector(HatchCoopClickerColorSelected(_:)), for: .touchUpInside)
            HatchCoopClickerColorButton.translatesAutoresizingMaskIntoConstraints = false
            
            HatchCoopClickerColorStackView.addArrangedSubview(HatchCoopClickerColorButton)
            
            HatchCoopClickerColorButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
            HatchCoopClickerColorButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        }
    }
    
    @objc private func HatchCoopClickerColorSelected(_ sender: UIButton) {
        HatchCoopClickerBrushColor = sender.backgroundColor ?? .black
        
        for subview in HatchCoopClickerColorStackView.arrangedSubviews {
            if let button = subview as? UIButton {
                button.layer.borderWidth = 2
                button.layer.borderColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0).cgColor
            }
        }
        
        sender.layer.borderWidth = 4
        sender.layer.borderColor = UIColor.white.cgColor
    }
    
    @objc private func HatchCoopClickerSizeChanged() {
        HatchCoopClickerBrushSize = CGFloat(HatchCoopClickerSizeSlider.value)
        HatchCoopClickerSizeLabel.text = "Brush Size: \(Int(HatchCoopClickerBrushSize))"
    }
    
    @objc private func HatchCoopClickerHandlePan(_ gesture: UIPanGestureRecognizer) {
        let HatchCoopClickerPoint = gesture.location(in: HatchCoopClickerCanvasView)
        
        switch gesture.state {
        case .began:
            HatchCoopClickerLastPoint = HatchCoopClickerPoint
            HatchCoopClickerDrawingStarted = true
            HatchCoopClickerStrokeCount += 1
            HatchCoopClickerStrokeCountLabel.text = "Strokes: \(HatchCoopClickerStrokeCount)"
            
        case .changed:
            if HatchCoopClickerDrawingStarted {
                HatchCoopClickerDrawLine(from: HatchCoopClickerLastPoint, to: HatchCoopClickerPoint)
                HatchCoopClickerLastPoint = HatchCoopClickerPoint
            }
            
        case .ended:
            HatchCoopClickerDrawingStarted = false
            
        default:
            break
        }
    }
    
    private func HatchCoopClickerDrawLine(from startPoint: CGPoint, to endPoint: CGPoint) {
        let HatchCoopClickerPath = UIBezierPath()
        HatchCoopClickerPath.move(to: startPoint)
        HatchCoopClickerPath.addLine(to: endPoint)
        
        let HatchCoopClickerShapeLayer = CAShapeLayer()
        HatchCoopClickerShapeLayer.path = HatchCoopClickerPath.cgPath
        HatchCoopClickerShapeLayer.strokeColor = HatchCoopClickerBrushColor.cgColor
        HatchCoopClickerShapeLayer.lineWidth = HatchCoopClickerBrushSize
        HatchCoopClickerShapeLayer.lineCap = .round
        HatchCoopClickerShapeLayer.fillColor = nil
        
        HatchCoopClickerCanvasView.layer.addSublayer(HatchCoopClickerShapeLayer)
    }
    
    @objc private func HatchCoopClickerSaveDrawing() {
        let HatchCoopClickerCoinsEarned = HatchCoopClickerStrokeCount * 2
        let HatchCoopClickerXPEarned = HatchCoopClickerStrokeCount * 5
        
        let HatchCoopClickerResultVC = HatchCoopClickerGameResultVC()
        HatchCoopClickerResultVC.HatchCoopClickerIsWin = HatchCoopClickerStrokeCount > 0
        HatchCoopClickerResultVC.HatchCoopClickerCoinsEarned = HatchCoopClickerCoinsEarned
        HatchCoopClickerResultVC.HatchCoopClickerXPEarned = HatchCoopClickerXPEarned
        HatchCoopClickerResultVC.HatchCoopClickerGameName = "Drawing Canvas"
        HatchCoopClickerResultVC.HatchCoopClickerOnContinue = { [weak self] in
            self?.HatchCoopClickerOnGameCompleted?(HatchCoopClickerCoinsEarned, HatchCoopClickerXPEarned)
            self?.navigationController?.popViewController(animated: true)
        }
        
        HatchCoopClickerResultVC.modalPresentationStyle = .overFullScreen
        present(HatchCoopClickerResultVC, animated: true)
    }
    
    @objc private func HatchCoopClickerClearCanvas() {
        HatchCoopClickerCanvasView.layer.sublayers?.removeAll()
        HatchCoopClickerStrokeCount = 0
        HatchCoopClickerStrokeCountLabel.text = "Strokes: 0"
    }
} 