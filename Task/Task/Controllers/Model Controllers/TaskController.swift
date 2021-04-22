//
//  TaskController.swift
//  Task
//
//  Created by Jantsen Tanner on 4/21/21.
//

import Foundation

class TaskController {
    
    static let sharedInstance = TaskController()
    
    
    var tasks: [Task] = []
    func createTaskWith(name: String, notes: String?, dueDate: Date?, isComplete: Bool){
        let newTask = Task(name: name, notes: notes, dueDate: dueDate, isComplete: isComplete)
        tasks.append(newTask)
        savePersistenceStore()
        
    }
    func update(task: Task, newName: String, newNotes: String?, newDueDate: Date?, isComplete: Bool) {
        task.name = newName
        task.notes = newNotes
        task.dueDate = newDueDate
        task.isComplete = isComplete
        
        savePersistenceStore()
        
        
    }
    
    func toggleIsComplete(task: Task) {
        task.isComplete = !task.isComplete
        savePersistenceStore()
        
    }
    func delete(task: Task){
        guard let index = tasks.firstIndex(of: task) else {return}
        tasks.remove(at: index)
        
        savePersistenceStore()
    }
    
    //MARK: - Persistence
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Task.json")
        return fileURL
    }
    func savePersistenceStore() {
        do {
            let data = try JSONEncoder().encode(tasks)
            try data.write(to: createPersistenceStore())
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
        
    }
    func loadFromPresistenceStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            tasks = try JSONDecoder().decode([Task].self, from: data)
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            
        }
        
    }
    
}
