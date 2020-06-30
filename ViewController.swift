//
//  ViewController.swift
//  TelestraTechMPOC
//
//  Created by kanagasabapathy on 29/06/20.
//  Copyright © 2020 kanagasabapathy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    private var viewModel: ViewModel!
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
        
        setupFactTableLayout()
        setLayoutConstraints()

        if self.viewModel == nil {
            self.viewModel = ViewModel()
        }
        self.viewModel?.getFacts()
    }
    
    @objc func pullToRefresh(sender:AnyObject) {
        self.viewModel?.getFacts()
//        factTableView.reloadData()


    }
    
    func setupFactTableLayout(){
        
        factTableView.frame = view.bounds
        view.addSubview(factTableView)
        
        indicator.center = self.factTableView.center
        self.view.addSubview(indicator)        
    }
    func setLayoutConstraints() {
        factTableView.translatesAutoresizingMaskIntoConstraints = false
        
        factTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        factTableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        factTableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        factTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
}


extension ViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}

extension ViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel?.facts.count as Any)
        return viewModel?.facts.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "FactCell") as? FactsTableViewCell
        
        
        let fact = viewModel?.facts[indexPath.row]
        cell?.factTitle.text = fact?.title
        cell?.factDesc.text = fact?.description
        cell?.imgView.image = UIImage(named: "placeholder.png")
        if let imagePath = fact?.imageHref {
            viewModel.obtainImageWithPath(imagePath: imagePath) { image in
                if let imageReceived = image, let updateCell = tableView.cellForRow(at: indexPath) as? FactsTableViewCell {
                    updateCell.imgView.image = imageReceived
                }
            }
        }
        return cell!

    }
    
    
}

extension ViewController: ViewModelDelegate {
    func factDataUpdated() {
        DispatchQueue.main.async { [weak self] in
            self?.factTableView.reloadData()
            self?.navigationItem.title = self?.viewModel.title
            self?.indicator.stopAnimating()
            self?.indicator.hidesWhenStopped = true
            self?.refreshControl.endRefreshing()
        }
    }
}
