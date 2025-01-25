//
//  OverviewView.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//

import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel = DashboardViewModel(dataStore: FirebaseDataStore())

    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    if viewModel.isLoading {
                        LoadingView()
                    } else if let error = viewModel.error {
                        Text("Error: \(error)")
                    } else {
                         DashboardTile(title: "Total Projects", value: viewModel.totalProjects)
                        DashboardTile(title: "Active Projects", value: viewModel.activeProjects)
                        DashboardTile(title: "Completed Projects", value: viewModel.completedProjects)
                        DashboardTile(title: "Total Tasks", value: viewModel.totalTasks)
                        DashboardTile(title: "Open Tasks", value: viewModel.openTasks)
                        DashboardTile(title: "Completed Tasks", value: viewModel.completedTasks)
                    }
                }
                .padding()
            }
        }
        .task {
            await viewModel.fetchStats()
        }
    }
}

struct DashboardTile: View {
    let title: String
    let value: String

    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .multilineTextAlignment(.center)
            Spacer()
            Text(value)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 2)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.primary.opacity(0.1))
        .cornerRadius(8)
    }
}

#Preview {
    DashboardView()
}
