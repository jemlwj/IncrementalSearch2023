//
//  ContentView.swift
//  IncrementalSearch2023
//
//  Created by Jeremy Lua on 17/2/23.
//  Copyright © 2023 Jeremy Lua. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        List(array, id: \.identifier) { item in
            VStack(alignment: .leading, spacing: 5) {
                Text(item.full_name)
                Text(item.html_url)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
