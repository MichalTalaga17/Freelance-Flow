//
//  OverviewView.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//

import SwiftUI

struct DashboardView: View {
    @StateObject var dashboardViewModel: DashboardViewModel

    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    if dashboardViewModel.isLoading {
                        LoadingView()
                    } else if let error = dashboardViewModel.error {
                        Text("Error: \(error)")
                    } else {
                        DashboardTile(title: "Total Projects", value: dashboardViewModel.totalProjects)
                        DashboardTile(title: "Active Projects", value: dashboardViewModel.activeProjects)
                        DashboardTile(title: "Completed Projects", value: dashboardViewModel.completedProjects)
                        DashboardTile(title: "Total Tasks", value: dashboardViewModel.totalTasks)
                        DashboardTile(title: "Open Tasks", value: dashboardViewModel.openTasks)
                        DashboardTile(title: "Completed Tasks", value: dashboardViewModel.completedTasks)
                    }
                }
                .padding()
            }
        }
        .onAppear {
           Task {
               await dashboardViewModel.fetchStats()
           }
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
    DashboardView(dashboardViewModel: DashboardViewModel(dataStore: FirebaseDataStore()))
}
