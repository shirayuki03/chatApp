//
//  ContentView.swift
//  chatApp
//
//  Created by 小野伶也 on 2024/12/01.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @State private var isShowingView: Bool = false
    @State private var searchText = ""
    var myFriends: [String] = ["田中太郎", "佐藤花子"]
    var myAccount = UserDefaults.standard
    
    var body: some View {
        NavigationView {
            VStack {
                
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
        .sheet(isPresented: $isShowingView) {
            SetAccountView()
        }
        .onAppear {
            if myAccount.string(forKey: "myAccount") == nil {
                isShowingView = true
            }
        }
    }
}

struct SetAccountView: View {
    
    @State private var isShowingView: Bool = true
    @FocusState var isFocused: Bool
    @State private var userName = ""
    var maxUserNameLength: Int = 10
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("ユーザー名")
                        .font(.headline)
                        .padding()
                    TextField("10文字以内", text: $userName)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                        .onReceive(Just(userName)) { _ in
                            if userName.count > maxUserNameLength {
                                userName = String(userName.prefix(maxUserNameLength))
                            }
                        }
                        .focused($isFocused)
                }
                Button("完了") {
                    
                }
                .padding()
            }
            .navigationTitle("新規登録")
        }
        .interactiveDismissDisabled(isShowingView)
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
