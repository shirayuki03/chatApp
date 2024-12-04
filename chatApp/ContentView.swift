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
    @FocusState var isFocused_name: Bool
    @FocusState var isFocused_password: Bool
    @FocusState var isFocused_id: Bool
    @State private var userName = ""
    @State private var password = ""
    @State private var id = ""
    var maxUserNameLength: Int = 10
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    HStack {
                        Image(systemName: "exclamationmark.circle")
                            .font(.title)
                        Text("ユーザー名、パスワードは後から変える\nことができます。")
                    }
                }
                .frame(width: 350, height: 100)
                .background(Color(red: 1.0, green: 1.0, blue: 0.0, opacity: 1.0))
                .cornerRadius(10)
                HStack {
                    Spacer(minLength: 25)
                    Text("ID")
                        .font(.headline)
                    Spacer(minLength: 30)
                    TextField("半角英数字", text: $id)
                        .textFieldStyle(.roundedBorder)
                        .focused($isFocused_id)
                    Spacer(minLength: 25)
                }
                HStack {
                    Spacer()
                    Text("ユーザー名")
                        .font(.headline)
                    Spacer()
                    TextField("10文字以内", text: $userName)
                        .frame(width: 250)
                        .textFieldStyle(.roundedBorder)
                        .onReceive(Just(userName)) { _ in
                            if userName.count > maxUserNameLength {
                                userName = String(userName.prefix(maxUserNameLength))
                            }
                        }
                        .focused($isFocused_name)
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text("パスワード")
                        .font(.headline)
                    Spacer()
                    TextField("半角英数字", text: $password)
                        .frame(width: 250)
                        .textFieldStyle(.roundedBorder)
                        .focused($isFocused_password)
                    Spacer()
                }
                Button {
                    //
                } label: {
                    Text("完了")
                        .foregroundColor(Color.white)
                        .bold()
                }
                .frame(width: 300, height: 50)
                .background(Color.yellow)
                .font(.title2)
                .cornerRadius(5)
            }
            .navigationTitle("新規登録")
        }
        .interactiveDismissDisabled(isShowingView)
        .onTapGesture {
            isFocused_name = false
            isFocused_password = false
            isFocused_id = false
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
