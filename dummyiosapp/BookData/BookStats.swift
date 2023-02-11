//
//  BookStats.swift
//  dummyiosapp
//
//  Created by Maheen on 04/09/2022.
//

import Foundation

struct BookStats: Decodable{
    let localized_name: String
    let primary_attr: String
    let available: String
    let bookdescriptions: String
    let price: String
    let img: String
}
