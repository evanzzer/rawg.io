//
//  File.swift
//  
//
//  Created by Leafy on 06/07/22.
//

import Combine

public protocol UseCase {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
