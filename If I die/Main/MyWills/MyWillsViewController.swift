//
//  MyWillsViewController.swift
//  If I die
//
//  Created by Denis Mionchinskiy on 30.07.2023.
//

import UIKit

class MyWillsViewController: UIViewController {
    
    private lazy var tableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyWillTableViewCell.self, forCellReuseIdentifier: "MyWillTableViewCell")
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
        navigationItem.title = "Мои заветы"
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


extension MyWillsViewController: UITableViewDataSource {
    
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


extension MyWillsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let addWillViewController = AddWillViewController()
            self.present(addWillViewController, animated: true)
        }
    }
    
}
