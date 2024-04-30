//
//  AddUserViewController.swift
//  TaskCoreData
//
//  Created by SangeethaKalis on 29/04/24.
//

import UIKit
import CoreData
class AddUserViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userouterview: UIView!
    @IBOutlet weak var userimgview: UIImageView!
    @IBOutlet weak var nametextfield: UITextField!
    @IBOutlet weak var emailtextfield: UITextField!
    @IBOutlet weak var gendertextfield: UITextField!
    @IBOutlet weak var mobiletextfield: UITextField!
    @IBOutlet weak var savebutton: UIButton!
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var emaillbl: UILabel!
    @IBOutlet weak var genderlbl: UILabel!
    @IBOutlet weak var mobilelbl: UILabel!
    
    var userDatasres: UserDatas?
    var managedObjectContext: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialsetup()
        self.nametextfield.delegate = self
        self.emailtextfield.delegate = self
        self.gendertextfield.delegate = self
        self.mobiletextfield.delegate = self
    }
    func initialsetup() {
        // Check if userData is available
        if let userData = userDatasres {
            nametextfield.text = userData.name
            emailtextfield.text = userData.email
            gendertextfield.text = userData.gender
            mobiletextfield.text = userData.mobile
        }
        else{
            nametextfield.placeholder = "Enter your name"
            emailtextfield.placeholder = "Enter your email"
            gendertextfield.placeholder = "Enter your gender"
            mobiletextfield.placeholder = "Enter your mobileno"
        }
        addDoneButtonToTextField(textField: nametextfield)
        addDoneButtonToTextField(textField: emailtextfield)
        addDoneButtonToTextField(textField: gendertextfield)
        addDoneButtonToTextField(textField: mobiletextfield)
        self.savebutton.layer.cornerRadius = 8
        self.nametextfield.config(color: .black, align: .left, placeHolder: "Enter your name", font: UIFont.systemFont(ofSize: 16), borderColor: .black, borderWidth: 1.0, cornerRadius: 6)
        self.emailtextfield.config(color: .black, align: .left, placeHolder: "Enter your email", font: UIFont.systemFont(ofSize: 16), borderColor: .black, borderWidth: 1.0, cornerRadius: 6)
        self.gendertextfield.config(color: .black, align: .left, placeHolder: "Enter your gender", font: UIFont.systemFont(ofSize: 16), borderColor: .black, borderWidth: 1.0, cornerRadius: 6)
        self.mobiletextfield.config(color: .black, align: .left, placeHolder: "Enter your mobile", font: UIFont.systemFont(ofSize: 16), borderColor: .black, borderWidth: 1.0, cornerRadius: 6)
        self.namelbl.configureText(color: .black, alignment: .left, font: UIFont.systemFont(ofSize: 16),text: "Name")
        self.emaillbl.configureText(color: .black, alignment: .left, font: UIFont.systemFont(ofSize: 16),text: "Email")
        self.genderlbl.configureText(color: .black, alignment: .left, font: UIFont.systemFont(ofSize: 16),text: "Gender")
        self.mobilelbl.configureText(color: .black, alignment: .left, font: UIFont.systemFont(ofSize: 16),text: "Mobile")
        self.savebutton.setTitle("Save", for: .normal)
        self.savebutton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.savebutton.backgroundColor = UIColor.black
    }
    func addDoneButtonToTextField(textField: UITextField) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.items = [flexSpace, doneButton]
        
        textField.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonTapped() {
        view.endEditing(true)
    }
    @IBAction func savebtnact(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        guard let name = nametextfield.text, !name.isEmpty,
              let email = emailtextfield.text, !email.isEmpty,
              let gender = gendertextfield.text, !gender.isEmpty,
              let mobile = mobiletextfield.text, !mobile.isEmpty else {
            // Show alert for empty fields
            showAlert(title: "Alert", message: "Please fill in all fields.")
            return
        }
        if !Validation.emailValidation(email) {
            showAlert(title: "Alert", message: "Please enter a valid email.")
            return
        }
        
        if let userData = userDatasres {
            // Editing existing user data
            let fetchRequest: NSFetchRequest<UserData> = NSFetchRequest<UserData>(entityName: "UserData")
            fetchRequest.predicate = NSPredicate(format: "id = %@", userData._id )
            
            do {
                let userEntities = try context.fetch(fetchRequest)
                if let userEntity = userEntities.first {
                    userEntity.name = name
                    userEntity.email = email
                    userEntity.gender = gender
                    userEntity.mobile = mobile
                } else {
                    print("User entity not found")
                }
            } catch {
                print("Failed to fetch user data or update: \(error)")
            }
        }
        else {
            // Adding new user data
            DatabaseManager.shared.saveUserData(name: name, gender: gender, email: email, mobile: mobile)
        }
        
        // Save the changes
        do {
            try context.save()
            // Make API call to save data remotely
            saveUserDataRemotely(name: name, gender: gender, email: email, mobile: mobile)
            
            let alert = UIAlertController(title: "Alert", message: "Data Saved Successfully.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (UIAlertAction) in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        } catch {
            print("Failed to save context: \(error)")
        }
    }
    
    func saveUserDataRemotely(name: String, gender: String, email: String, mobile: String) {
        let url = URL(string: "https://crudcrud.com/api/f1e32b33d42844a3afbd78c7899a8734/newuser")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = [
            "name": self.nametextfield.text!,
            "gender": self.gendertextfield.text!,
            "email": self.emailtextfield.text!,
            "mobile": self.mobiletextfield.text!
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle response or error
            if let error = error {
                print("Error: \(error)")
                // Handle error
                return
            }
            if let response = response as? HTTPURLResponse {
                print("Response status code: \(response.statusCode)")
                // Handle response status code
            }
            if let data = data {
                // Handle response data
                print("Response data: \(String(data: data, encoding: .utf8) ?? "")")
            }
        }
        task.resume()
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}


