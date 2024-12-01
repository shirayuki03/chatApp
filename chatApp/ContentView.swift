//
//  ContentView.swift
//  chatApp
//
//  Created by 小野伶也 on 2024/12/01.
//

import SwiftUI

struct ContentView: View {
    
    @State private var searchText = ""
    var myFriends: [String] = ["田中太郎", "佐藤花子"]
    
    var body: some View {
        NavigationView {
            List(self.myFriends, id: \.self) { friend in
                NavigationLink(
                    destination: TalkView(),
                    label: {
                        HStack {
                            Image(systemName: "person.crop.circle")
                                .font(.largeTitle)
                            VStack {
                                Text(friend)
                                    .font(.headline)
                                Text("最後の会話")
                                    .font(.subheadline)
                            }
                        }
                    })
            }
            .navigationTitle("トーク")
            .searchable(text: $searchText)
        }
    }
}

struct TalkView: View {
    var body: some View {
        VStack {
            
        }
    }
}

#Preview {
    ContentView()
}
