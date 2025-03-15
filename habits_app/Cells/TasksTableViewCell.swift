//
//  TasksTableViewCell.swift
//  habits_app
//
//  Created by Home PC on 3/15/25.
//

import UIKit

class TasksTableViewCell: UITableViewCell {

    @IBOutlet weak var taskTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
