//
//  ViewModel.swift
//  TelestraTechMPOC
//
//  Created by kanagasabapathy on 29/06/20.
//  Copyright © 2020 kanagasabapathy. All rights reserved.
//

import Foundation
import UIKit

protocol ViewModelDelegate: class {
    func factDataUpdated()
}

final class ViewModel {
    public weak var delegate: ViewModelDelegate?
    
    var title: String = ""
    var facts: [Facts] = [] {
        didSet{
            delegate?.factDataUpdated()
        }
    }
    
    func getFacts() {
        DispatchQueue.main.async {

        Services.shared.getFactResults { (factData) in
            guard let receivedData = factData, let title = factData?.title else {
                return
            }
            self.title = title
            self.facts = receivedData.rows
        }
        }
    }
}
