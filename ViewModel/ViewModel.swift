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
    var cache:NSCache<NSString, UIImage> = NSCache()
    
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
    func obtainImageWithPath(imagePath: String, completionHandler: @escaping (UIImage?) -> Void) {
        if let image = self.cache.object(forKey: imagePath as NSString) {
            DispatchQueue.main.async {
                completionHandler(image)
            }
        } else {
            Services.shared.obtainImageDataWithPath(imagePath: imagePath, completionHandler: {(data) in
                guard let imageData = data else {
                    return
                }
                if let image = UIImage(data: imageData) {
                    self.cache.setObject(image, forKey: imagePath as NSString)
                    DispatchQueue.main.async {
                        completionHandler(image)
                    }
                }
            })
        }
    }
}
