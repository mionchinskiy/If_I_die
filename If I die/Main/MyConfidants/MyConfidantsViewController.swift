

import UIKit

class MyConfidantsViewController: UIViewController {
    
    private lazy var tableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyConfidantTableViewCell.self, forCellReuseIdentifier: "MyConfidantTableViewCell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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
        confidants.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyConfidantTableViewCell", for: indexPath) as! MyConfidantTableViewCell
        if indexPath.row == 0 {

            cell.setupAddConfidantView()
        } else {
            cell.setupStandartView()
            cell.setupContent(with: confidants[indexPath.row-1])
        }
        return cell
    }
    

    
    
    
}


extension MyConfidantsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let addConfidantViewController = AddConfidantViewController()
            //addConfidantViewController.modalPresentationStyle = 
            self.present(addConfidantViewController, animated: true)
        }
    }
    
}
