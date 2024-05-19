//
//  PerfilViewController.swift
//  appSchool
//
//  Created by CaioCunha on 11/05/24.
//

import UIKit

class PerfilViewController: UIViewController {
    
    
    var perfis : [Perfil] = []
    
    var perfil : Perfil?
    
    @IBOutlet weak var lnNome: UITextField!
    
    @IBOutlet weak var lbIdade: UITextField!
        
    @IBOutlet weak var lbProfissao: UITextField!
    
    @IBOutlet weak var lbFormacao: UITextField!
    
    @IBOutlet weak var lbExperiencia: UITextField!
    
    @IBOutlet weak var lbHabilidades: UITextField!
    
    @IBOutlet weak var mentorOuAprendiz: UISegmentedControl!

    override func viewDidLoad() {
      super.viewDidLoad()
        loadMeuPerfil()

        var selectTipo = 0
        
        
        if let perfil = perfil {
            lnNome.text = perfil.nome
            lbIdade.text = perfil.area_trabalho
            lbProfissao.text = perfil.area_trabalho
            lbFormacao.text = perfil.formacao_academica
            lbExperiencia.text = perfil.experiencia
            lbHabilidades.text = perfil.habilidades
            
            if(perfil.tipo == "M")
            {
                selectTipo = 0
            }else{
                selectTipo = 1
            }
            
            mentorOuAprendiz.selectedSegmentIndex = selectTipo
        }
    }
    
    @IBAction func salvarPerfil(_ sender: UIButton) {
        
        showAlert(message: "Dados Salvos")
        
        }
    func showAlert(message: String) {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    //Este método abrirá o arquivo movies.json e converterá em um array de Movie
    func loadMeuPerfil() {
        
        //Recuperando a URL do arquivo
        guard let fileURL = Bundle.main.url(forResource:
                                                "perfil", withExtension: "json") else {return}
        do {
            
            //Criando o dara, a representação binária de nosso arquivo
            
            let data = try Data(contentsOf: fileURL)
            
            //Decodificando o JSON em um Array de Movie
            perfis = try JSONDecoder().decode([Perfil].self,
                                              from: data)
            
            //Varremos o array para imprimir na Debug Area o nome e duração de cada filme
            
            for per in perfis {
                let idUser: Int = UserDefaults.standard.integer(forKey: "userId")
                if(idUser == per.id_user){
                    perfil = per
                }
                
            }
        } catch {
            //Caso aconteça algum erro na interpretação do JSON, o sistema de tratamento exibirá a causa
            
            print(error.localizedDescription)
        }
    }

    // MARK: - Table view data source

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
