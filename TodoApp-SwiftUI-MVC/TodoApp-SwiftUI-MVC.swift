
import SwiftUI

@main
struct TodoApp_SwiftUI_MVCApp: App {
    @StateObject var taskListController = TaskListController()
    
    var body: some Scene {
        WindowGroup {
            TaskListView(taskListController: taskListController)
        }
    }
}
