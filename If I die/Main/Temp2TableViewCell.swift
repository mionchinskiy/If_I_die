//
//  Temp2TableViewCell.swift
//  If I die
//
//  Created by Denis Mionchinskiy on 03.08.2023.
//

import UIKit

class Temp2TableViewCell: UITableViewCell {
    
    private lazy var viewForWills = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var willsLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Составьте сообщения, которые начнут рассылаться в случае вашей смерти:"
        label.numberOfLines = 0
        return label
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

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupView(for user: User) {
        contentView.addSubview(viewForWills)
        viewForWills.addSubview(willsLabel)
        viewForWills.addSubview(willsTableView)
        
        
    }

}


extension Temp2TableViewCell: UITableViewDataSource {
    
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


extension Temp2TableViewCell: UITableViewDelegate {
    
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


