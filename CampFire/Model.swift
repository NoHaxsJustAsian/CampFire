import FirebaseFirestoreSwift

struct User: Codable, Identifiable {
    @DocumentID var id: String?
    var username: String
    
    init() {
        self.id = nil
        self.username = ""
    }
    
    init(id: String?, username: String) {
        self.id = id
        self.username = username
    }
}

struct List: Codable, Identifiable {
    var id: String
    var name: String
    var tasks: [Task]
    
    init(id: String, name: String, tasks: [Task]) {
        self.id = id
        self.name = name
        self.tasks = tasks
    }
}

struct Task: Codable, Identifiable {
    @DocumentID var id: String?
    var finished: Bool
    var name: String
    
    init() {
        self.id = nil
        self.finished = false
        self.name = "Tap to edit"
    }
    
    init(id: String?, finished: Bool, name: String) {
        self.id = id
        self.finished = finished
        self.name = name
    }
}
