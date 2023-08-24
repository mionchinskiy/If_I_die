import UIKit

class WillForMeTableViewCell: UITableViewCell {

    
    lazy var view = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    lazy var author = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.italicSystemFont(ofSize: 13)
        label.textColor = .systemGray
        label.numberOfLines = 1
        label.textAlignment = .right
        return label
    }()
    
    lazy var title = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 13)
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
        view.addSubview(author)
        view.addSubview(numberOfPeopleForSend)
  
        NSLayoutConstraint.activate([view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
                                     view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
                                     view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
                                     view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
                                     
                                     author.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
                                     author.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                                     
                                     title.topAnchor.constraint(equalTo: author.bottomAnchor, constant: 7),
                                     title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                                     title.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                                     
                                     text.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
                                     text.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                                     text.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                                     
                                     numberOfPeopleForSend.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 10),
                                     numberOfPeopleForSend.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
                                     numberOfPeopleForSend.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                                     numberOfPeopleForSend.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
                                    ])

    }
    
    func setupContent(with message: Message) {
        title.text = message.title
        text.text = message.text
        author.text = "Михаил Костюшенков:"
        numberOfPeopleForSend.text = "26.10.1990"
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
