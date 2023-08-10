//
//  TranslateViewController.swift
//  APIPractice
//
//  Created by ChaewonMac on 2023/08/10.
//

import UIKit
import Alamofire
import SwiftyJSON

class TranslateViewController: UIViewController {

    
    @IBOutlet var sourceLangLabel: UILabel!
    @IBOutlet var targetLangLabel: UILabel!
    
    @IBOutlet var originTextView: UITextView!
    @IBOutlet var translatedTextView: UITextView!
    @IBOutlet var requestButton: UIButton!
    
    let header: HTTPHeaders = [
        "X-Naver-Client-Id": "cmfzB9K1eETE23aBk2aN",
        "X-Naver-Client-Secret": APIKey.naverKey
    ]
    
    var detected = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        originTextView.text = ""
        translatedTextView.text = ""
        translatedTextView.isEditable = false
        
    }
    
    @IBAction func requestButtonClicked(_ sender: UIButton) {

    }
    
    func callDetectLangRequest() {
        let url = "https://openapi.naver.com/v1/papago/detectLangs"
        let parameters: Parameters = [
            "query": originTextView.text ?? ""
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                self.detected = json["langCode"].stringValue

            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func callTranslationRequest(src: String) {
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let parameters: Parameters = [
            "source": src,
            "target": "en",
            "text": originTextView.text ?? ""
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
        
    }

}
