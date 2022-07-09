import Foundation
import RealmSwift

public class GamesEntity: Object {
    @objc public dynamic var id: Int = 0
    @objc public dynamic var imageUrl: String?
    @objc public dynamic var name: String = ""
    @objc public dynamic var rating: Double = 0.0
    @objc public dynamic var released: String? = ""
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}
