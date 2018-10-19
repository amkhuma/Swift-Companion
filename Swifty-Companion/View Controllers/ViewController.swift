//
//  ViewController.swift
//  Swifty-Companion
//
//  Created by Andile MKHUMA on 2018/10/15.
//  Copyright © 2018 Andile MKHUMA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var USER : User? = nil
    let apiCTRL : APIController = APIController()
    
    @IBOutlet weak var loginNameField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBAction func searchButton(_ sender: Any) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        searchButton.setTitle("Searching...", for: UIControlState.normal)
        apiCTRL.getUserData(loginName: loginNameField.text!, with: { d in
            
            guard let user = try? JSONDecoder().decode(User.self, from: d) else {
                UIApplication.shared.endIgnoringInteractionEvents()
                self.creatAlert(title: "User Error", message: "Error! User could not be found")
                self.searchButton.setTitle("Search", for: UIControlState.normal)
                print("Error: Couldn't decode data into User")
                return
            }
            APIController.USER = user
            DispatchQueue.main.async {
                self.searchButton.setTitle("Search", for: UIControlState.normal)
                self.performSegue(withIdentifier: "goToProfile", sender: self)
            }
        }, with: { err in
            print(err.localizedDescription)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.apiCTRL.getToken(with: { d in
            do {
                
                if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                    APIController.TOKEN = (dic.value(forKey: "access_token") as? String)!
                    print(APIController.TOKEN)
                }
            }
            catch(let err){
                print(err)
            }
        }) { err in
            print("couldnt get token")
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func creatAlert(title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToProfile" {
            if let viewController = segue.destination as? ProfileViewController {
                if (APIController.USER != nil)
                {
                    viewController.USER = APIController.USER
                }
            }
        }
    }
}

