//
//  BeerListViewController.swift
//  APIPractice
//
//  Created by ChaewonMac on 2023/08/10.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

struct Beer {
    let name: String
    let image: String
    let descript: String
}

class BeerListViewController: UIViewController {

    var beerList: [Beer] = []
    
    @IBOutlet var beerTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        beerTableView.delegate = self
        beerTableView.dataSource = self
        beerTableView.rowHeight = 180
        callRequest()
    }

    func callRequest() {
        
        let url = "https://api.punkapi.com/v2/beers"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
//                print(json.arrayValue)
                for item in json.arrayValue {
                    
                    let beerName = item["name"].stringValue
                    let beerImage = item["image_url"].stringValue
                    let beerDescript = item["description"].stringValue
                    
                    let data = Beer(name: beerName, image: beerImage, descript: beerDescript)
                    
                    self.beerList.append(data)
                }
                self.beerTableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    

}

extension BeerListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerTableViewCell.identifier) as? BeerTableViewCell else {
            return UITableViewCell()
        }
        
        cell.nameLabel.text = beerList[indexPath.row].name
        cell.descriptionLabel.text = beerList[indexPath.row].descript
        
        guard let imageurl = URL(string: beerList[indexPath.row].image) else { return UITableViewCell() }
        cell.beerImageView.kf.setImage(with: imageurl)
        
        return cell
    }
    
    
    
    
}
