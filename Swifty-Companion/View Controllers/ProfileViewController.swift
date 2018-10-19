//
//  ProfileViewController.swift
//  Swifty-Companion
//
//  Created by Andile MKHUMA on 2018/10/15.
//  Copyright © 2018 Andile MKHUMA. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var skillNames : [String] = []
    var skillPercentages : [Double] = []
    
    var USER: User!
    
    @IBOutlet weak var skillsTable: UITableView!
    @IBOutlet weak var projectsTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView.tag == 1){
            return self.USER.cursus_users.first!.skills.count
        }
        else if (tableView.tag == 2){
            return self.USER.projects_users.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView.tag == 1){
            let cell : TableViewCell = tableView.dequeueReusableCell(withIdentifier: "skillsCell") as! TableViewCell
            cell.textLabel?.text  = self.USER.cursus_users.first!.skills[indexPath.row].name
            cell.detailTextLabel?.text = String(self.USER.cursus_users.first!.skills[indexPath.row].level)
            return cell
        }
        else{
            let cell : ProjectsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "projectsCell") as! ProjectsTableViewCell
                cell.projectName.text = self.USER.projects_users[indexPath.row].project.slug
                cell.projectMarks.text = "\(self.USER.projects_users[indexPath.row].final_mark ?? 0)%"
                if (self.USER.projects_users[indexPath.row].validated == nil){
                    cell.projectName.textColor = UIColor.gray
                    cell.projectMarks.textColor = UIColor.gray
                }
                else if (self.USER.projects_users[indexPath.row].validated == false){
                    cell.projectName.textColor = Colors42.LightRed
                    cell.projectMarks.textColor = Colors42.LightRed
                }
                else{
                    cell.projectName.textColor = Colors42.LightGreen
                    cell.projectMarks.textColor = Colors42.LightGreen
                }
            return cell
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(USER.login)'s Profile"
        UIApplication.shared.endIgnoringInteractionEvents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "childProfile" {
            if let viewController = segue.destination as? TopProfileBarViewController {
                if (self.USER != nil){
                    viewController.USER = self.USER
                }
            }
        }
    }

}
