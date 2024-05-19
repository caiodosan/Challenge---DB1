//
//  MateriasControllerTableViewController.swift
//  appSchool
//
//  Created by CaioCunha on 19/03/24.
//

import UIKit

class MateriasControllerTableViewController: UITableViewController, UISearchBarDelegate {
    
    var perfis : [Perfil] = []
    
    var pesquisa : String = ""
    
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        loadMaterias()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
            // Get the username and password
        }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return perfis.count
    }
    

    func loadMaterias() {
        guard let fileURL = Bundle.main.url(forResource:
               "perfil", withExtension: "json") else {return}
        do {
            let data = try Data(contentsOf: fileURL)
            let todosPerfis = try JSONDecoder().decode([Perfil].self,
                     from: data)
            
            
            
            if(pesquisa.isEmpty){
                
                perfis = todosPerfis
                
            }else{
                
                for perfil in todosPerfis {
                    if(perfil.nome.contains(pesquisa)){
                        perfis.append(perfil)
                    }
                }
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let materia = perfis[indexPath.row]
        
        var mentor = "Mestre"
        if(materia.tipo == "A"){
            mentor = "Aprendiz"
        }
        
        cell.textLabel?.text = materia.nome + "\t\t" + mentor
        
        // Configure the cell...

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      //Recuperando a próxima cena e tratando-a como NewViewController
        

      if let vc = segue.destination as? NewViewController {

          //A propriedade indexPathForSelectedRow nos retorna o IndexPath da célula selecionada. Usaremos como
          //índice para indicar o movie selecionado
            
          let perfil = perfis[tableView.indexPathForSelectedRow!.row]

          //Repassando o movie para a próxima tela
          vc.perfil = perfil
      }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // searchText conterá o texto digitado pelo usuário
        guard let fileURL = Bundle.main.url(forResource: "perfil", withExtension: "json") else { return }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let todosPerfis = try JSONDecoder().decode([Perfil].self, from: data)
            
            if searchText.isEmpty {
                perfis = todosPerfis
            } else {
                // Limpe o array de perfis antes de adicionar os perfis filtrados
                perfis.removeAll()
                
                for perfil in todosPerfis {
                    if perfil.nome.contains(searchText) {
                        perfis.append(perfil)
                    }else if perfil.area_trabalho.contains(searchText) {
                        perfis.append(perfil)
                    }else if perfil.experiencia.contains(searchText) {
                        perfis.append(perfil)
                    }else if perfil.habilidades.contains(searchText) {
                        perfis.append(perfil)
                    }else if perfil.formacao_academica.contains(searchText) {
                        perfis.append(perfil)
                    }
                    
                }
            }
            
            // Atualize a tabela com os dados filtrados
            tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }

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
