//
//  TopProfileBarViewController.swift
//  Swifty-Companion
//
//  Created by Andile MKHUMA on 2018/10/16.
//  Copyright © 2018 Andile MKHUMA. All rights reserved.
//

import UIKit

class TopProfileBarViewController: UIViewController {

    var USER : User!
    
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var login: UILabel!
    @IBOutlet weak var correctionPoints: UILabel!
    @IBOutlet weak var wallet: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var levelProgress: UIProgressView!
    @IBOutlet weak var RoleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //image stuff
        self.profilePicture.layer.borderWidth = 1
        self.profilePicture.layer.masksToBounds = false
        self.profilePicture.layer.borderColor = UIColor.white.cgColor
        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.height/2
        self.profilePicture.clipsToBounds = true
        
        self.login.text = self.USER.login
        self.email.text = self.USER.email
        self.correctionPoints.text = "Correction Points : \(self.USER.correction_points)"
        self.wallet.text = "Wallet : \(self.USER.wallet)"
        self.level.text = "Level : \(self.USER.cursus_users.first!.level)"
        let newImageURL = self.USER.image_url.split(separator: "/")[3]
        print(newImageURL)
        downloadImage(urlString: "https://cdn.intra.42.fr/users/medium_\(newImageURL)")
        
        //progress bar stuff
        self.levelProgress.progress = Float(self.USER.cursus_users.first!.level - Double(Int(self.USER.cursus_users.first!.level)))
        
        //check if User is a Student or Staff and set the label accordingly
        if (USER.staff == true)
        {
            self.RoleLabel.text = "Staff"
            self.RoleLabel.backgroundColor = Colors42.LightRed
        }
        else
        {
            self.RoleLabel.text = ""
        }
    }

    func downloadImage(urlString: String)
    {
        if let url = URL(string: urlString){
            do{
                URLSession.shared.dataTask(with: url,completionHandler: { (data, resp, error) -> Void in
                    if (error == nil && data != nil){
                        DispatchQueue.main.async{
                            print("Downloaded image \(urlString)")
                            self.profilePicture.image = UIImage(data: data!)
                        }
                    }
                    else
                    {
                        self.creatAlert(title: "Profile Picture", message: "Error! Failed To Load Profile Picture")
                    }
                }).resume()
            }
        }
    }
    
    func creatAlert(title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
