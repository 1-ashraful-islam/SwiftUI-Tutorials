//
//  AuthenticationService+Injection.swift
//  MakeItSo-ReminderClone
//
//  Created by Ashraful Islam on 4/23/24.
//

import Factory
import Foundation

extension Container {
    public var authenticationService: Factory<AuthenticationService> {
        Factory(self) {
            AuthenticationService()
        }.singleton
    }
}
