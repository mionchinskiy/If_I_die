

import UIKit

class RegistrationViewController: UIViewController {
    
    //var loginInspector = LoginInspector()
    weak var loginVCDelegate: LoginViewForRegistationDelegate?
    
// MARK: UI elements
    
    private lazy var navigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.barTintColor = UIColor(red: 0.976, green: 0.976, blue: 0.976, alpha: 0.94)
        navigationBar.isTranslucent = false
        let item = UINavigationItem()
        item.title = "Регистрация"
        navigationBar.items = [item]
        return navigationBar
    }()

    lazy var loginTextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .bezel
        textField.placeholder = "email"
        return textField
    }()
    
    private lazy var loginInfoLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemRed
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var passwordTextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .bezel
        textField.placeholder = "password"
        return textField
    }()
    
    private lazy var passwordInfoLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemRed
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var registrationButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Зарегестрироваться", for: .normal)
        button.backgroundColor = .magenta
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(tapRegistrationButton), for: .touchUpInside)
        return button
    }()
    
    lazy var alertSuccesRegistration = {
        let alertIncorrectPass = UIAlertController(title: "Пользователь успешно зарегистрирован", message: nil, preferredStyle: .alert)
        alertIncorrectPass.addAction(UIAlertAction(title: "Войти в систему", style: .default, handler: { [weak self] _ in
            self?.dismiss(animated: true)
            (self!.loginVCDelegate! as! LoginViewController).touchLoginButton()
        }))
        return alertIncorrectPass
    }()
    
//MARK: Setup view
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        
        view.backgroundColor = .white
        view.addSubview(navigationBar)
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(registrationButton)
        view.addSubview(loginInfoLabel)
        view.addSubview(passwordInfoLabel)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(tapLeftNavigationBarButton))
        
        NSLayoutConstraint.activate([loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                                     loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                     loginTextField.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 40),
                                     
                                     loginInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                                     loginInfoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                     loginInfoLabel.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 5),
                                    
                                     passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                                     passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                     passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 40),
                                     
                                     passwordInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                                     passwordInfoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                     passwordInfoLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 5),
                                    
                                     registrationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     registrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                                     registrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                     registrationButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
                                    
                                     navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor),
                                     navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor),
                                     navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)])
    }

// MARK: Setup actions for buttons
    
    @objc func tapRegistrationButton() {
        
        loginInfoLabel.text = ""
        passwordInfoLabel.text = ""
        
        guard loginTextField.text!.isValidEmail() else {
            loginInfoLabel.text = "Формат введенной почты неверен"
            return
        }
        
        guard passwordTextField.text!.count > 5 else {
            passwordInfoLabel.text = "Длина пароля должна быть не менее 6 символов"
            return
        }
        
        FirebaseService.shared.createAccount(email: loginTextField.text!, password: passwordTextField.text!) { [weak self] result in
            switch result {
            case .success():
                print("Успешная регистрация")
                self!.loginVCDelegate?.setupLoginPasswordFromRegistration(login: self!.loginTextField.text!, password: self!.passwordTextField.text!)
                self!.present(self!.alertSuccesRegistration, animated: true)
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            
            
            
//            if let error = error {
//                print(error.localizedDescription)
//            } else {

//            }
        }
    }
    
    @objc func tapLeftNavigationBarButton() {
        self.dismiss(animated: true)
    }

}


