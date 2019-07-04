//
//  Network.swift
//  BaseProject
//
//  Created by Samet Çeviksever on 12.02.2019.
//  Copyright © 2019 Samet Çeviksever. All rights reserved.
//

import Foundation

public typealias NetworkResponseBlock<T: Decodable> = ((Result<T, NetworkError>) -> Void)

public final class Network {
  static var shared: Network = Network()
  
  public final func call<T: Request> (with request: T) {
    guard let urlRequest = request.getURLRequest() else {
      let defaultError = NetworkError.default
      request.handler?(.failure(defaultError))
      return
    }
    
    URLSession.shared.dataTask(with: urlRequest) {[unowned self] (data, urlResponse, error) in
      DispatchQueue.main.async {
        if let error = error {
          let reqError = NetworkError.custom(error)
          request.handler?(.failure(reqError))
          return
        } else if let error = self.lookHttpError(urlResponse) {
          request.handler?(.failure(error))
          return
        }
        
        guard let data = data else {
          let defaultError = NetworkError.default
          request.handler?(.failure(defaultError))
          return
        }
        do {
          let result: T.ResponseType = try data.decode()
          request.handler?(.success(result))
        } catch let error {
          request.handler?(.failure(NetworkError.custom(error)))
        }
      }
      }.resume()
  }
  
  private func lookHttpError(_ response: URLResponse?) -> NetworkError? {
    guard let httpResponse = response as? HTTPURLResponse else {
      return .default
    }
    
    let code = httpResponse.statusCode
    if code > 199 && code < 300 {
      return nil
    }
    
    return .http(code)
  }
}
