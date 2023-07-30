

import UIKit

class MyWillTableViewCell: UITableViewCell {

    
    lazy var view = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var title = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var text = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    lazy var dateForSend = {
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
        view.layer.borderColor = UIColor.systemCyan.cgColor
        contentView.addSubview(view)
        view.addSubview(title)
        view.addSubview(text)
        view.addSubview(dateForSend)
  
        NSLayoutConstraint.activate([view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
                                     view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
                                     view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
                                     view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
                                     
                                     title.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
                                     title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
                                     title.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5),
                                     
                                     text.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
                                     text.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
                                     text.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5),
                                     
                                     dateForSend.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 5),
                                     dateForSend.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
                                     dateForSend.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5),
                                     dateForSend.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5)
                                    ])

    }
    
    func setupContent(with will: Will) {
        title.text = will.title
        text.text = will.text
        dateForSend.text = "\(will.dateForSend)"
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
