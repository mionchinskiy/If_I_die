

import UIKit

class ProfileViewController: UIViewController {
    
    let user: User
    
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
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        auth(user: user)
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
    
    func auth(user: User) {
        name.text = user.userId
        surname.text = user.messages[0].lastEditDate.toString(dateFormat: "dd.MM.yyyy - hh:mm")
        email.text = user.email
        password.text = user.password
        
        
    }
    

}
