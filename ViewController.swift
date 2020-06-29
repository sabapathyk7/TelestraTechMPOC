//
//  ViewController.swift
//  TelestraTechMPOC
//
//  Created by kanagasabapathy on 29/06/20.
//  Copyright © 2020 kanagasabapathy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    private var viewModel: ViewModel?
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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//           fatalError("init(coder:) has not been implemented")
       }
    
    
    init(viewModel: ViewModel) {
        
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.viewModel?.delegate = self
    }
    
    
   
    
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
        
        
        if self.viewModel == nil {
            self.viewModel = ViewModel()
        }
        self.viewModel?.getFacts()
        
        setupFactTableLayout()


    }
    
    @objc func pullToRefresh(sender:AnyObject) {
        self.viewModel?.getFacts()

    }
    
    func setupFactTableLayout(){
        
        factTableView.frame = view.bounds
        view.addSubview(factTableView)
        
        indicator.center = self.factTableView.center
        self.view.addSubview(indicator)        
    }
    
    
}


extension ViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}

extension ViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.facts.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "FactCell") as? UITableViewCell
        
        
        let fact = viewModel?.facts[indexPath.row]
        cell?.textLabel?.text =  fact?.title
        cell?.detailTextLabel?.text = fact?.description
        return cell!

    }
    
    
}

extension ViewController: ViewModelDelegate {
    
    func factDataUpdated() {
        
    }
}
