//
//  LocalAuthViewModel.swift
//  LocalAuth
//
//  Created by Renan Wurster on 14.04.25.
//

import Foundation
import LocalAuthentication

@MainActor
class LocalAuthViewModel: ObservableObject {
    @Published var isUnlocked = false
    @Published var errorMessage: String?
    
    func authenticate() async {
        let context = LAContext()
        var error: NSError?
        let reason = "Unlock your secure content"
        
        errorMessage = nil
        
        guard context
            .canEvaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                error: &error
            )
        else {
            errorMessage = error?.localizedDescription
            return
        }
        
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
            case LAError.authenticationFailed:
                errorMessage = "Authentication failed. Try again."

            default:
                errorMessage = error.localizedDescription
            }
            isUnlocked = false
        }
    }
}


