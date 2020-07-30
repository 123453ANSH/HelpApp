//
//  SignUpPage.swift
//  HelpApp
//
//  Created by Ansh Verma on 7/28/20.
//  Copyright © 2020 Ansh Verma. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
        .padding()
        .frame(width: 300, height: 50, alignment: .center)
        .overlay(
            RoundedRectangle(cornerRadius: 100)
                .stroke(Color.red, lineWidth: 3)
        )
    }
}

extension View {
    func TextFieldRender() -> some View {
        self.modifier(TextFieldModifier())
    }
}


struct SignUpPage: View {
    
  //  var ref: DatabaseReference!
    @State var isActive = false
    @State var username: String = ""
    @State var password: String = ""
    @State var confirmpassword: String = ""
    @State var firstname: String = ""
    @State var lastname: String = ""
    @State var email: String = ""
    @State var saveBool: Bool = false
    var body: some View {
        NavigationView{
                VStack{
                    Text("Page 1")
                        .font(.system(size: 28.0))
                        .padding(.bottom)
                    Text("Enter your primary information. Remember that the purpose of this app is for other users to recognize you during an emergency. For this reason, you must upload an accurate profile picture. Additionally, you will be required to input your real name, a username that accurately reflects your name, and the email you use most often.")
                        .multilineTextAlignment(.center)
                       .font(.system(size: 15.0))
                        //You will recieve reminders in this app to update your primary information, if needed, every month.
                    
                    /*
                     - implement zoom feature for profile picture
                     - map profile picture to the circle on main page
                     */
                    
                    NavigationLink(destination:
                    ImagePage()) {
                        Image(systemName: "person.crop.circle.fill").resizable().frame(width: 100, height: 100).padding()
                            .foregroundColor(.black)
                    }
                    //.ButtonRender()
                    
                    TextField("First Name", text: $firstname)
                        .TextFieldRender()
                    
                    TextField("Last Name", text: $lastname)
                        .TextFieldRender()
                    
                    TextField("Username", text: $username)
                        .TextFieldRender()
                    
                    TextField("email", text: $email)
                        .TextFieldRender()
                    
                    TextField("Password", text: $password)
                        .TextFieldRender()
                    
                    TextField("Confirm Password", text: $confirmpassword)
                            .TextFieldRender()
                /* in this navigation link, if name/username/email have all been used or taken before, alert and say need to put in something else. if password do not match, alert to fix
                     */
                    HStack {
                        
                        Button(action: {
                            print(self.username)
                            //self.addusername(self.username)
                            self.save_all_data(self.firstname, self.lastname, self.email, self.password, self.username, self.confirmpassword)
                        })
                        {
                            Text("Save Information")
                                .foregroundColor(.white)
                                .padding(9)
                        }
                        .ButtonRender()
 
                NavigationLink(destination:
                  Text("Hi there")
        
                ) {
                    Text("Next Page")
                         .foregroundColor(.white)
                        .padding(9)
                }
                 .ButtonRender()
                
                
                }
                
                // need to add password verification
                
                }.navigationBarTitle("Sign Up")
            
        }
    }
 // edit function once confirmed how storing sign up and sign in page data
    func save_all_data(_ firstname: String,_ lastname: String,_ email: String,_ password: String,_ username: String,_ confirmpassword: String){
        // functions to ensure username & email & password have not been taken
        addusername(username)
        addname(firstname, lastname)
        adduseremail(email)
        adduserpassword(password)
        
    }
    
    func addusername(_ username: String){
    
        let db = Firestore.firestore()
        let user = db.collection("usernames").document("\(username)")
        user.setData(["username": "\(username)"]) {
            (err) in
            
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            print("success")
            }
     }
    func addname(_ firstname: String,_ lastname: String){
        let db = Firestore.firestore()
        let user = db.collection("user name").document("\(username)")
        user.setData(["firstname": "\(firstname)", "lastname": "\(lastname)"]) {
            (err) in
            
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            print("success")
        }
    }
    func adduseremail(_ email: String){
         let db = Firestore.firestore()
               let user = db.collection("user email").document("\(username)")
               user.setData(["email": "\(email)"]) {
                   (err) in
                   
                   if err != nil {
                       print((err?.localizedDescription)!)
                       return
                   }
                   print("success")
               }
           }
    func adduserpassword(_ password: String){
        let db = Firestore.firestore()
            let user = db.collection("user password").document("\(username)")
            user.setData(["password": "\(password)"]) {
                (err) in
                
                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                }
                print("success")
            }
    }
}
/*
struct WhoIsUser: View {
    var body: some view {
        
    }
}
*/


struct SignUpPage_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPage()
    }
}


struct ImagePage: View {
@State private var image: Image?
@State private var showingImagePicker = false
@State private var inputImage: UIImage?
var body: some View {
    NavigationView {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.secondary)
                if image != nil {
                    // not all conditions work in swiftUI
                    image?
                        .resizable()
                        .scaledToFit()
                } else {
                    Text("Tap to select image to upload")
                        .foregroundColor(.white)
                        .font(.headline)
                }
            }.onTapGesture {
                self.showingImagePicker = true
                
            }
            
            Button("Upload") {
                //code to upload image to firebase
            }
        }
    }
    .padding([.horizontal, .bottom])
    .navigationBarTitle("Help App")
    .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
        ImagePicker(image: self.$inputImage)
    }
}
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}
