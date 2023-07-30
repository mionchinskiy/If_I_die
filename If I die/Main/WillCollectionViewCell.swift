

import UIKit

class WillCollectionViewCell: UICollectionViewCell {
    
    
    private lazy var nameLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 1
            
            return label
    }()
    
    private lazy var emailLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 1
        label.font = UIFont.italicSystemFont(ofSize: 12)
            return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.systemGray3.cgColor

        contentView.backgroundColor = .white
        
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(emailLabel)
        
        NSLayoutConstraint.activate([nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
                                     nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
                                    
                                     emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
                                     emailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
                                    ])
    }
    
    func setupContent(name: String, email: String) {
        nameLabel.text = name
        emailLabel.text = email
    }
    
    
}
