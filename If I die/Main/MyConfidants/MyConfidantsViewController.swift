

import UIKit

protocol AddConfidantDelegate {
    
    func addRequestToConfidant(withEmail email: String)
}

class MyConfidantsViewController: UIViewController {
    
    var user: User
    var dataForConfidantsCells = [[String:Any]]()
    
    private lazy var tableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyConfidantTableViewCell.self, forCellReuseIdentifier: "MyConfidantTableViewCell")
        tableView.isHidden = true
        
        return tableView
    }()
    
    private lazy var activityIndicator = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        return activityIndicator
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
        setupView()
        prepareDataForConfidantsCells { result in
                    self.dataForConfidantsCells = result
                }
    }
    
    private func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(tapNavBarSettingButton))
        navigationItem.title = "Мои доверенные лица"
        view.addSubview(activityIndicator)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([activityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                                     activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
                                     
                                     tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                    ])
        
    }
    
    private func prepareDataForConfidantsCells(completion: @escaping ([[String:Any]]) -> Void) {
        var confidantsDataForCells = Array<[String : Any]>(repeating: [:], count: self.user.hisConfidantsSendRequest.count)
        let group = DispatchGroup()
        for (index, confidantEmail) in self.user.hisConfidantsSendRequest.enumerated() {
            group.enter()
            var confidantData = [String:Any]()
            confidantData["email"] = confidantEmail
            FirebaseService.shared.getUserDataBy(email: confidantEmail) { [weak self] result in
                switch result {
                case .success(let confidantUser):
                    confidantData["name"] = confidantUser.name
                    if confidantUser.heAgreedBeConfidantFor.contains(self!.user.email) {
                        confidantData["state"] = "актуальное доверенное лицо"
                    } else {
                        confidantData["state"] = "пользователь зарегестрирован, но пока не дал согласия стать вашим доверенным лицом"
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    confidantData["name"] = "---------"
                    confidantData["state"] = "ожидаем регистрации пользователя"
                }
                confidantsDataForCells[index] = confidantData
                
                group.leave()
            }
        }
        group.notify(queue: .main) {
            completion(confidantsDataForCells)
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            self.tableView.isHidden = false
        }
    }
    

        
    
    @objc func tapNavBarSettingButton() {
        
    }

}


extension MyConfidantsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataForConfidantsCells.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let addCell = tableView.dequeueReusableCell(withIdentifier: "MyConfidantTableViewCell", for: indexPath) as! MyConfidantTableViewCell
            addCell.setupAddConfidantView()
            addCell.selectionStyle = .none
            return addCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyConfidantTableViewCell", for: indexPath) as! MyConfidantTableViewCell
            cell.setupStandartView()
            cell.email.text = dataForConfidantsCells[indexPath.row-1]["email"] as? String
            cell.name.text = dataForConfidantsCells[indexPath.row-1]["name"] as? String
            cell.state.text = dataForConfidantsCells[indexPath.row-1]["state"] as? String
            if cell.state.text == "актуальное доверенное лицо" {
                cell.view.layer.borderColor = UIColor.systemGreen.cgColor
                cell.`switch`.isHidden = false
            }
            cell.selectionStyle = .none
            return cell
        }
    }
    
}


extension MyConfidantsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let addConfidantViewController = AddConfidantViewController(delegate: self)
            //addConfidantViewController.modalPresentationStyle = 
            self.present(addConfidantViewController, animated: true)
        }
    }
    
}


extension MyConfidantsViewController: AddConfidantDelegate {
    
    func addRequestToConfidant(withEmail email: String) {
        user.hisConfidantsSendRequest.append(email)
        user.hisConfidantsActual.append(email)
        FirebaseService.shared.updateUser(user: user)
        tableView.reloadData()
    }

}
