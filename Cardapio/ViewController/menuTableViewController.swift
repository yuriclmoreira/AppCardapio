//
//  menuTableViewController.swift
//  Cardapio
//
//  Created by Yuri Moreira on 28/08/21.
//

import UIKit

class menuTableViewController: UITableViewController {

    var menu:[String] = ["Bebidas alcoólicas","Bebidas não alcoólicas","Prato principal","Sanduiches","Sobremesa"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menu = menu[indexPath.row]
        
        let celula = tableView.dequeueReusableCell(withIdentifier: "celulaMenu", for: indexPath)
        
        celula.textLabel?.text = menu
        return celula
    }

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalhesProdutos"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let menuSelecionado = self.menu[indexPath.row]
                let viewControllweDestino = segue.destination as! DetalhesCategoriaTableViewController
                viewControllweDestino.categoria = menuSelecionado
            }
        }
    }
}
