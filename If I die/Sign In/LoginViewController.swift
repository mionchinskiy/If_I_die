

import UIKit

protocol LoginViewControllerCoordinatorDelegate: AnyObject {
    
    func pressLoginButton(autorization: Bool)
    
}

protocol LoginViewForRegistationDelegate: AnyObject {
    
    func setupLoginPasswordFromRegistration(login: String, password: String)
}


final class LoginViewController: UIViewController {
    
    // MARK: Visual content
    
    var coordinatorDelegate: LoginViewControllerCoordinatorDelegate?
    
    var loginScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var vkLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "vkLogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var loginStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.layer.borderWidth = 0.5
        stack.layer.cornerRadius = LayoutConstants.cornerRadius
        stack.distribution = .fillProportionally
        stack.backgroundColor = .systemGray6
        stack.clipsToBounds = true
        return stack
    }()
    
    lazy var loginButton = {
        let button = CustomButton(title: "Login", titleColor: .white)
        if let pixel = UIImage(named: "blue_pixel") {
            button.setBackgroundImage(pixel.image(alpha: 1), for: .normal)
            button.setBackgroundImage(pixel.image(alpha: 0.8), for: .selected)
            button.setBackgroundImage(pixel.image(alpha: 0.6), for: .highlighted)
            button.setBackgroundImage(pixel.image(alpha: 0.4), for: .disabled)
        }
        button.handlerButtonTapped = {self.touchLoginButton()}
        return button
    }()
    
    lazy var registrationButton = {
        let button = CustomButton(title: "Registration", titleColor: .white)
        button.backgroundColor = .black
        button.handlerButtonTapped = {
            var registationController = RegistrationViewController()
            registationController.loginTextField.text = self.loginField.text
            registationController.passwordTextField.text = self.passwordField.text
            registationController.loginVCDelegate = self
            self.present(registationController, animated: true)
        }
        return button
    }()
    
    var loginField: UITextField = {
        let login = UITextField()
        login.translatesAutoresizingMaskIntoConstraints = false
        login.placeholder = "Log In"
        login.layer.borderColor = UIColor.lightGray.cgColor
        login.layer.borderWidth = 0.25
        login.leftViewMode = .always
        login.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: login.frame.height))
        login.keyboardType = .emailAddress
        login.textColor = .black
        login.font = UIFont.systemFont(ofSize: 16)
        login.autocapitalizationType = .none
        login.returnKeyType = .done
        return login
    }()
    
    var passwordField: UITextField = {
        let password = UITextField()
        password.translatesAutoresizingMaskIntoConstraints = false
        password.leftViewMode = .always
        password.placeholder = "Password"
        password.layer.borderColor = UIColor.lightGray.cgColor
        password.layer.borderWidth = 0.25
        password.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: password.frame.height))
        password.isSecureTextEntry = true
        password.textColor = .black
        password.font = UIFont.systemFont(ofSize: 16)
        password.autocapitalizationType = .none
        password.returnKeyType = .done
        return password
    }()
    
    lazy var alertIncorrectPass = {
        let alertIncorrectPass = UIAlertController(title: "Такого  пользователя не существует. Зарегистрировать новый аккаунт?", message: nil, preferredStyle: .alert)
        alertIncorrectPass.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alertIncorrectPass.addAction(UIAlertAction(title: "Регистрация", style: .default, handler: { [weak self] _ in
            var registationController = RegistrationViewController()
            registationController.loginTextField.text = self?.loginField.text
            registationController.passwordTextField.text = self?.passwordField.text
            registationController.loginVCDelegate = self
            self?.present(registationController, animated: true)
        }))
        return alertIncorrectPass
    }()
    
    lazy var alertEmptyField = {
        let alertIncorrectPass = UIAlertController(title: "Вы не заполнили поля логин/пароль", message: nil, preferredStyle: .alert)
        alertIncorrectPass.addAction(UIAlertAction(title: "Виноват, исправлюсь", style: .cancel))
        return alertIncorrectPass
    }()
    
    lazy var alertShortPassword = {
        let alertIncorrectPass = UIAlertController(title: "Длина пароля - минимум 6 символов", message: nil, preferredStyle: .alert)
        alertIncorrectPass.addAction(UIAlertAction(title: "Виноват, исправлюсь", style: .cancel))
        return alertIncorrectPass
    }()
    
    lazy var alertIncorrectEmail = {
        let alertIncorrectPass = UIAlertController(title: "Неверно указан формат электронной почты", message: nil, preferredStyle: .alert)
        alertIncorrectPass.addAction(UIAlertAction(title: "Виноват, исправлюсь", style: .cancel))
        return alertIncorrectPass
    }()
    
    // MARK: - Setup section
    init(coordinatorDelegate: LoginViewControllerCoordinatorDelegate) {
        self.coordinatorDelegate = coordinatorDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        
        setupViews()
        
        #if DEBUG
        loginField.text = "123456@gmail.com"
        passwordField.text = "123456"
        #endif
        
    }
    
    private func setupViews() {
        view.addSubview(loginScrollView)
        loginScrollView.addSubview(contentView)
        
        contentView.addSubviews(vkLogo, loginStackView, loginButton, registrationButton)
        
        loginStackView.addArrangedSubview(loginField)
        loginStackView.addArrangedSubview(passwordField)
        
        loginField.delegate = self
        passwordField.delegate = self
        
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([

            loginScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loginScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loginScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loginScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: loginScrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: loginScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: loginScrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: loginScrollView.leadingAnchor),
            contentView.centerXAnchor.constraint(equalTo: loginScrollView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: loginScrollView.centerYAnchor),

            vkLogo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            vkLogo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            vkLogo.heightAnchor.constraint(equalToConstant: 100),
            vkLogo.widthAnchor.constraint(equalToConstant: 100),

            loginStackView.topAnchor.constraint(equalTo: vkLogo.bottomAnchor, constant: 120),
            loginStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leadingMargin),
            loginStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.trailingMargin),
            loginStackView.heightAnchor.constraint(equalToConstant: 100),

            loginButton.topAnchor.constraint(equalTo: loginStackView.bottomAnchor, constant: LayoutConstants.indent),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leadingMargin),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.trailingMargin),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            registrationButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: LayoutConstants.indent),
            registrationButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leadingMargin),
            registrationButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.trailingMargin),
            registrationButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
