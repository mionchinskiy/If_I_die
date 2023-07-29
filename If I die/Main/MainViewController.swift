

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
    
    private lazy var collectionViewLayout = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        
        return collectionViewLayout
    }()
    
    private lazy var confidantsCollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(ConfidantCollectionViewCell.self, forCellWithReuseIdentifier: "ConfidantCollectionViewCell")
        return collectionView
    }()
    
    private lazy var willsCollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ConfidantCollectionViewCell.self, forCellWithReuseIdentifier: "ConfidantCollectionViewCell")
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }

    private func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Если вы умрёте"
        self.tabBarItem.title = "Мои заветы"
        
        view.addSubview(confidantsCollectionView)
        view.addSubview(confidantLabel)
        view.addSubview(willsLabel)
        
        NSLayoutConstraint.activate([confidantsCollectionView.topAnchor.constraint(equalTo: confidantLabel.bottomAnchor, constant: 5),
                                     //collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                                     confidantsCollectionView.heightAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.size.height/4),
                                     confidantsCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     confidantsCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                    
                                     confidantLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
                                     confidantLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
                                     confidantLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.75),
                                    
                                     willsLabel.topAnchor.constraint(equalTo: confidantsCollectionView.bottomAnchor, constant: 15),
                                     willsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
                                     willsLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.75),])
        
    }
    
}



extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConfidantCollectionViewCell", for: indexPath) as! ConfidantCollectionViewCell
        let content = confidants[0...2]
        cell.setupContent(name: content[indexPath.row].name, email: content[indexPath.row].email)
        return cell
    }
    
    
    
    
}



extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: self.view.bounds.width-30, height: (self.confidantsCollectionView.bounds.height-10)/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
}
