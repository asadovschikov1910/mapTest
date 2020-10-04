//
//  ViewController.swift
//  mapsTest
//
//  Created by Андрей Садовщиков on 03.10.2020.
//

import UIKit

class LoginController: UIViewController {
    
    private var authService = AuthService()
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginField.delegate = self
        self.passField.delegate = self
        
        authService.isAuth = {
            self.showMap()
        }
        authService.isError = {
            self.showErrorLogin()
        }
    }
    
    private func showErrorLogin() {
        showError(errorText: "Неверный логин или пароль", view: self)
    }
    
    @IBAction func enter(_ sender: Any) {
        getAuth()
    }
    
    private func getAuth()
    {
        if !loginField.text!.isEmpty && !passField.text!.isEmpty {
            authService.getAuth(login: loginField.text!, password: passField.text!)
        } else {
            showError(errorText: "Проверьте заполненность полей", view: self)
        }
    }
    
    private func showMap() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "MapController") as! MapController
        self.present(controller, animated: true, completion: {})
    }
}


extension LoginController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.loginField:
            self.passField.becomeFirstResponder()
        case self.passField:
            getAuth()
        default:
            break
        }
    }
}
