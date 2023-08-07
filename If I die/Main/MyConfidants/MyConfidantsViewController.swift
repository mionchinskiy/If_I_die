

import UIKit

protocol AddConfidantDelegate {
    
    func addRequestToConfidant(withEmail email: String)
}

class MyConfidantsViewController: UIViewController {
    
    var user: User
    var confidantsdataForCell: [[String:Any]]
    
    private lazy var tableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyConfidantTableViewCell.self, forCellReuseIdentifier: "MyConfidantTableViewCell")
        return tableView
    }()
    
    init(user: User, confidantsdataForCell: [[String:Any]]) {
        self.user = user
        self.confidantsdataForCell = confidantsdataForCell
        super.init(nibName: nil, bundle: nil)
//        let group = DispatchGroup()
//            group.enter()
//
//        DispatchQueue.main.async {
//            self.confidantsdataForCell = self.prepareDataForCell()
//            group.leave()
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let group = DispatchGroup()
//            group.enter()
//
//        DispatchQueue.main.async {
//            self.confidantsdataForCell = self.prepareDataForCell()
//            group.leave()
//        }
        setupView()
        //FirebaseService.shared.updateUser(user: user)
        tableView.reloadData()
    }
    
    private func setupView() {
        
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(tapNavBarSettingButton))
        navigationItem.title = "Мои доверенные лица"
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                    ])
        
    }
    
    @objc func tapNavBarSettingButton() {
        
    }
    



}


extension MyConfidantsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //confidants.count+1
        //user.hisConfidantsSendRequest.count+1
        confidantsdataForCell.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let addCell = tableView.dequeueReusableCell(withIdentifier: "MyConfidantTableViewCell", for: indexPath) as! MyConfidantTableViewCell
            addCell.setupAddConfidantView()
            return addCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyConfidantTableViewCell", for: indexPath) as! MyConfidantTableViewCell
            cell.setupStandartView()
            cell.email.text = confidantsdataForCell[indexPath.row-1]["email"] as? String
            cell.name.text = confidantsdataForCell[indexPath.row-1]["name"] as? String
            cell.state.text = confidantsdataForCell[indexPath.row-1]["state"] as? String

                
            

            //cell.setupContent(withConfidant: self.user.hisConfidantsSendRequest[indexPath.row-1], forUser: self.user)
            return cell

            //cell.setupContent(with: confidants[indexPath.row-1])
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
