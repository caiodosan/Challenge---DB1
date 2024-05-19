//
//  NewViewController.swift
//  appSchool
//
//  Created by CaioCunha on 19/03/24.
//

import UIKit

class NewViewController: UIViewController {

    var perfis : [Perfil] = []
    
    var perfil : Perfil?
    
    @IBOutlet weak var ivTitulo: UILabel!
    
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var lbDescricao: UITextView!
    
    override func viewDidLoad() {
      super.viewDidLoad()
        loadMaterias()
        if var perfil = perfil {
            ivTitulo.text = perfil.nome
            lbTitle.text = perfil.area_trabalho
            lbDescricao.text = "Formação: " + perfil.formacao_academica + "\nHabilidades: " + perfil.habilidades + "\nExperiência: " + perfil.experiencia
        }
    }
    
    //Este método abrirá o arquivo movies.json e converterá em um array de Movie
    func loadMaterias() {
        
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
            
            for materia in perfis {
                print(materia.nome, "-", materia.idade)
            }
        } catch {
            //Caso aconteça algum erro na interpretação do JSON, o sistema de tratamento exibirá a causa
            
            print(error.localizedDescription)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
