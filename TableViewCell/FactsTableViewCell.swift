//
//  TableViewCell.swift
//  TelestraTechMPOC
//
//  Created by kanagasabapathy on 29/06/20.
//  Copyright © 2020 kanagasabapathy. All rights reserved.
//

import UIKit

class FactsTableViewCell: UITableViewCell {
    
    let imgView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.clipsToBounds = true
        return img
    }()
    
    let factTitle:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let factDesc:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor =  UIColor.lightGray
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(imgView)
        containerView.addSubview(factTitle)
        containerView.addSubview(factDesc)
        self.contentView.addSubview(containerView)
        
        self.preservesSuperviewLayoutMargins = true
        self.contentView.preservesSuperviewLayoutMargins = true
        
        imgView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        imgView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        imgView.widthAnchor.constraint(equalToConstant:70).isActive = true
        imgView.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.imgView.trailingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.heightAnchor.constraint(equalTo:self.contentView.heightAnchor, constant:-20).isActive = true
        
        factTitle.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        factTitle.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        factTitle.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        
        factDesc.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        factDesc.topAnchor.constraint(equalTo:self.factTitle.bottomAnchor).isActive = true
        factDesc.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        
        let containerViewHeightConstant = containerView.heightAnchor.constraint(equalToConstant: 1)
        containerViewHeightConstant.priority = UILayoutPriority.init(999)
        containerViewHeightConstant.isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
