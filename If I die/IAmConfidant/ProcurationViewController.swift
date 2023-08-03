

import UIKit

class ProcurationViewController: UIViewController {
    
    let user: User
    
    private lazy var confidantsLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Люди, которые просят вас, в случае их смерти, подтвердить факт их смерти приложению"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var confidantsAllDataButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.systemGray3.cgColor
        button.layer.borderWidth = 2
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Смотреть список", for: .normal)
        button.addTarget(self, action: #selector(tapAllConfidantButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var alertLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .systemRed
        label.text = "Требуется обновить данные в списке доверившихся вам лиц!"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var tableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
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
    }

    private func setupView() {
        view.backgroundColor = .white
        //navigationController?.navigationBar.prefersLargeTitles = false
        title = "Заветы для вас"
        self.tabBarItem.title = "Заветы для меня"
        
        view.addSubview(confidantsLabel)
        view.addSubview(confidantsAllDataButton)
        view.addSubview(alertLabel)
        view.addSubview(tableView)
//        view.addSubview(willsCollectionView)
//        view.addSubview(willsAllDataButton)
        
        NSLayoutConstraint.activate([confidantsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     confidantsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
                                     confidantsLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.75),
                                     
                                     confidantsAllDataButton.topAnchor.constraint(equalTo: confidantsLabel.bottomAnchor, constant: 5),
                                     confidantsAllDataButton.heightAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.size.height/10),
                                     confidantsAllDataButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     confidantsAllDataButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     
                                     alertLabel.topAnchor.constraint(equalTo: confidantsAllDataButton.bottomAnchor, constant: 0),
                                     alertLabel.heightAnchor.constraint(equalToConstant: (view.safeAreaLayoutGuide.layoutFrame.size.height/8-10)/2),
                                     alertLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
                                     alertLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
                                     
                                     tableView.topAnchor.constraint(equalTo: alertLabel.bottomAnchor, constant: 15),
                                     tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
                                     tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
                                     tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

                                    ]
                                    
        )
    }
    
    @objc func tapAllConfidantButton() {
        let myConfidantsViewController = MyConfidantsViewController()
        self.navigationController?.pushViewController(myConfidantsViewController, animated: true)
    }
    
}


extension ProcurationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        wills.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyWillTableViewCell", for: indexPath) as! MyWillTableViewCell
        if indexPath.row == 0 {

            cell.setupAddConfidantView()
        } else {
            cell.setupStandartView()
            cell.setupContent(with: wills[indexPath.row-1])
        }
        return cell
    }
    

    
    
    
}


extension ProcurationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let addWillViewController = AddWillViewController()
            self.present(addWillViewController, animated: true)
        }
    }
    
}
