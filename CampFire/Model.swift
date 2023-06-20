import FirebaseFirestoreSwift

struct User: Codable, Identifiable {
    @DocumentID var id: String?
    var username: String
    var lists: [List]
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case lists
    }
    
    init() {
        self.id = nil
        self.username = ""
        self.lists = []
    }
    
    init(id: String?, username: String, lists: [List]) {
        self.id = id
        self.username = username
        self.lists = lists
    }
}

struct List: Codable, Identifiable {
    @DocumentID var id: String?
    var color: Int
    var name: String
    var tasks: [Task]
    
    enum CodingKeys: String, CodingKey {
        case id
        case color
        case name
        case tasks
    }
    
    init() {
        self.id = nil
        self.color = 0
        self.name = ""
        self.tasks = []
    }
    
    init(id: String?, color: Int, name: String, tasks: [Task]) {
        self.id = id
        self.color = color
        self.name = name
        self.tasks = tasks
    }
}

struct Task: Codable, Identifiable {
    @DocumentID var id: String?
    var description: String
    var finished: Bool
    var name: String
    var priority: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case description
        case finished
        case name
        case priority
    }
    
    init() {
        self.id = nil
        self.description = ""
        self.finished = false
        self.name = ""
        self.priority = 0
    }
    
    init(id: String?, description: String, finished: Bool, name: String, priority: Int) {
        self.id = id
        self.description = description
        self.finished = finished
        self.name = name
        self.priority = priority
    }
}
