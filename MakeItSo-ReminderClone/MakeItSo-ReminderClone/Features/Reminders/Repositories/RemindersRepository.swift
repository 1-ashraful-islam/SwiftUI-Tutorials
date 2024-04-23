//
//  RemindersRepository.swift
//  MakeItSo-ReminderClone
//
//  Created by Ashraful Islam on 4/21/24.
//

import Factory
import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

class RemindersRepository: ObservableObject {
    //MARK: - Dependencies
    @Injected(\.firestore) var firestore

    @Published var reminders = [Reminder]()

    private var listenerRegistration: ListenerRegistration?

    init() {
        subscribe()
    }

    deinit {
        unsubscribe()
    }

    func subscribe() {
        if listenerRegistration == nil {
            let query = firestore.collection(Reminder.collectionName)

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

    private func unsubscribe() {
        if listenerRegistration != nil {
            listenerRegistration?.remove()
            listenerRegistration = nil
        }
    }

    func addReminder(_ reminder: Reminder) throws {
        try firestore
            .collection(Reminder.collectionName)
            .addDocument(from: reminder)
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
