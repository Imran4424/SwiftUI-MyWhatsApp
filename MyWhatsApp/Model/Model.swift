//
//  Model.swift
//  MyWhatsApp
//
//  Created by Shah Md Imran Hossain on 30/12/23.
//

import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

@MainActor
class Model: ObservableObject {
    @Published var groups: [Group] = []
    @Published var chatMessages: [ChatMessage] = []
    
    var firestoreListener: ListenerRegistration?
    
    func updateDisplayName(for user: User, displayName: String) async throws {
        let request = user.createProfileChangeRequest()
        request.displayName = displayName
        try? await request.commitChanges()
    }
    
    func listenForChatMessages(in group: Group) {
        chatMessages.removeAll()
        
        guard let groupDocumentId = group.documentId else {
            print("group document id is nil")
            return
        }
        
        let db = Firestore.firestore()
        
        self.firestoreListener = db.collection("groups")
            .document(groupDocumentId)
            .collection("messages")
            .order(by: "dateCreated", descending: false)
            .addSnapshotListener({ [weak self] snapshot, error in
                guard let snapshot else {
                    print("error fetching snapshots: \(String(describing: error?.localizedDescription))")
                    return
                }
                
                snapshot.documentChanges.forEach { diff in
                    if diff.type == .added {
                        let chatMessage = ChatMessage.fromSnapshot(snapshot: diff.document)
                        
                        if let chatMessage {
                            let exists = self?.chatMessages.contains(where: { cm in
                                cm.documentId == chatMessage.documentId
                            })
                            
                            if !(exists!) {
                                self?.chatMessages.append(chatMessage)
                            }
                        }
                    }
                }
            })
        
    }
    
    func populateGroups() async throws {
        let db = Firestore.firestore()
        let snapshot = try await db.collection("groups")
            .getDocuments()
        
        groups = snapshot.documents.compactMap { snapshot in
            // we need to get a group based on snapshot
            return Group.fromSnapshot(snapshot: snapshot)
        }
    }
    
    func saveChatMessageToGroup(chatMessage: ChatMessage, group: Group) async throws {
        let db = Firestore.firestore()
        guard let groupDocumentId = group.documentId else {
            print("group document id is nil")
            return
        }
        
        let _ = try await  db.collection("groups")
            .document(groupDocumentId)
            .collection("messages")
            .addDocument(data: chatMessage.toDictionary())
    }
    
    /*
    func saveChatMessageToGroup(text: String, group: Group, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        guard let groupDocumentId = group.documentId else {
            print("group document id is nil")
            return
        }
        
        db.collection("groups")
            .document(groupDocumentId)
            .collection("messages")
            .addDocument(data: ["chatText": text]) { error in
                completion(error)
            }
    }
    */
    
    func saveGroup(group: Group, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        var docRef: DocumentReference? = nil
        docRef = db.collection("groups")
            .addDocument(data: group.toDictionary()) { [weak self] error in
                if error != nil {
                    completion(error)
                } else {
                    // add the group to groups array
                    if let docRef {
                        var newGroup = group
                        newGroup.documentId = docRef.documentID
                        self?.groups.append(newGroup)
                        completion(nil)
                    } else {
                        completion(nil)
                    }
                }
            }
    }
}
