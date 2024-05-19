//
//  MateriasControllerTableViewController.swift
//  appSchool
//
//  Created by CaioCunha on 19/03/24.
//

import UIKit

class LoginController: UIViewController {
    
    var usuarios : [Usuarios] = []
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUsuarios()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
            // Get the username and password from text fields
            guard let username = usernameTextField.text, !username.isEmpty else {
                showAlert(message: "Please enter username")
                return
            }
            
            guard let password = passwordTextField.text, !password.isEmpty else {
                showAlert(message: "Please enter password")
                return
            }
        
            var userId = isValid(username: username, password: password)
            
            // Perform your validation logic here
            if  userId > 0 {
                // Navigate to the next screen or perform any action you want
               

                // Salvar o ID do usuário usando UserDefaults
                UserDefaults.standard.set(userId, forKey: "userId")
            } else {
                showAlert(message: "Invalid username or password")
            }
        }
    func showAlert(message: String) {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    
    func isValid(username: String, password: String) -> Int {
        // Replace this with your actual validation logic
        // For demonstration purposes, just check if username is "user" and password is "password"
        for user in usuarios {
            if user.email == username && user.senha == password {
                    return user.id
                }
            }
        return 0
    }

    func loadUsuarios() {
        guard let fileURL = Bundle.main.url(forResource:
               "usuarios", withExtension: "json") else {return}
        do {
            let data = try Data(contentsOf: fileURL)
            usuarios = try JSONDecoder().decode([Usuarios].self,
                     from: data)
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
