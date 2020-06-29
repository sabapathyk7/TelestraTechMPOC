//
//  ViewModel.swift
//  TelestraTechMPOC
//
//  Created by kanagasabapathy on 29/06/20.
//  Copyright © 2020 kanagasabapathy. All rights reserved.
//

import Foundation
import UIKit

protocol VMDelegate: class {
    
}

class ViewModel {
    public weak var delete: VMDelegate? 
}
