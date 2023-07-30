

import UIKit

class ProfileViewController: UIViewController {
    
    lazy var name = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var surname = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    lazy var email = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var password = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        auth(user: confidants[0])
    }

    private func setupView() {
        
        for subview in [name,
                        surname,
                        email,
                        password] {view.addSubview(subview)}

        NSLayoutConstraint.activate([name.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
                                     name.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                                     
                                     surname.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10),
                                     surname.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                                     
                                     email.topAnchor.constraint(equalTo: surname.bottomAnchor, constant: 10),
                                     email.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                                     
                                     password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 10),
                                     password.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                                    ])
    }
    
    func auth(user: Confidant) {
        name.text = user.name
        surname.text = user.name
        email.text = user.email
        password.text = "\(user.isRegistred)"
        
        
    }
    

}
