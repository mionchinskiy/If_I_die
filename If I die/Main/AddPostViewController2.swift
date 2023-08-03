import UIKit

class AddPostViewController2: UIViewController {
    private let titleLabel = UITextField()
    private let postTextView = UITextView()
    private let saveButton = UIButton()
    private let recipientButton = UIButton()
    private let deadlineButton = UIButton()
    private let pickerView = UIPickerView()
    private var recipients: [String] = []
    private var selectedRecipients: [String] = []
    private var selectedDeadline: [String] = []
    private let publicFeedSwitch = UISwitch()

    private lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true

        return toolbar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        registerForKeyboardNotifications()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func setupUI() {
        view.backgroundColor = .white

        // Настраиваем поле ввода заголовка
        titleLabel.placeholder = "Title"
        titleLabel.borderStyle = .roundedRect

        // Настраиваем поле ввода текста поста
        postTextView.layer.borderWidth = 1
        postTextView.layer.borderColor = UIColor.lightGray.cgColor
        postTextView.font = UIFont.systemFont(ofSize: 16)
        postTextView.inputAccessoryView = toolbar

        // Настраиваем кнопку "Save"
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = .blue
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)

        // Настраиваем кнопку "Select Recipients"
        recipientButton.setTitle("Select Recipients", for: .normal)
        recipientButton.setTitleColor(.blue, for: .normal)
        recipientButton.addTarget(self, action: #selector(recipientButtonTapped), for: .touchUpInside)

        // Настраиваем кнопку "Set Deadline"
        deadlineButton.setTitle("Set Deadline", for: .normal)
        deadlineButton.setTitleColor(.blue, for: .normal)
        deadlineButton.addTarget(self, action: #selector(deadlineButtonTapped), for: .touchUpInside)

        // Добавляем элементы на экран
        view.addSubview(titleLabel)
        view.addSubview(postTextView)
        view.addSubview(saveButton)
        view.addSubview(recipientButton)
        view.addSubview(deadlineButton)
        view.addSubview(publicFeedSwitch)

        // Добавляем констрейнты
        setupConstraints()
    }

    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        postTextView.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        recipientButton.translatesAutoresizingMaskIntoConstraints = false
        deadlineButton.translatesAutoresizingMaskIntoConstraints = false
        publicFeedSwitch.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),

            postTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            postTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            postTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            postTextView.bottomAnchor.constraint(equalTo: recipientButton.topAnchor, constant: -20),

            saveButton.topAnchor.constraint(equalTo: postTextView.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 40),

            recipientButton.bottomAnchor.constraint(equalTo: deadlineButton.topAnchor, constant: -20),
            recipientButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            deadlineButton.bottomAnchor.constraint(equalTo: publicFeedSwitch.topAnchor, constant: -20),
            deadlineButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            publicFeedSwitch.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            publicFeedSwitch.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            postTextView.contentInset = insets
            postTextView.scrollIndicatorInsets = insets
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        postTextView.contentInset = .zero
        postTextView.scrollIndicatorInsets = .zero
    }

    @objc private func saveButtonTapped() {
        let title = titleLabel.text ?? ""
        let postText = postTextView.text ?? ""

        // Вызываем функцию с передачей выбранных адресатов и сроков отправки
        sendPostDataToServer(title: title, text: postText, recipients: selectedRecipients, deadline: selectedDeadline, isPublic: publicFeedSwitch.isOn)
    }

    private func sendPostDataToServer(title: String, text: String, recipients: [String], deadline: [String], isPublic: Bool) {
        // Отправка данных на сервер (здесь нужно добавить свою реализацию)
        print("Title: \(title)")
        print("Text: \(text)")
        print("Recipients: \(recipients)")
        print("Deadline: \(deadline)")
        print("Is Public: \(isPublic)")
    }

    @objc private func recipientButtonTapped() {
        let alertController = UIAlertController(title: "Select Recipients", message: nil, preferredStyle: .actionSheet)
        let recipientOptions = ["Recipient 1", "Recipient 2", "Recipient 3"]

        for recipient in recipientOptions {
            let action = UIAlertAction(title: recipient, style: .default) { _ in
                self.selectedRecipients.append(recipient)
            }
            alertController.addAction(action)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    @objc private func deadlineButtonTapped() {
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.reloadAllComponents()

        let alertController = UIAlertController(title: "Set Deadline", message: "\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)
        alertController.view.addSubview(pickerView)

        let selectAction = UIAlertAction(title: "Select", style: .default) { _ in
            var selectedDeadlines: [String] = []
            for row in 0..<self.pickerView.numberOfRows(inComponent: 0) {
                if self.pickerView.selectedRow(inComponent: row) == 0 {
                    let deadlineOption = self.getDeadlineOption(at: row)
                    selectedDeadlines.append(deadlineOption!)
                }
            }
            self.selectedDeadline = selectedDeadlines
        }
        alertController.addAction(selectAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    @objc private func doneButtonTapped() {
        view.endEditing(true)
    }
}

extension AddPostViewController2: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: pickerView.frame.size.height, right: 0.0)
        postTextView.contentInset = contentInsets
        postTextView.scrollIndicatorInsets = contentInsets
        postTextView.scrollRangeToVisible(postTextView.selectedRange)
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        let contentInsets = UIEdgeInsets.zero
        postTextView.contentInset = contentInsets
        postTextView.scrollIndicatorInsets = contentInsets
    }
}

extension AddPostViewController2: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return getDeadlineOption(at: row)
    }

    func getDeadlineOption(at index: Int) -> String? {
        switch index {
        case 0:
            return "Urgent"
        case 1:
        return "Within 24 hours"
        case 2:
        return "Within this week"
        case 3:
        return "Within this month"
        case 4:
        return "No specific deadline"
        default:
        return nil
        }
    }
}
