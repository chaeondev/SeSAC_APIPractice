//
//  BeerTableViewCell.swift
//  APIPractice
//
//  Created by ChaewonMac on 2023/08/10.
//

import UIKit

class BeerTableViewCell: UITableViewCell {
    
    static let identifier = "BeerTableViewCell"

    
    @IBOutlet var beerImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        designImageView()
        designNameLabel()
        designDescriptionLabel()
    }

    func designImageView() {
        beerImageView.contentMode = .scaleAspectFit
    }
    
    func designNameLabel() {
        nameLabel.font = .boldSystemFont(ofSize: 14)
        nameLabel.numberOfLines = 0
    }
    
    func designDescriptionLabel() {
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.numberOfLines = 0
    }
    

}
