//
//  RemindersRepository.swift
//  MakeItSo-ReminderClone
//
//  Created by Ashraful Islam on 4/21/24.
//

import Combine
import Factory
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

class RemindersRepository: ObservableObject {
    //MARK: - Dependencies
    @Injected(\.firestore) var firestore
    @Injected(\.authenticationService) var authenticationService

    @Published var reminders = [Reminder]()

    @Published var user: User? = nil

    private var listenerRegistration: ListenerRegistration?
    private var cancellables = Set<AnyCancellable>()

    init() {
        authenticationService.$user
            .assign(to: &$user)

        $user.sink { user in
            self.unsubscribe()
            self.subscribe(user: user)
        }
        .store(in: &cancellables)

        subscribe()
    }

    deinit {
        unsubscribe()
    }

    func subscribe(user: User? = nil) {
        if listenerRegistration == nil {
            if let localUser = user ?? self.user {
                let query = firestore.collection(Reminder.collectionName)
                    .whereField("userId", isEqualTo: localUser.uid)
                listenerRegistration =
                    query
                    .addSnapshotListener { [weak self] (querySnapshot, error) in
                        guard let documents = querySnapshot?.documents else {
                            print("No documents in Firestore")
                            return
                        }

                        print("Mapping \(documents.count) documents")
                        self?.reminders = documents.compactMap { queryDocumentSnapshot in
                            do {
                                return try queryDocumentSnapshot.data(as: Reminder.self)
                            } catch {
                                print(
                                    "Error mapping document with ID: \(queryDocumentSnapshot.documentID): \(error.localizedDescription)"
                                )
                                return nil
                            }
                        }
                    }
            }
        }
    }

    private func unsubscribe() {
        if listenerRegistration != nil {
            listenerRegistration?.remove()
            listenerRegistration = nil
        }
    }

    func addReminder(_ reminder: Reminder) throws {
        var mutableReminder = reminder
        mutableReminder.userId = user?.uid

        try firestore
            .collection(Reminder.collectionName)
            .addDocument(from: mutableReminder)
    }

    func updateReminder(_ reminder: Reminder) throws {
        guard let documentID = reminder.id else {
            fatalError("Reminder \(reminder.title) has no document ID")
        }

        try firestore
            .collection(Reminder.collectionName)
            .document(documentID)
            .setData(from: reminder, merge: true)

    }

    func removeReminder(_ reminder: Reminder) {
        guard let documentID = reminder.id else {
            fatalError("Reminder \(reminder.title) has no document ID")
        }

        firestore
            .collection(Reminder.collectionName)
            .document(documentID)
            .delete()
    }
}
