//
//  RegisterRequest.swift
//  GeoCheckAPI
//
//  Created by Dmitriy on 21.08.2025.
//

import Vapor

struct RegisterRequest: Content {
    let email: String
    let username: String
    let password: String
}
