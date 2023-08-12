

import UIKit

class WillForMeTableViewCell: UITableViewCell {

    
    lazy var view = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    lazy var title = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 2

        return label
    }()
    
    lazy var text = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 8
        return label
    }()
    
    lazy var numberOfPeopleForSend = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.italicSystemFont(ofSize: 12)
        label.textColor = .systemGray
        label.numberOfLines = 1
        return label
    }()
    
    lazy var dateForSend = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.italicSystemFont(ofSize: 12)
        label.textColor = .systemGray
        label.numberOfLines = 1
        label.textAlignment = .right
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
        
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.systemCyan.cgColor
        contentView.backgroundColor = .systemGray6
        view.backgroundColor = .white
        contentView.addSubview(view)
        view.addSubview(title)
        view.addSubview(text)
        view.addSubview(dateForSend)
        view.addSubview(numberOfPeopleForSend)
  
        NSLayoutConstraint.activate([view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
                                     view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
                                     view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
                                     view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
                                     //view.heightAnchor.constraint(equalToConstant: 200),
                                     
                                     title.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
                                     title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                                     title.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                                     
                                     text.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
                                     text.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                                     text.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                                     
                                     dateForSend.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 10),
                                     //dateForSend.heightAnchor.constraint(equalToConstant: 20),
                                     dateForSend.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
                                     dateForSend.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                                     dateForSend.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
                                     
                                     numberOfPeopleForSend.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
                                     numberOfPeopleForSend.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                                     numberOfPeopleForSend.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
                                    ])

    }
    
    func setupContent(with message: Message) {
        title.text = message.title
        text.text = message.text
        dateForSend.text = "на \(message.daysAfterDeathToSend) день"
        numberOfPeopleForSend.text = "для \(message.whomToSend.count) адресатов"
    }
    
    func setupAddConfidantView() {
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.systemCyan.cgColor
        contentView.backgroundColor = .systemGray6
        view.backgroundColor = .white
        contentView.addSubview(view)

        
        let addImage = UIImageView(image: UIImage(systemName: "plus.circle"))
        addImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addImage)
        NSLayoutConstraint.activate([view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
                                     view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
                                     view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
                                     view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
                                     //view.heightAnchor.constraint(equalToConstant: 200),

                                     
                                     addImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     addImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     addImage.heightAnchor.constraint(equalToConstant: 50),
                                     addImage.widthAnchor.constraint(equalTo: addImage.heightAnchor),
                                     addImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
                                     addImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),



                                    ])
    }

}
