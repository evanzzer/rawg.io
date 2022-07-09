//
//  File.swift
//  
//
//  Created by Leafy on 06/07/22.
//

import Combine
 
public protocol LocaleDataSource {
    associatedtype Request
    associatedtype Response
    
    func list(request: Request?) -> AnyPublisher<[Response], Error>
    func add(entity: Response) -> AnyPublisher<Bool, Error>
    func get(id: Int) -> AnyPublisher<Bool, Error>
    func delete(id: Int) -> AnyPublisher<Bool, Error>
}
