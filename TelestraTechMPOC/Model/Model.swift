//
//  Model.swift
//  TelestraTechMPOC
//
//  Created by kanagasabapathy on 29/06/20.
//  Copyright © 2020 kanagasabapathy. All rights reserved.
//

import Foundation

//
// MARK: - Codable structure for model
//
struct FactData: Codable {
    let title: String?
    var rows: [Facts]
}

//
// MARK: - Codable structure for row items
//
struct Facts: Codable {
    let title, description, imageHref: String?
}
