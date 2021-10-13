//
//  EventTableViewCell.swift
//  Bernina Sew
//
//  Created by lunarian on 01/06/2020.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    @IBOutlet weak var eventsLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dateView.layer.cornerRadius = 10
        dateView.backgroundColor = K.green
        
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 2.0
        contentView.layer.borderColor = K.brandGray.cgColor
        

 
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //set the values for top,left,bottom,right margins
        let margins = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
