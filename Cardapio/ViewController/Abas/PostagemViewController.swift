
import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

class PostagemViewController: UIViewController ,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var produto: UITextField!
    @IBOutlet weak var preco: UITextField!
    
    var storage: Storage!
    var auth: Auth!
    var firestore: Firestore!
    
    var selecaoCategoria: String!
    
    
    var pickerData = ["Prato principal","Sanduiches","Sobremesa","Bebidas alcoólicas","Bebidas não alcoólicas"]
    
  
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        storage = Storage.storage()
        auth = Auth.auth()
        firestore = Firestore.firestore()
        
        self.seletor.delegate = self
        self.seletor.dataSource = self
        
    }
    
    @IBAction func salvarProduto(_ sender: Any) {
        if let categoria = selecaoCategoria{
            if let nome  = self.produto.text {
                if let preco = self.preco.text{
                    if let usuarioLogado = self.auth.currentUser{
                        
                        let idUsuario = usuarioLogado.uid
                        
                        self.firestore
                            .collection("cardapio")
                            .document(idUsuario)
                            .collection(categoria)
                            .addDocument(data: [
                                "nome": nome,
                                "preco": preco
                            
                            ]) { (erro) in
                                if erro == nil{
                                    self.navigationController?.popViewController(animated: true)
                                }
                            }
                            
                    }
                }
            }
        }
       
        
    }
    
    
    
    
    @IBOutlet weak var seletor: UIPickerView!
    
    // Numero de Colunas
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let select = pickerView.selectedRow(inComponent: 0)
        
        selecaoCategoria = pickerData[select]
    }
    
    

}
