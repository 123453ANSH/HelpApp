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
    @State var name: String = ""
    @State var email: String = ""
    var body: some View {
        NavigationView{
            ZStack{
                Image("Back.jpg").resizable().scaledToFill()
                VStack{
                    Image(systemName: "person.crop.circle.fill").resizable().frame(width: 100, height: 100).padding()
                    
                    TextField("Name", text: $name).padding()
                    .frame(width: 300, height: 50, alignment: .center)
                    .foregroundColor(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(Color.red, lineWidth: 3)
                    )
                    
                    TextField("Username", text: $username).padding()
                        .frame(width: 300, height: 50, alignment: .center)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 100)
                                .stroke(Color.red, lineWidth: 3)
                        )
                    
                    TextField("email", text: $email).padding()
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
                        label: { Button(action: {
                            self.isActive = true
                             self.addUser(self.name, self.email, self.password, self.username)
                        }, label: { Text("sign in") }) })
                }.navigationBarTitle("Welcome")
            }
        }
    }
    func addUser(_ name: String,_ email: String,_ password: String,_ username: String){
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: [
            "email": "\(email)",
            "name": "\(name)",
            "password": "\(password)",
            "username": "\(username)"
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
        //return ref?.documentID ?? "Couldn't find the document"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
