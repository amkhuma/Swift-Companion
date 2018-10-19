//
//  ProjectsTableViewCell.swift
//  Swifty-Companion
//
//  Created by Andile MKHUMA on 2018/10/18.
//  Copyright © 2018 Andile MKHUMA. All rights reserved.
//

import UIKit

class ProjectsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var projectMarks: UILabel!
    @IBOutlet weak var projectName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
