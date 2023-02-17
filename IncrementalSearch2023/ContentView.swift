//
//  ContentView.swift
//  IncrementalSearch2023
//
//  Created by Jeremy Lua on 17/2/23.
//  Copyright © 2023 Jeremy Lua. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @State var array: [Item] = []
    @State private var query: String = ""

    @State private var cancellable: AnyCancellable?

    @State private var page = 0
    
    private let itemDataSource: ItemDataSource = ItemDataSource()
    
    var body: some View {
        VStack {
            //Searchable is possible but due to development environment limitations, TextField is used instead.
            TextField(
                "Enter search query",
                text: $query,
                onCommit: {
                    //When return is pressed on the keyboard, run this block
                    
                    //empty array and reset page index to 0 to start from the top
                    self.page = 0
                    self.array.removeAll()
                    
                    //run the API and retrieve the first page
                    self.cancellable = self.itemDataSource.loadList(query: self.query, completion: { items in
                        self.array.append(contentsOf: items)
                    })
                }
            )
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            
            //List of Item objects to be populated here
            List(array, id: \.identifier) { item in
                VStack(alignment: .leading, spacing: 5) {
                    Text(item.full_name)
                    Text(item.html_url)
                }.onAppear {
                    //when list is scrolled to the last item.
                    //empty query validation to ensure API doesn't get called unnecessarily
                    if self.array.last?.identifier == item.identifier && !self.query.isEmpty {
                        //increment page count
                        self.page += 1
                        
                        //request data for the next page
                        self.cancellable = self.itemDataSource.loadList(query: self.query, page: self.page, completion: { items in
                            self.array.append(contentsOf: items)
                        })
                    }
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
