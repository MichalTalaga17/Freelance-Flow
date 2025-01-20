//
//  LoadingView.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        Spacer()
        HStack{
            Spacer()
            ProgressView()
            Spacer()
        }
        Spacer()
    }
}

#Preview {
    LoadingView()
}
