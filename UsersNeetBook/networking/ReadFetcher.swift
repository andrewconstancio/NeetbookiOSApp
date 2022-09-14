//
//  ReadModel.swift
//  UsersNeetBook
//
//  Created by Andrew Constancio on 5/11/22.
//

import Foundation
import Firebase

class ReadFetcher: ObservableObject {
    @Published var books = [Book]()
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    init() {
        getData()
    }

    func getData() {
        
        // get ref to database
        let db = Firestore.firestore()
        let currUID = Auth.auth().currentUser?.uid ?? ""
        
        isLoading = true
        
        // read the docs on file path
        db.collection("UserBookRead")
            .whereField("uid", isEqualTo: currUID)
            .whereField("read", isEqualTo: true)
            .getDocuments { snapshot, error in
                
                if error == nil {
                    self.isLoading = false
                    if let snapshot = snapshot {
                        
                        DispatchQueue.main.async {
                            self.books = snapshot.documents.map{doc in
                                
                                return Book(
                                            id: doc.documentID,
                                            bookEditionKey: doc["bookEditionKey"] as? String ?? "",
                                            currentlyReading: doc["currentlyReading"] as? Bool ?? false,
                                            wantsToRead: doc["wantsToRead"] as? Bool ?? false,
                                            read: doc["read"] as? Bool ?? false,
                                            uid: doc["uid"] as? String ?? "",
                                            coverId: doc["coverId"] as? Int ?? 0
                                        )
                            }
                        }
                    }
                } else {
                    print("error")
                    self.isLoading = false
                    self.errorMessage = error?.localizedDescription
                }
        }
    }
}