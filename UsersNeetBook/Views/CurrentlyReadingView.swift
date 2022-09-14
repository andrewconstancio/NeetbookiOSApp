//
//  CurrentlyReadingView.swift
//  UsersNeetBook
//
//  Created by Andrew Constancio on 5/9/22.
//

import SwiftUI
import Firebase
import GoogleSignIn
import SwiftUIPullToRefresh

struct CurrentlyReadingView: View {
    
    @State var refreshControl = UIRefreshControl()
    @ObservedObject var model = CurrentlyReadingModel()
    @AppStorage("Log_Status") var log_Status = false
    
    let profileURL = Auth.auth().currentUser?.photoURL
    
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
        .navigationTitle("Neetbook")
        .navigationBarItems(trailing:
            Button(action: {
                try! Auth.auth().signOut()
                log_Status = false
            }) {
                AsyncImage(url: profileURL) { image in
                       image
                           .resizable()
                           .scaledToFill()
                   } placeholder: {
                       ProgressView()
                   }
                   .frame(width: 44, height: 44)
                   .clipShape(Circle())
            }
        )
    }
     
    init() {
        model.getData()
    }
    
}

struct CurrentlyReadingView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentlyReadingView()
    }
}


struct PullToRefresh: View {
    
    var coordinateSpaceName: String
    var onRefresh: ()->Void
    
    @State var needRefresh: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            if (geo.frame(in: .named(coordinateSpaceName)).midY > 50) {
                Spacer()
                    .onAppear {
                        needRefresh = true
                    }
            } else if (geo.frame(in: .named(coordinateSpaceName)).maxY < 10) {
                Spacer()
                    .onAppear {
                        if needRefresh {
                            needRefresh = false
                            onRefresh()
                        }
                    }
            }
            HStack {
                Spacer()
                if needRefresh {
                    ProgressView()
                }
                Spacer()
            }
        }.padding(.top, -50)
    }
}
