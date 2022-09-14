//
//  ErrorView.swift
//  UsersNeetBook
//
//  Created by Andrew Constancio on 9/13/22.
//

import SwiftUI

struct ErrorView: View {
    
    @ObservedObject var readFetcher = ReadFetcher()
    
    var body: some View {
        Text("Error")
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(readFetcher: ReadFetcher())
    }
}
