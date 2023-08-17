//
//  TableViewCell.swift
//  APIPractice
//
//  Created by ChaewonMac on 2023/08/17.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.numberOfLines = 0
        infoLabel.font = .systemFont(ofSize: 13)
        infoLabel.numberOfLines = 2
        thumbnailImageView.contentMode = .scaleToFill
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
