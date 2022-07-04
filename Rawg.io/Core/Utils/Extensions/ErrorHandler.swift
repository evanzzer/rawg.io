//
//  ErrorHandler.swift
//  Rawg.io
//
//  Created by Leafy on 24/06/22.
//

import Foundation

enum URLError: LocalizedError {
    
    case invalidResponse
    case addressUnreachable
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse: return "The server responded with garbage."
        case .addressUnreachable: return "Network Host is unreachable."
        }
    }
    
}

enum DatabaseError: LocalizedError {
    
    case invalidInstance
    case requestFailed
    
    var errorDescription: String? {
        switch self {
        case .invalidInstance: return "Database can't instance."
        case .requestFailed: return "Your request failed."
        }
    }
    
}
