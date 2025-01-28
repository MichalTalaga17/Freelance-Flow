//
//  AddProjectView.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 26/01/2025.
//

import SwiftUI

struct AddTaskView: View {
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var status: TaskStatus = .inProgress
    @State private var priority: TaskPriority = .normal
    @State private var deadline: Date = Date()
    @State private var startTime: Date = Date()
    @State private var estimatedTime: String = ""
    @State private var selectedProject: Project? = nil
    @State private var projects: [Project] = []
    @State private var isLoadingProjects = true

    @Environment(\.presentationMode) var presentationMode
    var onSave: (ProjectTask) -> Void

    private let dataStore = FirebaseDataStore()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Task Name", text: $name)
                        .autocapitalization(.words)

                    TextField("Description", text: $description)
                        .autocapitalization(.sentences)

                    Picker("Status", selection: $status) {
                        ForEach(TaskStatus.allCases, id: \.self) { status in
                            Text(status.rawValue.capitalized).tag(status)
                        }
                    }

                    Picker("Priority", selection: $priority) {
                        ForEach(TaskPriority.allCases, id: \.self) { priority in
                            Text(priority.rawValue.capitalized).tag(priority)
                        }
                    }
                }
                Section(header: Text("Project")) {
                    if isLoadingProjects {
                        Text("Loading projects...")
                    } else {
                        Picker("Select Project", selection: $selectedProject) {
                            Text("None").tag(Project?.none)
                            ForEach(projects, id: \.id) { project in
                                Text(project.name).tag(project as Project?)
                            }
                        }
                    }
                }
                

                    

                Section(header: Text("Dates")) {
                    DatePicker("Deadline", selection: $deadline, displayedComponents: .date)
                    DatePicker("Start Time", selection: $startTime, displayedComponents: .hourAndMinute)
                }

                Section(header: Text("Estimated Time")) {
                    TextField("Estimated Time (hours)", text: $estimatedTime)
                        .keyboardType(.decimalPad)
                }
            }

            .navigationBarItems(
                leading: Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Text("Cancel")
                },
                trailing: Button(action: { saveTask() }) {
                    Text("Save")
                }
            )
            .navigationBarTitle("Add Task", displayMode: .inline)
            .onAppear {
                loadProjects()
            }
        }
    }

    private func loadProjects() {
        dataStore.fetchProjects { fetchedProjects in
            self.projects = fetchedProjects ?? []
            self.isLoadingProjects = false
        }
    }

    private func saveTask() {
        let estimatedTimeValue = TimeInterval(estimatedTime) ?? 0

        let task = ProjectTask(
            id: UUID().uuidString,
            projectId: selectedProject?.id ?? "",
            name: name,
            description: description.isEmpty ? nil : description,
            status: status,
            priority: priority,
            deadline: deadline,
            startTime: startTime,
            estimatedTime: estimatedTimeValue
        )

        onSave(task)
        presentationMode.wrappedValue.dismiss()
    }
}
