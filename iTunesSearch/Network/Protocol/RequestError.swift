//
//  RequestError.swift
//  BaseProject
//
//  Created by Samet Çeviksever on 12.02.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import Foundation

public protocol RequestError {
    var localizedError: String {get set}
    var errorCode: String {get set}
    init(with error: Error)
    init?(with urlResponse: URLResponse?)
}
