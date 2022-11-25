

import SwiftUI
import FirebaseAuth

struct LogInView: View {    //login page
    @State var email: String = ""
    @State var password: String = ""
    var body: some View {
        NavigationView{
            VStack{
                UserImage()
                LoginModule(email:$email, password: $password)
                LoginButton(email: $email,password: $password)
            }
        }
    }
    
    
}

struct UserImage : View{   //user icon
    var body: some View{
        return Section(header: Text("")) {
            HStack {
                Spacer();
                Button(action: {
                    print("HEllo Clicked!")
                }, label: {
                    Image(systemName: "person.circle")
                        .font(.system(size: 70))
                })
                Spacer()
            }
        }
        .listRowBackground(Color.clear)
        .padding(.top,-10)
        .padding()
    }
}

struct LoginModule : View{
    @Binding var email:String
    @Binding var password:String
    let lightGreyColor = Color(red:239/255,green: 243/255,blue: 244/255,opacity: 1)
    var body: some View{
        return VStack{
            HStack{
                VStack{
                    EmailField(email: $email)
                    PasswordSecureField(password:$password)
                }.padding()
            }.background(lightGreyColor)
                .cornerRadius(20)
                .padding()
        }
    }
}

struct EmailField: View{      // input email
    @Binding var email:String
    var body: some View{
        Text("Email").frame(maxWidth:.infinity,alignment: .leading).padding(.leading)
        TextField("",text: $email)
            .padding()
            .background()
            .cornerRadius(90.0)
            .padding(.bottom,20)
            .autocapitalization(.none)
            .disableAutocorrection(true)
    }
}

struct PasswordSecureField: View{  // input password
    @Binding var password:String
    var body: some View{
        Text("Password").frame(maxWidth:.infinity,alignment: .leading).padding(.leading)
        SecureField("",text: $password)
            .padding()
            .background()
            .cornerRadius(90.0)
            .padding(.bottom,20)
    }
}

struct LoginButton: View{     // button " login"
    @Binding var email:String
    @Binding var password:String
    @State var loginResult:String = " "
    @State var authSuccess:Bool = false
    @State var navPath = NavigationPath()
    var body: some View{
        VStack{
            Text(loginResult).offset(y:-10).foregroundColor(Color.red).padding(.bottom,-10)
            Button(action:{login(email:email, password: password)}){
                VStack(alignment: .center){
                    Text("LOGIN").font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal,120)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(90)
                }.padding().frame(width:1000)
            }
        }.padding()
    }
    
    //verify through firebase
    func login(email:String, password:String){
        if(email == "" || password == ""){
            loginResult = "Please input email and password."
            authSuccess = false
        }else{
            // reset textfield to blank
            self.email = ""
            self.password = ""
            Auth.auth().signIn(withEmail: email,password: password){ result, error in
                guard error == nil else{
                    authSuccess = false
                    loginResult = error!.localizedDescription
                    return
                }
                //login success
                loginResult = " "
                authSuccess = true
            }
            
        }

    }
}


struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}



