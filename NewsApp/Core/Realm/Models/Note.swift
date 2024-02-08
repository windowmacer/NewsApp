
import Foundation
import RealmSwift

class Note: Object {
	@Persisted(primaryKey: true) var id: ObjectId
	@Persisted var title = ""
	@Persisted var author = ""
	@Persisted var dateNews = ""
	@Persisted var textNews  = ""
	@Persisted var imageData: Data?
}
