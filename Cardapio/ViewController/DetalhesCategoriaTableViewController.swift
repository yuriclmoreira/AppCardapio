//
//  DetalhesCategoriaTableViewController.swift
//  Cardapio
//
//  Created by Yuri Moreira on 28/08/21.
//

import UIKit
import FirebaseFirestore


class DetalhesCategoriaTableViewController: UITableViewController {

    var categoria: String!
    var firestore: Firestore!
    var produtos: [Dictionary <String,Any> ] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firestore = Firestore.firestore()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.produtos.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: "celulaProdutos", for: indexPath)
        
        let indice = indexPath.row
        let produto = self.produtos[indice]
        
        let nome = produto["nome"] as? String
        let preco = produto["preco"] as? String
        
        celula.textLabel?.text = nome
        celula.detailTextLabel?.text = preco
        return celula
    }
    override func viewDidAppear(_ animated: Bool) {
        recuperarProdutos()
    }
    
    func recuperarProdutos(){
        // LIMPAR LISTAGEM
        self.produtos.removeAll()
            //.collection("cardapio").document("ogPw8zxFsIWNRhfsDyRWUJ9v6f43"
        firestore.collection("cardapio").document("ogPw8zxFsIWNRhfsDyRWUJ9v6f43").collection(categoria).getDocuments{ snapshotResultado, erro in
            if let snapshot = snapshotResultado{
                for document in snapshot.documents{
                    let dados = document.data()
                    self.produtos.append(dados)
                }
                self.tableView.reloadData()
            }
        }
    }

}
