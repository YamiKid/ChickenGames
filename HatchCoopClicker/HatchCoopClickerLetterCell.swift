import UIKit

class HatchCoopClickerLetterCell: UICollectionViewCell {
    
    private lazy var HatchCoopClickerLetterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 2)
        
        contentView.addSubview(HatchCoopClickerLetterLabel)
        
        NSLayoutConstraint.activate([
            HatchCoopClickerLetterLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            HatchCoopClickerLetterLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func HatchCoopClickerConfigure(with letter: String, isUsed: Bool) {
        HatchCoopClickerLetterLabel.text = letter
        
        if isUsed {
            backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
            HatchCoopClickerLetterLabel.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
            layer.borderColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0).cgColor
            layer.shadowOpacity = 0.05
        } else {
            backgroundColor = UIColor(red: 1.0, green: 0.98, blue: 0.95, alpha: 1.0)
            HatchCoopClickerLetterLabel.textColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0)
            layer.borderColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0).cgColor
            layer.shadowOpacity = 0.1
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.1) {
            self.transform = .identity
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        UIView.animate(withDuration: 0.1) {
            self.transform = .identity
        }
    }
} 