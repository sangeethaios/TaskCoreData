//
//  ViewController.swift
//  TaskCoreData
//
//  Created by SangeethaKalis on 29/04/24.
//

import UIKit
import CoreData
import UIKit

class UserListViewController: UIViewController {
    
    @IBOutlet var userlisttableview: UITableView!
    @IBOutlet weak var addbutton: UIBarButtonItem!
    var users = [UserDatas]()
    var managedObjectContext: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialsetup()
        self.fetchUserData()
    }
    func initialsetup() {
        userlisttableview.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
        
    }
    @IBAction func addbtnact(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let Addvc = storyBoard.instantiateViewController(withIdentifier: "AddUserViewController") as! AddUserViewController
        self.navigationController?.pushViewController(Addvc, animated: true)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.fetchUserData()
        
    }
    func fetchUserData() {
        let urlString = "https://crudcrud.com/api/f1e32b33d42844a3afbd78c7899a8734/newuser"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching user data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Response status code: \(httpResponse.statusCode)")
                if httpResponse.statusCode == 400 {
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        
                        let alert = UIAlertController(title: "Alert", message: "Endpoint has expired.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                else{
                    
                }
            }
            
            if let responseData = String(data: data, encoding: .utf8) {
                print("Response data: \(responseData)")
                
            } else {
                print("Failed to convert response data to string")
            }
            
            // Decode the JSON response as before
            do {
                let users = try JSONDecoder().decode([UserDatas].self, from: data)
                
                // Assuming users is an array property of your view controller
                self.users = users
                
                DispatchQueue.main.async {
                    self.userlisttableview.reloadData()
                }
            } catch {
                print("Error decoding user data: \(error)")
            }
        }.resume()
    }
    
}
extension UserListViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = userlisttableview.dequeueReusableCell(withIdentifier: "UserTableViewCell") as! UserTableViewCell
        cell.selectionStyle = .none
        
        let userData = self.users[indexPath.row]
        cell.namelbl.configureText(color: .black, alignment: .left, font: UIFont.systemFont(ofSize: 16), text: userData.name)
        cell.emaillbl.configureText(color: .black, alignment: .left, font: UIFont.systemFont(ofSize: 16), text: userData.email)
        cell.genderlbl.configureText(color: .black, alignment: .left, font: UIFont.systemFont(ofSize: 16), text: userData.gender)
        cell.mobilelbl.configureText(color: .black, alignment: .left, font: UIFont.systemFont(ofSize: 16), text: userData.mobile)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userData = self.users[indexPath.row]
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let Addvc = storyBoard.instantiateViewController(withIdentifier: "AddUserViewController") as! AddUserViewController
        Addvc.userDatasres = userData
        self.navigationController?.pushViewController(Addvc, animated: true)
    }
}
