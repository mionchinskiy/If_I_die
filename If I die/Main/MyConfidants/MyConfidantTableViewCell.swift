

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
        return label
    }()
    
    lazy var email = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    lazy var state = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
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
  
        NSLayoutConstraint.activate([view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
                                     view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
                                     view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
                                     view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
                                     
                                     name.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
                                     name.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
                                     name.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5),
                                     
                                     email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5),
                                     email.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
                                     email.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5),
                                     
                                     state.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 5),
                                     state.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
                                     state.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5),
                                     state.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5)
                                    ])

    }
    
    func setupContent(with confidant: Confidant) {
        name.text = confidant.name
        email.text = confidant.email
        
        guard confidant.isRegistred else {
            state.text = "Ожидаем регистрации пользователя"
            return
        }
        
        guard confidant.isConfirmedParticipationForYou else {
            state.text = "Пользователь еще не подтвердил что выступит вашим доверенным лицом"
            return
        }
        
        state.text = "Пользователь является вашим доверенным лицом"
    }
    
    func setupAddConfidantView() {
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.systemBrown.cgColor
        
        
        let addImage = UIImageView(image: UIImage(systemName: "person.crop.circle.badge.plus"))
        addImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(addImage)
        NSLayoutConstraint.activate([addImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                                     addImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                                     addImage.heightAnchor.constraint(equalToConstant: 70),
                                     addImage.widthAnchor.constraint(equalTo: addImage.heightAnchor),
                                     addImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
                                     addImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),

                                    ])
    }

}
