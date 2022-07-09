//
//  ErrorHandler.swift
//  Rawg.io
//
//  Created by Leafy on 24/06/22.
//

import Foundation

public enum URLError: LocalizedError {
    
    case invalidURL
    case invalidResponse
    case addressUnreachable
    
    public var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid Request URL."
        case .invalidResponse: return "The server responded with garbage."
        case .addressUnreachable: return "Network Host is unreachable."
        }
    }
    
}

public enum DatabaseError: LocalizedError {
    
    case invalidInstance
    case requestFailed
    
    public var errorDescription: String? {
        switch self {
        case .invalidInstance: return "Database can't instance."
        case .requestFailed: return "Your request failed."
        }
    }
    
}
