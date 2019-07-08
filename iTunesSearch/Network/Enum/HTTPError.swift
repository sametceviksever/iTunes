//
//  HTTPError.swift
//  BaseProject
//
//  Created by Samet Çeviksever on 12.02.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import Foundation

public enum HTTPError: String {
    case unAuthorized = "401"
    case wrong = "404"
    case serverNotAvaible = "500"
    
    public var localizedDescription: String {
        switch self {
        case .unAuthorized:
            return "Unauthorized request".local
        case .serverNotAvaible:
            return "Server not avaible".local
        case .wrong:
            return "Wrong request".local
        }
    }
}
