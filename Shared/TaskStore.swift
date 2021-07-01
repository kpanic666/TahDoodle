//
//  TaskStore.swift
//  TahDoodle
//
//  Created by Andrei Korikov on 29.06.2021.
//

import Foundation

class TaskStore: ObservableObject {
    @Published private(set) var tasks: [Task] = []
    
    init() {
        loadTask()
    }
    
    private let fileURL: URL = {
        let fileManager = FileManager.default
        let documentDirectories = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        
        let myDocumentDirectory = documentDirectories.first!
        let taskFileURL = myDocumentDirectory.appendingPathComponent("tasks.json")
        print("Tasks file is \(taskFileURL)")
        return taskFileURL
    }()
    
    private func saveTask() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(tasks)
            try data.write(to: fileURL)
            print("Saved \(tasks.count) tasks to \(fileURL.path)")
        } catch {
            print("Could not save tasks. Reason \(error)")
        }
    }
    
    private func loadTask() {
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            tasks = try decoder.decode([Task].self, from: data)
            print("Loaded \(tasks.count) tasks from \(fileURL.path)")
        } catch {
            print("Did not load any tasks. Reason: \(error)")
        }
    }
    
    func add(_ task: Task) {
        tasks.append(task)
        saveTask()
    }
    
    func remove(_ task: Task) {
        guard let index = tasks.firstIndex(of: task) else { return }
        tasks.remove(at: index)
        saveTask()
    }
}

#if DEBUG
extension TaskStore {
    static var sample: TaskStore = {
        let tasks = [
            Task(title: "Add features"),
            Task(title: "Fix bugs"),
            Task(title: "Ship it")
        ]
        let store = TaskStore()
        store.tasks = tasks
        return store
    }()
}
#endif
