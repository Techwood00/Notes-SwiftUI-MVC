
import Foundation
import SwiftUI

struct TaskListView: View {
    @ObservedObject var taskListController: TaskListController
    @State private var newTaskTitle = ""
    @State private var editMode: EditMode = .inactive
    @State private var selectedTask: Task?

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("New Task")) {
                    HStack {
                        TextField("Task title", text: $newTaskTitle)
                        Button(action: addTask) {
                            Text("Add")
                        }
                    }
                }
                Section(header: Text("Tasks")) {
                    ForEach(taskListController.tasks) { task in
                        if editMode == .active {
                            TaskRowView(task: task, isEditing: true, isSelected: task.id == selectedTask?.id, toggleTaskCompletion: toggleTaskCompletion, editTask: editTask, deleteTask: deleteTask)
                        } else {
                            NavigationLink(
                                destination: TaskDetailView(task: $taskListController.tasks[taskListController.tasks.firstIndex(where: { $0.id == task.id })!]),
                                label: {
                                    TaskRowView(task: task, isEditing: false, isSelected: false, toggleTaskCompletion: toggleTaskCompletion, editTask: nil, deleteTask: nil)
                                }
                            )
                        }
                    }
                    .onDelete(perform: deleteTasks)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarItems(trailing: EditButton())
            .navigationTitle("Todoist")
            .environment(\.editMode, $editMode)
        }
    }

    private func addTask() {
        if !newTaskTitle.isEmpty {
            taskListController.addTask(title: newTaskTitle)
            newTaskTitle = ""
        }
    }

    private func toggleTaskCompletion(task: Task) {
        taskListController.toggleTaskCompletion(task: task)
    }

    private func editTask(task: Task) {
        selectedTask = task
        editMode = .active
    }

    private func deleteTask(task: Task) {
        taskListController.deleteTask(task: task)
        selectedTask = nil
    }

    private func deleteTasks(at offsets: IndexSet) {
        for index in offsets {
            taskListController.deleteTask(task: taskListController.tasks[index])
        }
    }
}