//        let realm = try! Realm()
//        let users = realm.objects(UserAuthObject.self).toArray(ofType: UserAuthObject.self)
//        let userSuccessAuth = users.filter ({
//            $0.login == loginField.text && $0.password == passwordField.text
//        })
//        if userSuccessAuth.count != 0 {
//            coordinatorDelegate?.pressLoginButton(autorization: true)
//        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let nc = NotificationCenter.default
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    // MARK: - Event handlers


    //var delegateVerification: UserService?
    
    //var loginDelegate: LoginViewControllerDelegate?
    
    private func touchLoginButton() {
        #if DEBUG
        //delegateVerification = TestUserService()
        #else
        //delegateVerification = CurrentUserService()
        #endif
        
        guard loginField.text != "", passwordField.text != "" else {
            self.present(alertEmptyField, animated: true)
            return
        }
        
        guard loginField.text!.isValidEmail() else {
            self.present(alertIncorrectEmail, animated: true)
            return
        }
        
        guard passwordField.text!.count > 5 else {
            self.present(alertShortPassword, animated: true)
            return
        }
        
//        loginDelegate?.checkCredentials(email: loginField.text!, password: passwordField.text!, { [weak self] result in
//            switch result {
//            case true:
//                let realm = try! Realm()
//                let userAuth = UserAuthObject(login: self!.loginField.text!, password: self!.passwordField.text!)
//                try! realm.write {
//                    realm.add(userAuth)
//                }
//                self!.coordinatorDelegate?.pressLoginButton(autorization: true)
//            case false:
//                self!.coordinatorDelegate?.pressLoginButton(autorization: false)
//            }
//        })

    }

    @objc private func keyboardShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            loginScrollView.contentOffset.y = keyboardSize.height - (loginScrollView.frame.height - loginButton.frame.minY)
            loginScrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }

    @objc private func keyboardHide(notification: NSNotification) {
        loginScrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
}

// MARK: - Extension

extension LoginViewController: UITextFieldDelegate {
    
    // tap 'done' on the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension LoginViewController: LoginViewForRegistationDelegate {
    
    func setupLoginPasswordFromRegistration(login: String, password: String) {
        loginField.text = login
        passwordField.text = password
        touchLoginButton()
    }
}



