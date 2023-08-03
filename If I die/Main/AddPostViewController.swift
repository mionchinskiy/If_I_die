

import UIKit

class AddPostViewController: UIViewController {
    private let titleLabel = UITextField()
    private let textView = UITextView()
    private let recipientsButton = UIButton()
    private let switchControl = UISwitch()
    private let saveButton = UIButton()
    private var recipientsView: RecipientsView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        registerForKeyboardNotifications()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        titleLabel.placeholder = "Заголовок"
        textView.text = "Текст поста"
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.gray.cgColor
        recipientsButton.setTitle("Выбрать адресатов", for: .normal)
        recipientsButton.addTarget(self, action: #selector(recipientsButtonTapped), for: .touchUpInside)
        switchControl.isOn = false
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        view.addSubview(titleLabel)
        view.addSubview(textView)
        view.addSubview(recipientsButton)
        view.addSubview(switchControl)
        view.addSubview(saveButton)
    }
    
    private func setupConstraints() {
        view.backgroundColor = .systemMint
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        recipientsButton.translatesAutoresizingMaskIntoConstraints = false
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textView.heightAnchor.constraint(equalToConstant: 200),
            
            recipientsButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 16),
            recipientsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            recipientsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            switchControl.topAnchor.constraint(equalTo: recipientsButton.bottomAnchor, constant: 16),
            switchControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            saveButton.topAnchor.constraint(equalTo: switchControl.bottomAnchor, constant: 32),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: - Keyboard Handling
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        let keyboardHeight = keyboardFrame?.height ?? 0
        
        textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        textView.contentInset = .zero
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Button Actions
    
    @objc private func recipientsButtonTapped() {
        let recipientsView = RecipientsView()
        recipientsView.delegate = self
        self.recipientsView = recipientsView
        // Present recipientsView or push to recipientsView
    }
    
    @objc private func saveButtonTapped() {
        guard let title = titleLabel.text, let text = textView.text else { return }
        
        let isPublic = switchControl.isOn
        
        // Save post data and states
    }
}

extension AddPostViewController: RecipientsViewDelegate {
    func recipientsView(_ recipientsView: RecipientsView, didSelectRecipients recipients: [Recipient]) {
        // Handle selected recipients
    }
}

protocol RecipientsViewDelegate: AnyObject {
    func recipientsView(_ recipientsView: RecipientsView, didSelectRecipients recipients: [Recipient])
}

class RecipientsView: UIView {
    weak var delegate: RecipientsViewDelegate?
    
    // Implementation of recipients view
}

struct Recipient {
    let name: String
    // Other recipient properties
}
