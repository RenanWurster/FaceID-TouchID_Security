//
//  ContentView.swift
//  LocalBiometricAuth
//
//  Created by Renan Wurster on 15.04.25.
//

import SwiftUI
import LocalAuthentication


struct LocalAuthView: View {
    @State private var isAuthorize = false
    @EnvironmentObject private var localAuthViewModel: LocalAuthViewModel

    
    var body: some View {
        if localAuthViewModel.isUnlocked {
            HomeView()
        } else {
            
            VStack {
                Text("Please authenticate to continue.")
                    .font(.headline)
                    .padding()
                
                if let error = localAuthViewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                    
                    Button("Authenticate") {
                        Task {
                            await localAuthViewModel.authenticate()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
            }
            .task {
                await localAuthViewModel.authenticate()
            }
        }
        
    }
}


#Preview {
    LocalAuthView()
        .environmentObject(LocalAuthViewModel())
}
