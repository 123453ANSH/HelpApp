//
//  ContentView.swift
//  ChatBox
//
//  Created by Abhigya Wangoo on 6/16/20.
//  Copyright © 2020 Abhigya Wangoo. All rights reserved.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    
    @State var isActive = false
    @State var username: String = ""
    @State var password: String = ""
    var body: some View {
        NavigationView{
            ZStack{
                Image("Back").resizable().scaledToFill()
                VStack{
                    Image(systemName: "person.crop.circle.fill").resizable().frame(width: 100, height: 100).padding()
                
                    TextField("Username", text: $username).padding()
                        .frame(width: 300, height: 50, alignment: .center)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 100)
                                .stroke(Color.red, lineWidth: 3)
                        )
                
                    TextField("Password", text: $password).padding()
                        .frame(width: 300, height: 50, alignment: .center)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 100)
                                .stroke(Color.red, lineWidth: 3)
                        )
                // need to add password verification
                    NavigationLink(
                        destination: MsgPage(msgContent: "", user: username  ),
                        isActive: $isActive,
                        label: { Button(action: { self.isActive = true }, label: { Text("sign in") }) })
                }.navigationBarTitle("Welcome")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
