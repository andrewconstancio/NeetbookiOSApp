//
//  LoadingView.swift
//  UsersNeetBook
//
//  Created by Andrew Constancio on 9/13/22.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        Text("📚")
            .font(.system(size: 40))
        ProgressView()
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
