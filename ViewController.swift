//
//  ViewController.swift
//  TelestraTechMPOC
//
//  Created by kanagasabapathy on 29/06/20.
//  Copyright © 2020 kanagasabapathy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var refreshControl = UIRefreshControl()
    
    let indicator:UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: CGRect(x:0, y:0, width:60, height:60))
        indicator.style = .medium
        return indicator
    }()
    
    let factTableView:UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.white
        factTableView.delegate = self
        factTableView.dataSource = self
        factTableView.register(FactsTableViewCell.self, forCellReuseIdentifier: "FactCell")
        factTableView.allowsSelection = false
        factTableView.estimatedRowHeight = 44.0
        factTableView.rowHeight = UITableView.automaticDimension
        
        refreshControl.attributedTitle = NSAttributedString(string: "Refresh")
        refreshControl.addTarget(self, action: #selector(ViewController.pullToRefresh(sender:)), for: .valueChanged)
        factTableView.addSubview(refreshControl)
        
        setupFactTableLayout()
        
        
        
    }
    
    @objc func pullToRefresh(sender:AnyObject) {
       
    }
    
    func setupFactTableLayout(){
        
        factTableView.frame = view.bounds
        view.addSubview(factTableView)
        
        indicator.center = self.factTableView.center
        self.view.addSubview(indicator)
        
        
    }
}


extension UIViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}

extension UIViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "FactCell") as? UITableViewCell
        cell?.textLabel?.text =  "Saba"
        cell?.detailTextLabel?.text = "Pathy"
        return cell!

    }
    
    
}
