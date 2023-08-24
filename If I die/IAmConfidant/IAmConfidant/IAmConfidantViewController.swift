

import UIKit

//protocol AddConfidantDelegate {
//    
//    func addRequestToConfidant(withEmail email: String)
//}

class IAmConfidantViewController: UIViewController {
    
    var user: User
    var dataForConfidantsCells = [[String:Any]]()
    
    private lazy var tableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WhomIAmConfidantTableViewCell.self, forCellReuseIdentifier: "WhomIAmConfidantTableViewCell")
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
        navigationItem.title = "Можете подтвердить их смерть"
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
        var confidantsDataForCells = Array<[String : Any]>(repeating: [:], count: self.user.heAgreedBeConfidantFor.count)
        let group = DispatchGroup()
        for (index, confidantEmail) in self.user.heAgreedBeConfidantFor.enumerated() {
            group.enter()
            var confidantData = [String:Any]()
            confidantData["email"] = confidantEmail
            FirebaseService.shared.getUserDataBy(email: confidantEmail) { result in
                switch result {
                case .success(let confidantUser):
                    confidantData["name"] = confidantUser.name
                    if confidantUser.isAlive == false {
                        confidantData["state"] = "подтвержден факт смерти пользователя"
                    } else {
                        confidantData["state"] = "вроде жив )))"
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    confidantData["name"] = "---------"
                    confidantData["state"] = "пользователь не найден"
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


extension IAmConfidantViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataForConfidantsCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WhomIAmConfidantTableViewCell", for: indexPath) as! WhomIAmConfidantTableViewCell
        cell.setupStandartView()
        cell.email.text = dataForConfidantsCells[indexPath.row]["email"] as? String
        cell.name.text = dataForConfidantsCells[indexPath.row]["name"] as? String
        cell.state.text = dataForConfidantsCells[indexPath.row]["state"] as? String
        if cell.state.text == "подтвержден факт смерти пользователя" {
            cell.view.layer.borderColor = UIColor.systemBrown.cgColor
        }
        cell.selectionStyle = .none
        return cell
    
    }
    
}


extension IAmConfidantViewController: UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 0 {
//            let addConfidantViewController = AddConfidantViewController(delegate: self)
//            //addConfidantViewController.modalPresentationStyle =
//            self.present(addConfidantViewController, animated: true)
//        }
//    }
    
}


//extension IAmConfidantViewController: AddConfidantDelegate {
//    
//    func addRequestToConfidant(withEmail email: String) {
//        user.hisConfidantsSendRequest.append(email)
//        user.hisConfidantsActual.append(email)
//        FirebaseService.shared.updateUser(user: user)
//        tableView.reloadData()
//    }
//
//}
