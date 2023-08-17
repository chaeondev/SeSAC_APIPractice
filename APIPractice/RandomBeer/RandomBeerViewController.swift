//
//  RandomBeerViewController.swift
//  APIPractice
//
//  Created by ChaewonMac on 2023/08/10.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class RandomBeerViewController: UIViewController {

    @IBOutlet var beerImageView: UIImageView!
    @IBOutlet var beerNameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        callRequest()
        
        designImageView()
        designNameLabel()
        designDesciptionLabel()
    }
    
    @IBAction func randomButtonClicked(_ sender: UIButton) {
        callRequest()
        view.reloadInputViews()
    }
    
    func callRequest() {
        let url = "https://api.punkapi.com/v2/beers/random"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let image = json[0]["image_url"].stringValue
                let name = json[0]["name"].stringValue
                let descript = json[0]["description"].stringValue
                
                self.beerImageView.kf.setImage(with: URL(string: image))
                self.beerNameLabel.text = name
                self.descriptionLabel.text = descript
                
            case .failure(let error):
                print(error)
            }
        }
    }

    
}

extension RandomBeerViewController {
    func designImageView() {
        beerImageView.contentMode = .scaleAspectFit
    }
    
    func designNameLabel() {
        beerNameLabel.textAlignment = .center
        beerNameLabel.font = .boldSystemFont(ofSize: 15)
    }
    
    func designDesciptionLabel() {
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: 13)
    }
}
