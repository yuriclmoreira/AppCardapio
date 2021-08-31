//
//  LoginViewController.swift
//  Cardapio
//
//  Created by Yuri Moreira on 13/08/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var campoEmail: UITextField!
    @IBOutlet weak var campoSenha: UITextField!
    var auth: Auth!
    
    @IBAction func unwindToLogin(_ unwindSegue: UIStoryboardSegue) {
        do {
            try auth.signOut()
        } catch  {
            print("Erro ao deslogar o usuario!")
        }
    }
    @IBAction func logar(_ sender: Any) {
        if let email = campoEmail.text{
            if let senha = campoSenha.text{
                auth.signIn(withEmail: email, password: senha) { usuario, erro in
                    if erro == nil{
                        print("Sucesso ao logar usuario")
                    }else{
                        print("Erro ao logar usuario")
                    }
                }
            }else{
                print("Preencha sua senha ")
            }
        }else{
            print("Preencha o email")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        auth = Auth.auth()
        auth.addStateDidChangeListener { autentificacao, usuario in
            if usuario != nil { // USusuario logado
                self.performSegue(withIdentifier: "segueLoginAutomatico", sender: nil)
            }else{
                print("Usuario nao esta logado!")
            }
        }
    }
    
    

}
