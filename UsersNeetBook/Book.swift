//
//  Book.swift
//  UsersNeetBook
//
//  Created by Andrew Constancio on 5/11/22.
//

import Foundation

struct Book: Identifiable {
    let id: String
    let bookEditionKey: String
    let currentlyReading: Bool
    let wantsToRead: Bool
    let read: Bool
    let uid: String
    let coverId: Int
}
