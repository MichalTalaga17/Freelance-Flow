//
//  OverviewView.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//

import SwiftUI

struct OverviewView: View {
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(){
                VStack(spacing: 0) {
                    HStack {
                        VStack{
                            Text("Hours spend on projects")
                                .font(.title)
                        }.frame(
                            maxWidth: .infinity
                        )
                    }
                    .border(Color.gray)
                    
                    HStack {
                        VStack{
                            Text("Hours spend on projects")
                                .font(.title)
                        }.frame(
                            maxWidth: .infinity
                        )
                        .border(Color.gray)
                        VStack{
                            Text("Hours spend on projects")
                                .font(.title)
                        }.frame(
                            maxWidth: .infinity
                        )
                        .border(Color.gray)
                    }
                    
                    HStack {
                        VStack{
                            Text("Hours spend on projects")
                                .font(.title)
                        }.frame(
                            maxWidth: .infinity
                        )
                    }
                    HStack {
                        VStack{
                            Text("Hours spend on projects")
                                .font(.title)
                        }.frame(
                            maxWidth: .infinity
                        )
                    }
                    HStack {
                        VStack{
                            Text("Hours spend on projects")
                                .font(.title)
                        }.frame(
                            maxWidth: .infinity
                        )
                    }
                    HStack {
                        VStack{
                            Text("Hours spend on projects")
                                .font(.title)
                        }.frame(
                            maxWidth: .infinity
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    OverviewView()
}
