//
//  ViewController.swift
//  TraineeProject
//
//  Created by TTN on 20/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

class LoginPageViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginFacebook: FBLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        facebookLogin()
        googleLogin()
        
        if UserDefaults.standard.bool(forKey: "ISUSERLOGGEDIN") == true {
                   //user is already logged in
                   
               let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
                   
               // This is to get the SceneDelegate object from your view controller
               // then call the change root view controller function to change to main tab bar
               (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
           }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func facebookLogin(){
        if let token = AccessToken.current,
           !token.isExpired {
            // User is logged in, do work such as go to next view controller.
            let token = token.tokenString
            
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "id, email, first_name, last_name, picture, short_name, name, middle_name, name_format,age_range"], tokenString: token, version: nil, httpMethod: .get)
            request.start { (connection, result, error) in
                print("\(result)")
            }
        }else{
            loginFacebook.permissions = ["public_profile", "email"]
            loginFacebook.delegate = self
        }
    }
    
    //firebase.auth used for authentication and core connection
    
    func googleLogin(){
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        
        if GIDSignIn.sharedInstance().hasPreviousSignIn(){
            GIDSignIn.sharedInstance()?.restorePreviousSignIn()
            print("Already Login")
        }
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(identifier: "SignUpPageViewController") as! SignUpPageViewController
               self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func googleLoginButtonTapped(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
              let userdetail = CoreDataManager.shared.fetchUserDetails(withEmail: usernameTextField!.text ?? "")
              ValidationCode()
              if userdetail?.password == passwordTextField!.text {
                  
                  UserDefaults.standard.set(true, forKey: "ISUSERLOGGEDIN")
                  
                  let storyboard = UIStoryboard(name: "Main", bundle: nil)
                  let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
                  
                  // This is to get the SceneDelegate object from your view controller
                  // then call the change root view controller function to change to main tab bar
                  (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        }
    }
}


extension LoginPageViewController{
    fileprivate func ValidationCode() {
        if let email = usernameTextField.text, let password = passwordTextField.text{
            if !email.validateEmailID(){
                openAlert(title: "Alert", message: "Email address not found.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Okay clicked!")
                }])
            }else if !password.validatePassword(){
                openAlert(title: "Alert", message: "Please enter valid password", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Okay clicked!")
                }])
            }else{
                // Navigation - Home Screen
            }
        }else{
            openAlert(title: "Alert", message: "Please add detail.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                print("Okay clicked!")
            }])
        }
    }
}


extension LoginPageViewController: LoginButtonDelegate{
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "id, email, first_name, last_name, picture, short_name, name, middle_name, name_format,age_range"], tokenString: token, version: nil, httpMethod: .get)
        request.start { (connection, result, error) in
            print("\(result)")
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("logout")
    }

    
}

extension LoginPageViewController: GIDSignInDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("\(user.profile.email ?? "NO Email")")
    }
    
    
}

    
    
   
        

    
    



