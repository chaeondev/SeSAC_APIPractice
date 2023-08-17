//
//  ViewController.swift
//  APIPractice
//
//  Created by ChaewonMac on 2023/08/10.
//

import UIKit
import Alamofire
import SwiftyJSON

class LottoViewController: UIViewController {

    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var ballNumberLabel: [UILabel]!
    
    let pickerView = UIPickerView()
    var list: [Int] = Array(1...1079).reversed()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // MARK: inputView 체크
        numberTextField.inputView = pickerView
        numberTextField.tintColor = .clear
        
        designBallLabel()
        designDateLabel()
    
        callRequest(number: 1079)

    }
    
    func callRequest(number: Int) {
        
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                let date = json["drwNoDate"].stringValue
                let no1 = String(json["drwtNo1"].intValue)
                let no2 = String(json["drwtNo2"].intValue)
                let no3 = String(json["drwtNo3"].intValue)
                let no4 = String(json["drwtNo4"].intValue)
                let no5 = String(json["drwtNo5"].intValue)
                let no6 = String(json["drwtNo6"].intValue)
                let bonus = String(json["bnusNo"].intValue)
                
                self.dateLabel.text = "\(date) 추첨"
                self.ballNumberLabel[0].text = no1
                self.ballNumberLabel[1].text = no2
                self.ballNumberLabel[2].text = no3
                self.ballNumberLabel[3].text = no4
                self.ballNumberLabel[4].text = no5
                self.ballNumberLabel[5].text = no6
                self.ballNumberLabel[6].text = bonus
                
            case .failure(let error):
                print(error)
            }
        }
    }


}

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        numberTextField.text = "\(list[row])회 당첨결과"
        callRequest(number: list[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(list[row])회"
    }
    
}

extension LottoViewController {
    
    func designBallLabel() {
        
        for item in ballNumberLabel {
            item.textAlignment = .center
            item.font = .boldSystemFont(ofSize: 13)
            item.layer.cornerRadius = 10
            item.clipsToBounds = true
        }
    }
    
    func designDateLabel() {
        dateLabel.textAlignment = .center
        dateLabel.font = .systemFont(ofSize: 13)
    }
}
