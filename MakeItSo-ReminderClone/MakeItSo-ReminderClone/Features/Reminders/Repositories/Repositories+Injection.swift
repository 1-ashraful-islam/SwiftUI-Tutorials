//
//  Repositories+Injection.swift
//  MakeItSo-ReminderClone
//
//  Created by Ashraful Islam on 4/22/24.
//

import Factory
import Foundation

extension Container {
    var remindersRepository: Factory<RemindersRepository> {
        Factory(self) {
            RemindersRepository()
        }.singleton
    }
}
