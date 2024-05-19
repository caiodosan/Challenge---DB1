//
//  ViewController.swift
//  appSchool
//
//  Created by CaioCunha on 19/03/24.
//

import UIKit

class ViewController: UIViewController {
    
    var materias : [Perfil] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        var body: some View{
//            TabView{
//                PerfilViewController().tabBarItem(){
//                    Text("Perfil")
//                }
//            }
//        }
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
            materias = try JSONDecoder().decode([Perfil].self,
                                              from: data)
            
            //Varremos o array para imprimir na Debug Area o nome e duração de cada filme
            
            for materia in materias {
                print(materia.nome, "-", materia.experiencia)
            }
        } catch {
            //Caso aconteça algum erro na interpretação do JSON, o sistema de tratamento exibirá a causa
            
            print(error.localizedDescription)
        }
    }
    



}

