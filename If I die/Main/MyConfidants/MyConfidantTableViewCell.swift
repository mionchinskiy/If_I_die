

import UIKit

class MyConfidantTableViewCell: UITableViewCell {
    
    lazy var view = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var name = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 5
        return label
    }()
    
    lazy var email = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemGray
        label.numberOfLines = 5
        return label
    }()
    
    lazy var state = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .systemGray
        label.numberOfLines = 3
        return label
    }()

    lazy var `switch` = {
        let `switch` = UISwitch()
        `switch`.translatesAutoresizingMaskIntoConstraints = false
        `switch`.isHidden = true
        return `switch`
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupStandartView() {
        
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.systemBrown.cgColor
        contentView.addSubview(view)
        view.addSubview(name)
        view.addSubview(email)
        view.addSubview(state)
        view.addSubview(`switch`)
  
        NSLayoutConstraint.activate([view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
                                     view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
                                     view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
                                     view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
                                     
                                     name.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
                                     name.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                                     name.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5),
                                     
                                     email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5),
                                     email.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                                     email.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5),
                                     
                                     state.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 5),
                                     state.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                                     state.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
                                     state.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
                                     
                                     `switch`.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     `switch`.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
                                    ])

    }
    
//    func setupContent(withConfidant confidantEmail: String, forUser user: User) {
//        email.text = confidantEmail
//
//    }
    
    func setupAddConfidantView() {
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        contentView.addSubview(view)
        
        
        let addImage = UIImageView(image: UIImage(systemName: "person.crop.circle.badge.plus"))
        addImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(addImage)
        NSLayoutConstraint.activate([view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
                                     view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
                                     view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
                                     view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
                                     
                                     addImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     addImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     addImage.heightAnchor.constraint(equalToConstant: 50),
                                     addImage.widthAnchor.constraint(equalTo: addImage.heightAnchor),
                                     addImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
                                     addImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15),

                                    ])
    }

}
