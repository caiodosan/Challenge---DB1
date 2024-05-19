//
//  MatchController.swift
//  appSchool
//
//  Created by CaioCunha on 16/05/24.
//

import UIKit
import UserNotifications

class MatchController: UIViewController {
    
    var perfis : [Perfil] = []
    
    var perfil : Perfil?
    
    var matches : [Perfil] = []
    
    var allMatchesDB : [Match] = []
    
    var myMatchesDB : [Match] = []
    
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
        
        if(matches.count > myMatchesDB.count){
            newMatch()
        }
        
        dispatchNotification()
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
        //Recuperando a URL do arquivo
        guard let fileURL = Bundle.main.url(forResource:
                                                "matches", withExtension: "json") else {return}
        do {
            
            //Criando o dara, a representação binária de nosso arquivo
            
            let data = try Data(contentsOf: fileURL)
            
            //Decodificando o JSON em um Array de Movie
            allMatchesDB = try JSONDecoder().decode([Match].self,
                                              from: data)
        
            
            for mt in allMatchesDB {
                let idUser: Int = UserDefaults.standard.integer(forKey: "userId")
                if(idUser == mt.id_user || idUser == mt.id_user2){
                    myMatchesDB.append(mt)
                    
                }
                
            }
        } catch {
            //Caso aconteça algum erro na interpretação do JSON, o sistema de tratamento exibirá a causa
            
            print(error.localizedDescription)
        }
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
    
    func checkForPermission() {
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings{ settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]){
                    didAllow, error in
                    if didAllow{
                        self.newMatch()
                    }
                }
            case .denied:
                return
            case .authorized:
                self.newMatch()
            case .provisional:
                return
            case .ephemeral:
                return
            }
        }
    }
        
        func newMatch() {
            let title = "Novo Match !"
            let body =  "Venha ver o novo match para você"
            
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH"
            let hourC = dateFormatter.string(from: currentDate)
            
            dateFormatter.dateFormat = "mm"
            let minuteC = dateFormatter.string(from: currentDate)
            
            let isDaily = true
            let identifier = "my-match-notification"
            
            
            
                
                let notificationCenter = UNUserNotificationCenter.current()
                
                let content = UNMutableNotificationContent()
                content.title = title
                content.body = body
                content.sound = .default
                
                let calendar = Calendar.current
                var date = DateComponents(calendar: calendar, timeZone: TimeZone.current)
                date.hour = Int(hourC)
            date.minute = Int(minuteC)!+1
                
                let trigger =  UNCalendarNotificationTrigger(dateMatching: date, repeats: isDaily)
                
                let request = UNNotificationRequest(identifier: identifier, content: content , trigger: trigger)
                
                notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
                notificationCenter.add(request)
            
            
        }
    
    
    func dispatchNotification() {
        let title = "Venha tirar suas dúvidas"
        let body =  "conheça novas pessoas experientes em qualquer área"
        
        let hour = 10
        let minute = 25
        let isDaily = true
        let identifier = "my-morning-notification"
        
        
        
            
            let notificationCenter = UNUserNotificationCenter.current()
            
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = body
            content.sound = .default
            
            let calendar = Calendar.current
            var date = DateComponents(calendar: calendar, timeZone: TimeZone.current)
            date.hour = hour
            date.minute = minute
            
            let trigger =  UNCalendarNotificationTrigger(dateMatching: date, repeats: isDaily)
            
            let request = UNNotificationRequest(identifier: identifier, content: content , trigger: trigger)
            
            notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
            notificationCenter.add(request)
        
        
    }
        
        
    
    
}
