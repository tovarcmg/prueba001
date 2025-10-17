//
//  ParentRequestBody.swift
//  PacoMax
//
//  Created by Luis on 14/07/22.
//  Copyright © 2022 E1Technology. All rights reserved.
//

import Foundation

struct ParentRequestBody: Encodable {
    
    let email: String
    let numberOfKids: Int
    let username: String
    let password: String
    let phoneNumber: String
    let avatar: String
    let userFullName: String
    
}
