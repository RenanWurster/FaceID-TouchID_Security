//
//  HomeView.swift
//  LocalBiometricAuth
//
//  Created by Renan Wurster on 15.04.25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var localAuthViewModel: LocalAuthViewModel
    
    var body: some View {
        VStack {
            Text("Welcome to the Home View!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding(.bottom, 30)
            
            Button("Logout") {
                localAuthViewModel.isUnlocked = false
            }
            .font(.title2)
            .fontWeight(.semibold)
            .padding()
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(LocalAuthViewModel())
}
