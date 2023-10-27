
import SwiftUI

struct TaskRowView: View {
    var task: Task
    var isEditing: Bool
    var isSelected: Bool
    var toggleTaskCompletion: (Task) -> Void
    var editTask: ((Task) -> Void)?
    var deleteTask: ((Task) -> Void)?
    
    var body: some View {
        HStack {
            Button(action: {
                toggleTaskCompletion(task)
            }) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
            }
            Text(task.title)
            Spacer()
            if isEditing {
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                }
                Button(action: {
                    editTask?(task)
                }) {
                    Image(systemName: "pencil.circle")
                        .foregroundColor(.blue)
                }
                .padding(.trailing, 20)
                Button(action: {
                    deleteTask?(task)
                }) {
                    Image(systemName: "trash.circle")
                        .foregroundColor(.red)
                }
            }
        }
    }
}

