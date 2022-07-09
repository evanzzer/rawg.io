import Foundation

public struct GamesModel: Identifiable {
    public let id: Int
    public let name: String
    public let released: String?
    public let imageUrl: String?
    public let rating: Double
    
    public init(id: Int, name: String, released: String?, imageUrl: String?, rating: Double) {
        self.id = id
        self.name = name
        self.released = released
        self.imageUrl = imageUrl
        self.rating = rating
    }
}
