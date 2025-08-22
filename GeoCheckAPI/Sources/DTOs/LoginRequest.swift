//
//  LoginRequest.swift
//  GeoCheckAPI
//
//  Created by Dmitriy on 21.08.2025.
//

import Vapor

struct LoginRequest: Content {
    let email: String
    let password: String
}
