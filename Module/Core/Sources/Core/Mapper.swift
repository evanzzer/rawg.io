//
//  File.swift
//  
//
//  Created by Leafy on 06/07/22.
//

import Foundation

public protocol Mapper {
    associatedtype Object
    associatedtype Transformed
    
    func transform(object: Object) -> Transformed
}
