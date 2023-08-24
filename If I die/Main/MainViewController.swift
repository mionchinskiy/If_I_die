
import UIKit


protocol ForConfidantsTableViewCellDelegate {
    
    func tapConfidantAllDataButton()
    
}

protocol AddWillViewControllerDelegate {
    
    func uploadNewMessage(message: Message)
    
    func updateModifiedMessage(message: Message)
}


class MainViewController: UIViewController {
    
    var user: User

    private lazy var tableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.register(MyWillTableViewCell.self, forCellReuseIdentifier: "MyWillTableViewCell")
        return tableView
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
        FirebaseService.shared.updateUser(user: user)
        tableView.reloadData()
    }
    

    private func setupView() {
        
        view.addSubview(tableView)

        
        self.tabBarController!.tabBar.isTranslucent = false
        self.tabBarController!.tabBar.backgroundColor = .black
        self.tabBarController!.tabBar.tintColor = .white
        self.tabBarController!.tabBar.barTintColor = .black
        
        view.backgroundColor = .white
        //navigationController?.navigationBar.prefersLargeTitles = true
        //navigationController?.navigationBar.isHidden = true
        title = "Мои заветы"
        self.tabBarItem.title = "Мои заветы"
        
        
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                    ])
        
    }
    
    
}




extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return user.messages.count+1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = ForConfidantsTableViewCell()
            cell.setupView()
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        case 1:
            if indexPath.row == 0 {
                let cellForAdd = MyWillTableViewCell()
                cellForAdd.setupAddConfidantView()
                return cellForAdd
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MyWillTableViewCell", for: indexPath) as! MyWillTableViewCell
                cell.setupStandartView()
                cell.setupContent(with: user.messages[indexPath.row-1])
                return cell
            }
        default:
            return UITableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let header = HeaderForMyWills()
            header.setupView()
            return header
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return UITableView.automaticDimension
        }
        return 0
    }
                
    
    
}


extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 0 {
            let addWillViewController = AddWillViewController(forUser: user,
                                                              withState: .addWill
                                                              ,delegate: self)
            addWillViewController.modalPresentationStyle = .fullScreen
            self.present(addWillViewController, animated: true)
        }
        if indexPath.section == 1 && indexPath.row != 0 {
            let addWillViewController = AddWillViewController(forUser: user,
                                                              forMessage: user.messages[indexPath.row-1],
                                                              withState: .presentWill,
                                                              delegate: self)
            addWillViewController.modalPresentationStyle = .fullScreen
            self.present(addWillViewController, animated: true)
        }
        
    }

    
}

extension MainViewController: ForConfidantsTableViewCellDelegate {
    
    func tapConfidantAllDataButton() {
        let myConfidantsViewController = MyConfidantsViewController(user: user)
        self.navigationController?.pushViewController(myConfidantsViewController,
                                                      animated: true)
    }

    
}

extension MainViewController: AddWillViewControllerDelegate {
    
    func uploadNewMessage(message: Message) {
        user.messages.append(message)
        FirebaseService.shared.updateUser(user: user)
        tableView.reloadData()
    }
    
    func updateModifiedMessage(message: Message){
        user.messages.enumerated().forEach { if $1.messageId == message.messageId {
            user.messages[$0] = message
        } }
        FirebaseService.shared.updateUser(user: user)
        tableView.reloadData()
    }
    
}











