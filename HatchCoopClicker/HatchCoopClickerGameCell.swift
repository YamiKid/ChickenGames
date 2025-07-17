import UIKit

class HatchCoopClickerGameCell: UICollectionViewCell {
    
    private lazy var HatchCoopClickerEmojiLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
        label.textAlignment = .center
        label.numberOfLines = 2
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
        layer.cornerRadius = 15
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 6
        layer.shadowOffset = CGSize(width: 0, height: 3)
        
        contentView.addSubview(HatchCoopClickerEmojiLabel)
        contentView.addSubview(HatchCoopClickerNameLabel)
        contentView.addSubview(HatchCoopClickerDescriptionLabel)
        
        NSLayoutConstraint.activate([
            HatchCoopClickerEmojiLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            HatchCoopClickerEmojiLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            HatchCoopClickerNameLabel.topAnchor.constraint(equalTo: HatchCoopClickerEmojiLabel.bottomAnchor, constant: 8),
            HatchCoopClickerNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            HatchCoopClickerNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            HatchCoopClickerDescriptionLabel.topAnchor.constraint(equalTo: HatchCoopClickerNameLabel.bottomAnchor, constant: 4),
            HatchCoopClickerDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            HatchCoopClickerDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            HatchCoopClickerDescriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -15)
        ])
    }
    
    func HatchCoopClickerConfigure(with game: HatchCoopClickerGame) {
        HatchCoopClickerEmojiLabel.text = game.HatchCoopClickerEmoji
        HatchCoopClickerNameLabel.text = game.HatchCoopClickerName
        HatchCoopClickerDescriptionLabel.text = game.HatchCoopClickerDescription
    }
} 