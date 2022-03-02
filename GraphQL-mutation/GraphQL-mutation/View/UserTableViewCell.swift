//
//  UserTableViewCell.swift
//  GraphQL-mutation
//
//  Created by Implemedea on 17/02/22.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var emailId: UILabel!
    @IBOutlet weak var firstName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
