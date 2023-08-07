
import UIKit

class AddWillViewController: UIViewController {
    
    var user: User
    var message: Message?
    
    var delegate: AddWillViewControllerDelegate
    
    enum WillState {
        case presentWill
        case editWill
        case addWill
    }
    
    lazy var exitButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .systemRed
        button.addTarget(self, action: #selector(tapExitButton), for: .touchUpInside)
        return button
    }()
    
    lazy var saveNewMessageButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(tapSaveNewMessageButton), for: .touchUpInside)
        return button
    }()
    
    lazy var editButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(tapEditButton), for: .touchUpInside)
        return button
    }()
    
    lazy var saveEditMessageButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(tapSaveEditMessageButton), for: .touchUpInside)
        return button
    }()
    
    lazy var titleDescription = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Запишите сообщение, которое отправится вашим близким в случае вашей смерти"
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var setupConfidantsButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Адресаты", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        //button.addTarget(self, action: #selector(tapExitButton), for: .touchUpInside)
        return button
    }()
    
    lazy var setupDateForSendButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Дата отправки", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        //button.addTarget(self, action: #selector(tapExitButton), for: .touchUpInside)
        return button
    }()
    
    lazy var labelForTitle = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var fieldForTitle = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Заголовок сообщения"
        textField.borderStyle = .bezel
        return textField
    }()
    
    lazy var fieldForWill: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderWidth = 2
        textView.layer.borderColor = UIColor.systemBlue.cgColor
        return textView
    }()
    


//
//    lazy var errorLabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    
    init(forUser user: User, forMessage message: Message? = nil, withState state: WillState, delegate: AddWillViewControllerDelegate) {
        self.user = user
        self.delegate = delegate
        
        super.init(nibName: nil, bundle: nil)
        
        setupBaseView()
        switch state {
        case .presentWill:
            self.message = message
            setupViewToPresentWill(message: self.message!)
        case .editWill:
            print("1")
        case .addWill:
            self.setupViewToAddWill()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupBaseView() {
        view.backgroundColor = .white
        view.addSubview(exitButton)
        view.addSubview(saveNewMessageButton)
        view.addSubview(editButton)
        view.addSubview(saveEditMessageButton)
        view.addSubview(titleDescription)
        view.addSubview(setupConfidantsButton)
        view.addSubview(setupDateForSendButton)
        view.addSubview(fieldForTitle)
        view.addSubview(labelForTitle)
        view.addSubview(fieldForWill)

        NSLayoutConstraint.activate([exitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
                                     exitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                                     exitButton.heightAnchor.constraint(equalToConstant: 40),
                                     
                                     saveNewMessageButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
                                     saveNewMessageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                     
                                     editButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
                                     editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                     
                                     saveEditMessageButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
                                     saveEditMessageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                     
                                     titleDescription.topAnchor.constraint(equalTo: exitButton.bottomAnchor, constant: 10),
                                     titleDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                                     titleDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                                     
                                     setupConfidantsButton.topAnchor.constraint(equalTo: titleDescription.bottomAnchor, constant: 10),
                                     setupConfidantsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                                     setupConfidantsButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3),
                                     
                                     setupDateForSendButton.topAnchor.constraint(equalTo: titleDescription.bottomAnchor, constant: 10),
                                     setupDateForSendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                                     setupDateForSendButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3),
                                     
                                     fieldForTitle.topAnchor.constraint(equalTo: setupDateForSendButton.bottomAnchor, constant: 10),
                                     fieldForTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                                     fieldForTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                                     
                                     labelForTitle.topAnchor.constraint(equalTo: setupDateForSendButton.bottomAnchor, constant: 10),
                                     labelForTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                                     labelForTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                                     
                                     fieldForWill.topAnchor.constraint(equalTo: fieldForTitle.bottomAnchor, constant: 10),
                                     fieldForWill.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                                     fieldForWill.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                                     fieldForWill.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
                                    ])
    }
    
    private func setupViewToAddWill() {
        labelForTitle.isHidden = true
        editButton.isHidden = true
        saveEditMessageButton.isHidden = true
    }
    
    private func setupViewToPresentWill(message: Message) {
        titleDescription.isHidden = true
        fieldForTitle.isHidden = true
        saveNewMessageButton.isHidden = true
        saveEditMessageButton.isHidden = true
        fieldForWill.isEditable = false
        fieldForWill.layer.borderWidth = 0
        NSLayoutConstraint.activate([setupConfidantsButton.topAnchor.constraint(equalTo: exitButton.bottomAnchor, constant: 10),
                                     setupDateForSendButton.topAnchor.constraint(equalTo: exitButton.bottomAnchor, constant: 10)])
        labelForTitle.text = message.title
        fieldForTitle.text = message.title
        fieldForWill.text = message.text
    }
    
    @objc func tapExitButton() {
        self.dismiss(animated: true)
    }
    
    @objc func tapSaveNewMessageButton() {
        //создаём id для нового message
        var messageIds = [Int]()
        for temp in user.messages {
            messageIds.append(temp.messageId)
        }
        let idForNewMessage = (messageIds.max() ?? 0)+1
        
        let newMessage = Message(messageId: idForNewMessage,
                              title: fieldForTitle.text!,
                              text: fieldForWill.text!,
                              whomToSend: [""],
                              daysAfterDeathToSend: 0,
                              lastEditDate: Date())
        self.delegate.uploadNewMessage(message: newMessage)
        self.dismiss(animated: true)
    }
    
    @objc func tapEditButton() {
        labelForTitle.isHidden = true
        fieldForTitle.isHidden = false
        fieldForWill.isEditable = true
        fieldForWill.layer.borderWidth = 2
        editButton.isHidden = true
        saveEditMessageButton.isHidden = false
    }
    
    @objc func tapSaveEditMessageButton() {
        self.message?.title = fieldForTitle.text!
        self.message?.text = fieldForWill.text!
        self.message?.lastEditDate = Date()
        self.delegate.updateModifiedMessage(message: self.message!)
        self.dismiss(animated: true)
    }

}
