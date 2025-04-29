//
//  LocalAuthViewModel.swift
//  LocalBiometricAuth
//
//  Created by Renan Wurster on 15.04.25.
//

import Foundation
import LocalAuthentication

@MainActor
class LocalAuthViewModel: ObservableObject {
    @Published var isUnlocked = false
    @Published var errorMessage: String?
    
    func authenticate() async {
        let context = LAContext()
        let reason = "Unlock your secure content"
        
        errorMessage = nil
        
        do {
            let success = try await context.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                localizedReason: reason
            )
            isUnlocked = success

        } catch {
            switch error {
            case LAError.userCancel:
                errorMessage = "Authentication canceled."
            case LAError.systemCancel:
                errorMessage = "Authentication canceled by the system."
            case LAError.authenticationFailed:
                errorMessage = "Authentication failed. Try again."

            default:
                errorMessage = error.localizedDescription
            }
            isUnlocked = false
        }
    }
}
