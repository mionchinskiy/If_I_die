

import Foundation
import UIKit



class IAmConfidantTableViewCell: UITableViewCell {
    
    var delegate: ForConfidantsTableViewCellDelegate?
    
    private lazy var viewForConfidants = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var confidantLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Люди, попросившие вас проинформировать сервис в случае их смерти:"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var confidantAllDataButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white//.systemGray5
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.systemBrown.cgColor
        button.layer.borderWidth = 2
        button.setTitleColor(.systemBrown, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitle("Доверевшиеся вам пользователи", for: .normal)
        button.addTarget(self, action: #selector(tapAllConfidantButton), for: .touchUpInside)
        return button
    }()

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupView() {
        contentView.addSubview(viewForConfidants)
        viewForConfidants.addSubview(confidantLabel)
        viewForConfidants.addSubview(confidantAllDataButton)
       
  
        NSLayoutConstraint.activate([viewForConfidants.topAnchor.constraint(equalTo: contentView.topAnchor),
                                     viewForConfidants.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
                                     viewForConfidants.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
                                     viewForConfidants.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                                     
                                     
                                     confidantLabel.topAnchor.constraint(equalTo: viewForConfidants.safeAreaLayoutGuide.topAnchor, constant: 15),
                                     confidantLabel.leadingAnchor.constraint(equalTo: viewForConfidants.safeAreaLayoutGuide.leadingAnchor, constant: 15),
                                     confidantLabel.trailingAnchor.constraint(equalTo: viewForConfidants.safeAreaLayoutGuide.trailingAnchor, constant: -15),

                                     
                                     confidantAllDataButton.topAnchor.constraint(equalTo: confidantLabel.bottomAnchor, constant: 10),
                                     confidantAllDataButton.heightAnchor.constraint(equalToConstant: 50),
                                     confidantAllDataButton.leadingAnchor.constraint(equalTo: viewForConfidants.safeAreaLayoutGuide.leadingAnchor, constant: 10),
                                     confidantAllDataButton.trailingAnchor.constraint(equalTo: viewForConfidants.safeAreaLayoutGuide.trailingAnchor, constant: -10),
                                     confidantAllDataButton.bottomAnchor.constraint(equalTo: viewForConfidants.bottomAnchor, constant: -10),
                                    ])

    }
    
    
    @objc func tapAllConfidantButton() {
        delegate?.tapConfidantAllDataButton()
    }
    
    
    func setupContent(with will: Will) {

        
        
    }
    
    

}
