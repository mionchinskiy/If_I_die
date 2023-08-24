
import UIKit




class HeaderForMyWills: UITableViewHeaderFooterView {
    
    let label = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Напишите сообщения, которые начнут рассылаться в случае вашей смерти:"
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    

    
    func setupView() {
        contentView.backgroundColor = .systemGray6
        contentView.addSubview(label)

        
        NSLayoutConstraint.activate([label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
                                     label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                                     label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
                                     label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
                                    ])
    }

    
}



