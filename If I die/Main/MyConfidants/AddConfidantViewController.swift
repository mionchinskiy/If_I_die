

import UIKit

class AddConfidantViewController: UIViewController {
    
    let delegate: AddConfidantDelegate
    
    lazy var sendInviteTitle = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Пригласите близкого человека стать вашим доверенным лицом. В случае вашей смерти он должен будет подтвердить этот печальный факт в приложении"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    
//    lazy var nameField = {
//        let textField = UITextField()
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.placeholder = "Имя Фамилия"
//        textField.borderStyle = .bezel
//        return textField
//    }()
    
    
    lazy var emailField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "email"
        textField.borderStyle = .bezel
        return textField
    }()
    
    lazy var sendButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Отправить приглашение", for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(tapSendButton), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var errorLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(delegate: AddConfidantDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(sendInviteTitle)
        view.addSubview(stackView)
        //stackView.addArrangedSubview(nameField)
        stackView.addArrangedSubview(emailField)
        stackView.addArrangedSubview(sendButton)
        stackView.addArrangedSubview(errorLabel)
        
        NSLayoutConstraint.activate([sendInviteTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
                                     sendInviteTitle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
                                     sendInviteTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     
                                     stackView.topAnchor.constraint(equalTo: sendInviteTitle.bottomAnchor, constant: 10),
                                     stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
                                     stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
                                     stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                    ])

    }
    
    
    
    @objc func tapSendButton() {
        delegate.addRequestToConfidant(withEmail: emailField.text!)
        self.dismiss(animated: true)
    }

}
