//
//  ReadView.swift
//  UsersNeetBook
//
//  Created by Andrew Constancio on 5/9/22.
//

import SwiftUI

struct ReadView: View {
    @State var refreshControl = UIRefreshControl()
    @ObservedObject var readFetcher = ReadFetcher()
    @AppStorage("Log_Status") var log_Status = false
    
    var body: some View {
        if readFetcher.isLoading {
            LoadingView()
        } else if readFetcher.errorMessage != nil {
            ErrorView(readFetcher: readFetcher)
        } else {
            ScrollView {
                PullToRefresh(coordinateSpaceName: "pullToRefresh") {
                    // do your stuff when pulled
                    readFetcher.getData()
                }
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                    ForEach(readFetcher.books) { item in
                        AsyncImage(url: URL(string: "https://covers.openlibrary.org/b/id/\(item.coverId).jpg")) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            Text("Loading")
                        }
                        .frame(width: 150, height: 225, alignment: .center)
                        .cornerRadius(20)
                    }
                }
            }
            .coordinateSpace(name: "pullToRefresh")
            .navigationTitle("Read")
            .navigationBarItems(trailing:
                 Image(systemName: "person.crop.circle")
                     .imageScale(.large)
            )
        }
    }
}

struct ReadView_Previews: PreviewProvider {
    static var previews: some View {
        ReadView()
    }
}
