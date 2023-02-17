//
//  ContentView.swift
//  IncrementalSearch2023
//
//  Created by Jeremy Lua on 17/2/23.
//  Copyright © 2023 Jeremy Lua. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var query: String = ""

    var body: some View {
        VStack {
            //Searchable is possible but due to development environment limitations, TextField is used instead.
            TextField(
                "Enter search query",
                text: $query,
                onCommit: {
                    //When return is pressed on the keyboard, run this block
                    //run API here
                }
            )
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            
            //List of Item objects to be populated here
            List(array, id: \.identifier) { item in
                VStack(alignment: .leading, spacing: 5) {
                    Text(item.full_name)
                    Text(item.html_url)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
