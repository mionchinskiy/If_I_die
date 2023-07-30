

import UIKit

class AddConfidantViewController: UIViewController {
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var sendInviteTitle = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Пригласите близкого человека стать вашим доверенным лицом."
        label.numberOfLines = 0
        return label
    }()
    
    lazy var nameField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Имя Фамилия"
        textField.borderStyle = .bezel
        return textField
    }()
    
    
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
        button.setTitle("Отправить предложение стать доверенным лицом", for: .normal)
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

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(stackView)
        stackView.addArrangedSubview(sendInviteTitle)
        stackView.addArrangedSubview(nameField)
        stackView.addArrangedSubview(emailField)
        stackView.addArrangedSubview(sendButton)
        stackView.addArrangedSubview(errorLabel)
        
        NSLayoutConstraint.activate([stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8),
                                     stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
                                     stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

                                    ])

    }
    
    
    
    @objc func tapSendButton() {
        confidants.append(Confidant(name: nameField.text!,
                                    email: emailField.text!,
                                    isRegistred: false,
                                    isConfirmedParticipationForYou: false,
                                    isOnForYou: false))
        self.dismiss(animated: true)
    }

}
