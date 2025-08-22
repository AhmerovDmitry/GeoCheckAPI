//
//  LoginResponse.swift
//  GeoCheckAPI
//
//  Created by Dmitriy on 21.08.2025.
//

import Vapor

struct LoginResponse: Content {
    let id: UUID
    let email: String
    let username: String
    let token: String
}
