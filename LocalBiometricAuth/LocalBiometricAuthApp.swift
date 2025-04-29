//
//  LocalBiometricAuthApp.swift
//  LocalBiometricAuth
//
//  Created by Renan Wurster on 15.04.25.
//

import SwiftUI

@main
struct LocalBiometricAuthApp: App {
    @StateObject private var localAuthViewModel = LocalAuthViewModel()
    @Environment(\.scenePhase) var scenePhase
    
    
    var body: some Scene {
        WindowGroup {
            LocalAuthView()
        }
        .environmentObject(localAuthViewModel)
        .onChange(of: scenePhase) {
            if scenePhase == .inactive {
                localAuthViewModel.isUnlocked = false
            }
        }
    }
}
