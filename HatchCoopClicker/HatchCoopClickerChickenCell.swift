import UIKit

class HatchCoopClickerChickenCell: UICollectionViewCell {
    
    private lazy var HatchCoopClickerEmojiLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerRarityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
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
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 2)
        
        contentView.addSubview(HatchCoopClickerEmojiLabel)
        contentView.addSubview(HatchCoopClickerNameLabel)
        contentView.addSubview(HatchCoopClickerRarityLabel)
        
        NSLayoutConstraint.activate([
            HatchCoopClickerEmojiLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            HatchCoopClickerEmojiLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            HatchCoopClickerNameLabel.topAnchor.constraint(equalTo: HatchCoopClickerEmojiLabel.bottomAnchor, constant: 5),
            HatchCoopClickerNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            HatchCoopClickerNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            HatchCoopClickerRarityLabel.topAnchor.constraint(equalTo: HatchCoopClickerNameLabel.bottomAnchor, constant: 2),
            HatchCoopClickerRarityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            HatchCoopClickerRarityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            HatchCoopClickerRarityLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func HatchCoopClickerConfigure(with chicken: HatchCoopClickerChicken) {
        HatchCoopClickerEmojiLabel.text = chicken.HatchCoopClickerEmoji
        HatchCoopClickerNameLabel.text = chicken.HatchCoopClickerName
        HatchCoopClickerRarityLabel.text = chicken.HatchCoopClickerRarity
    }
} 