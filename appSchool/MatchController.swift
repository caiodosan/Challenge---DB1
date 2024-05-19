//
//  MatchController.swift
//  appSchool
//
//  Created by CaioCunha on 16/05/24.
//

import UIKit

class MatchController: UIViewController {
    
    var perfis : [Perfil] = []
    
    var perfil : Perfil?
    
    var matches : [Perfil] = []
    
    @IBOutlet weak var perfisMatch: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMeuPerfil()
        
        loadMatatches()
        
        var count = 1
        for match in matches {
            
            perfisMatch.text += String(count) + "\t" + match.nome + "\n"
            
            count += 1
        }
        
        if(matches.isEmpty){
            perfisMatch.text = "Nenhum Match encontrado"
        }
        
    }
    
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
            var count = 0
            
            for per in perfis {
                let idUser: Int = UserDefaults.standard.integer(forKey: "userId")
                if(idUser == per.id_user){
                    perfil = per
                    perfis.remove(at: count)
                }
                count = count + 1
            }
        } catch {
            //Caso aconteça algum erro na interpretação do JSON, o sistema de tratamento exibirá a causa
            
            print(error.localizedDescription)
        }
    }
    
    func loadMatatches() {
        
        let palavra1 = perfil!.area_trabalho.components(separatedBy: .whitespacesAndNewlines)
        let palavra2 = perfil!.formacao_academica.components(separatedBy: .whitespacesAndNewlines)

        let palavras = palavra1 + palavra2
        
        for per in perfis {
            var count = 0
            
            let work = per.area_trabalho.components(separatedBy: .whitespacesAndNewlines)
            
            for palavra in work {
                if palavras.contains(palavra) {
                    count += 1
                }
            }
            
            let study = per.formacao_academica.components(separatedBy: .whitespacesAndNewlines)
            
            for palavra in study {
                if palavras.contains(palavra) {
                    count += 1
                }
            }
            
            
            let xp = per.experiencia.components(separatedBy: .whitespacesAndNewlines)
            
            for palavra in xp {
                if palavras.contains(palavra) {
                    count += 1
                }
            }
            
            if(count > 0){
                matches.append(per)
            }
            
        }
        
    }
    
    
    
}
