//
//  KakaoAPIManager.swift
//  APIPractice
//
//  Created by ChaewonMac on 2023/08/17.
//

import Foundation
import Alamofire

class KakaoAPIManager {
    static let shared = KakaoAPIManager()
    
    private init() { }
    
    let header: HTTPHeaders = ["Authorization": "KakaoAK \(APIKey.kakaoKey)"]
    
    func callRequest(query: String, page: Int, completionHandler: @escaping (SearchVideo) -> Void) {
        guard let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let pageString = "&page=\(page)"
        let url = URL.baseURL + text + pageString
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500)
            .responseDecodable(of: SearchVideo.self) { response in
                switch response.result {
                case .success(let value):
                    
                    completionHandler(value)
                    
                case .failure(let error):
                    print(error)
                }
            }
        
    }
}
