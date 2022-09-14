//
//  WantToReadView.swift
//  UsersNeetBook
//
//  Created by Andrew Constancio on 5/9/22.
//

import SwiftUI

struct WantToReadView: View {
    
    @State var refreshControl = UIRefreshControl()
    @ObservedObject var model = WantToReadModel()
    @AppStorage("Log_Status") var log_Status = false
    
    var body: some View {
        
        ScrollView {
            PullToRefresh(coordinateSpaceName: "pullToRefresh") {
                // do your stuff when pulled
                model.getData()
            }
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                ForEach(model.books) { item in
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
        .navigationTitle("Want To Read")
        .navigationBarItems(trailing:
             Image(systemName: "person.crop.circle")
                 .imageScale(.large)
        )
    }
    
    
    init() {
        model.getData()
    }
}

struct WantToReadView_Previews: PreviewProvider {
    static var previews: some View {
        WantToReadView()
    }
}
