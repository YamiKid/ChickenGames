import UIKit

class HatchCoopClickerFactCell: UICollectionViewCell {
    
    private lazy var HatchCoopClickerCardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1.0, green: 0.98, blue: 0.95, alpha: 1.0)
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 8
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var HatchCoopClickerEmojiLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(red: 0.55, green: 0.43, blue: 0.39, alpha: 1.0)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HatchCoopClickerDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
        label.textAlignment = .center
        label.numberOfLines = 3
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
        contentView.addSubview(HatchCoopClickerCardView)
        HatchCoopClickerCardView.addSubview(HatchCoopClickerEmojiLabel)
        HatchCoopClickerCardView.addSubview(HatchCoopClickerTitleLabel)
        HatchCoopClickerCardView.addSubview(HatchCoopClickerDescriptionLabel)
        
        NSLayoutConstraint.activate([
            HatchCoopClickerCardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            HatchCoopClickerCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            HatchCoopClickerCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            HatchCoopClickerCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            HatchCoopClickerEmojiLabel.topAnchor.constraint(equalTo: HatchCoopClickerCardView.topAnchor, constant: 15),
            HatchCoopClickerEmojiLabel.centerXAnchor.constraint(equalTo: HatchCoopClickerCardView.centerXAnchor),
            
            HatchCoopClickerTitleLabel.topAnchor.constraint(equalTo: HatchCoopClickerEmojiLabel.bottomAnchor, constant: 10),
            HatchCoopClickerTitleLabel.leadingAnchor.constraint(equalTo: HatchCoopClickerCardView.leadingAnchor, constant: 10),
            HatchCoopClickerTitleLabel.trailingAnchor.constraint(equalTo: HatchCoopClickerCardView.trailingAnchor, constant: -10),
            
            HatchCoopClickerDescriptionLabel.topAnchor.constraint(equalTo: HatchCoopClickerTitleLabel.bottomAnchor, constant: 8),
            HatchCoopClickerDescriptionLabel.leadingAnchor.constraint(equalTo: HatchCoopClickerCardView.leadingAnchor, constant: 10),
            HatchCoopClickerDescriptionLabel.trailingAnchor.constraint(equalTo: HatchCoopClickerCardView.trailingAnchor, constant: -10),
            HatchCoopClickerDescriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: HatchCoopClickerCardView.bottomAnchor, constant: -15)
        ])
    }
    
    func HatchCoopClickerConfigure(with fact: HatchCoopClickerHatcheryVC.HatchCoopClickerChickenFact) {
        HatchCoopClickerEmojiLabel.text = fact.emoji
        HatchCoopClickerTitleLabel.text = fact.title
        HatchCoopClickerDescriptionLabel.text = fact.shortDescription
    }
} 