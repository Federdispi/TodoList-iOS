//
//  TableViewCell.swift
//  todolist
//
//  Created by Federico Di Spirito on 07/11/2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    var closure: (()->())?
    @IBOutlet weak var titleTODO: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBAction func doneTODO(_ sender: UIButton) {
        closure?()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
