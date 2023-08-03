

import UIKit

class MainViewController: UIViewController {
    
    let user: User
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private lazy var viewForConfidants = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var viewForWills = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var confidantLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Укажите людей, которые смогли бы подтвердить сервису факт вашей смерти:"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var willsLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Составьте сообщения, которые начнут рассылаться в случае вашей смерти:"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var confidantAllDataButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBrown//.systemGray5
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.systemBrown.cgColor
        button.layer.borderWidth = 2
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitle("Настроить список доверенных лиц", for: .normal)
        button.addTarget(self, action: #selector(tapAllConfidantButton), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var willsTableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
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
    

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    


    private func setupView() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(viewForConfidants)
        viewForConfidants.addSubview(confidantLabel)
        viewForConfidants.addSubview(confidantAllDataButton)
        scrollView.addSubview(viewForWills)
        viewForWills.addSubview(willsLabel)
        viewForWills.addSubview(willsTableView)
        
        self.tabBarController!.tabBar.isTranslucent = false
        self.tabBarController!.tabBar.backgroundColor = .black
        self.tabBarController!.tabBar.tintColor = .white
        self.tabBarController!.tabBar.barTintColor = .black
        
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        //navigationController?.navigationBar.isHidden = true
        title = "Если вы умрёте"
        self.tabBarItem.title = "Мои заветы"
        
        
        NSLayoutConstraint.activate([scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                                     
                                     
                                     viewForConfidants.topAnchor.constraint(equalTo: scrollView.topAnchor),
                                     viewForConfidants.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
                                     viewForConfidants.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
                                     
                                     
                                     confidantLabel.topAnchor.constraint(equalTo: viewForConfidants.safeAreaLayoutGuide.topAnchor, constant: 15),
                                     confidantLabel.leadingAnchor.constraint(equalTo: viewForConfidants.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                                     confidantLabel.trailingAnchor.constraint(equalTo: viewForConfidants.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
                                     
                                     confidantAllDataButton.topAnchor.constraint(equalTo: confidantLabel.bottomAnchor, constant: 5),
                                     confidantAllDataButton.heightAnchor.constraint(equalToConstant: (view.safeAreaLayoutGuide.layoutFrame.size.height/8-10)/2),
                                     confidantAllDataButton.leadingAnchor.constraint(equalTo: viewForConfidants.safeAreaLayoutGuide.leadingAnchor, constant: 15),
                                     confidantAllDataButton.trailingAnchor.constraint(equalTo: viewForConfidants.safeAreaLayoutGuide.trailingAnchor, constant: -15),
                                     confidantAllDataButton.bottomAnchor.constraint(equalTo: viewForConfidants.bottomAnchor, constant: -15),
                                     
                                     viewForWills.topAnchor.constraint(equalTo: viewForConfidants.bottomAnchor, constant: 20),
                                     viewForWills.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
                                     viewForWills.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
                                     //viewForWills.heightAnchor.constraint(equalToConstant: CGFloat((wills.count+1))*LayoutConstants.heightOfWillCell+25),
                                     viewForWills.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10),

 
                                     willsLabel.topAnchor.constraint(equalTo: viewForWills.topAnchor, constant: 15),
                                     willsLabel.leadingAnchor.constraint(equalTo: viewForWills.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                                     willsLabel.widthAnchor.constraint(equalTo: viewForWills.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),

                                    
                                     willsTableView.topAnchor.constraint(equalTo: willsLabel.bottomAnchor, constant: 5),
                                     willsTableView.leadingAnchor.constraint(equalTo: viewForWills.safeAreaLayoutGuide.leadingAnchor, constant: 15),
                                     willsTableView.trailingAnchor.constraint(equalTo: viewForWills.safeAreaLayoutGuide.trailingAnchor, constant: -15),
                                     willsTableView.bottomAnchor.constraint(equalTo: viewForWills.bottomAnchor, constant: -10),
                                     willsTableView.heightAnchor.constraint(equalToConstant: CGFloat(wills.count)*LayoutConstants.heightOfWillCell+(LayoutConstants.heightOfWillCell/2)),
                                    ]
                                    
        )
        
    }
    
    
    @objc func tapAllConfidantButton() {
        let myConfidantsViewController = MyConfidantsViewController()
        self.navigationController?.pushViewController(myConfidantsViewController, animated: true)
    }
    
    @objc func tapAllWillsButton() {
        let myWillsViewController = MyWillsViewController()
        self.navigationController?.pushViewController(myWillsViewController, animated: true)
    }
}


extension MainViewController: UITableViewDataSource {
    
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


extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let addWillViewController = AddWillViewController()
            self.present(addWillViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard indexPath.row != 0 else {
            return LayoutConstants.heightOfWillCell/2
        }
            return LayoutConstants.heightOfWillCell
    }
    
}



