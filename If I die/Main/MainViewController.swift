

import UIKit

class MainViewController: UIViewController {
    
    private lazy var confidantLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Эти люди смогут подтвердить сервису факт вашей смерти:"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var willsLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "После подтверждения от вашего имени начнут рассылаться эти сообщения:"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var confidantAllDataButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.systemGray3.cgColor
        button.layer.borderWidth = 1
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Весь список доверенных лиц >", for: .normal)
        button.addTarget(self, action: #selector(tapAllConfidantButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var willsAllDataButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.systemGray3.cgColor
        button.layer.borderWidth = 2
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Весь список сообщений >", for: .normal)
        button.addTarget(self, action: #selector(tapAllWillsButton), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var confidantsCollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ConfidantCollectionViewCell.self, forCellWithReuseIdentifier: "ConfidantCollectionViewCell")
        return collectionView
    }()
    
    private lazy var willsCollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(WillCollectionViewCell.self, forCellWithReuseIdentifier: "WillCollectionViewCell")
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    

    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//        setupView()
//    }

    private func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Если вы умрёте"
        self.tabBarItem.title = "Мои заветы"

        view.addSubview(confidantLabel)
        view.addSubview(confidantsCollectionView)
        view.addSubview(confidantAllDataButton)
        view.addSubview(willsLabel)
        view.addSubview(willsCollectionView)
        view.addSubview(willsAllDataButton)
        
        NSLayoutConstraint.activate([confidantLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     confidantLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
                                     confidantLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.75),
            
                                     confidantsCollectionView.topAnchor.constraint(equalTo: confidantLabel.bottomAnchor, constant: 5),
                                     confidantsCollectionView.heightAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.size.height/8),
                                     confidantsCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     confidantsCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     
                                     confidantAllDataButton.topAnchor.constraint(equalTo: confidantsCollectionView.bottomAnchor, constant: 0),
                                     confidantAllDataButton.heightAnchor.constraint(equalToConstant: (view.safeAreaLayoutGuide.layoutFrame.size.height/8-10)/2),
                                     confidantAllDataButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
                                     confidantAllDataButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
 
                                     willsLabel.topAnchor.constraint(equalTo: confidantAllDataButton.bottomAnchor, constant: 15),
                                     willsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
                                     willsLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.75),
                                    
                                     willsCollectionView.topAnchor.constraint(equalTo: willsLabel.bottomAnchor, constant: 5),
                                     willsCollectionView.bottomAnchor.constraint(equalTo: willsAllDataButton.topAnchor, constant: -10),
                                     willsCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     willsCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     
                                     willsAllDataButton.heightAnchor.constraint(equalToConstant: (view.safeAreaLayoutGuide.layoutFrame.size.height/8-10)/2),
                                     willsAllDataButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
                                     willsAllDataButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
                                     willsAllDataButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
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



extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var result: Int
        if collectionView == confidantsCollectionView {
            result = 2
        } else {
            result = 3
        }
        return result
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell
        if collectionView == confidantsCollectionView {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConfidantCollectionViewCell", for: indexPath) as! ConfidantCollectionViewCell
            let content = confidants[0...1]
            (cell as! ConfidantCollectionViewCell).setupContent(name: content[indexPath.row].name, email: content[indexPath.row].email)
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WillCollectionViewCell", for: indexPath) as! WillCollectionViewCell
            let content = wills[0...2]
            (cell as! WillCollectionViewCell).setupContent(name: content[indexPath.row].title, email: content[indexPath.row].text)
        }
        return cell
    }
    
    
    
    
}



extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var result: CGSize
        if collectionView == confidantsCollectionView {
            result = CGSize(width: self.view.bounds.width-30, height: (self.confidantsCollectionView.bounds.height-10)/2)
        } else {
            result = CGSize(width: self.view.bounds.width-30, height: (self.willsCollectionView.bounds.height-20)/3)
        }
        return result
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        var result: CGFloat
        if collectionView == confidantsCollectionView {
            result = 5
        } else {
            result = 10
        }
        return result
    }
    
}
