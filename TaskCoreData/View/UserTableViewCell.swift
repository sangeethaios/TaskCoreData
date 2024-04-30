//
//  UserTableViewCell.swift
//  TaskCoreData
//
//  Created by SangeethaKalis on 29/04/24.
//

import UIKit

class UserTableViewCell: UITableViewCell {
@IBOutlet weak var cellouterview: UIView!
@IBOutlet weak var namelbl: UILabel!
@IBOutlet weak var emaillbl: UILabel!
@IBOutlet weak var genderlbl: UILabel!
@IBOutlet weak var mobilelbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
