//
//  KakaoVideoViewController.swift
//  APIPractice
//
//  Created by ChaewonMac on 2023/08/17.
//

import UIKit
import Kingfisher

class KakaoVideoViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var videoTableView: UITableView!
    
    var videoList: SearchVideo = SearchVideo(meta: Meta(totalCount: 0, isEnd: false, pageableCount: 0), documents: [])
    var page = 1
    var isEnd = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoTableView.delegate = self
        videoTableView.dataSource = self
        videoTableView.prefetchDataSource = self
        videoTableView.rowHeight = 140
        
        searchBar.delegate = self
    }
    

}

extension KakaoVideoViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        page = 1
        guard let query = searchBar.text else { return }
        KakaoAPIManager.shared.callRequest(query: query, page: page) { data in
            self.isEnd = data.meta.isEnd
            self.videoList = data
            self.videoTableView.reloadData()
            self.videoTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
        
        
        
    }
}


extension KakaoVideoViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoList.documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = videoTableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.identifier) as? VideoTableViewCell else { return UITableViewCell() }
        cell.titleLabel.text = videoList.documents[indexPath.row].title
        
        let author = videoList.documents[indexPath.row].author
        let time = videoList.documents[indexPath.row].playTime
        let date = videoList.documents[indexPath.row].datetime
        
        var contents: String {
            return "\(author) | \(time)회\n\(date)"
        }
        cell.infoLabel.text = contents
        
        if let url = URL(string: videoList.documents[indexPath.row].thumbnail) {
            cell.thumbnailImageView.kf.setImage(with: url)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            if videoList.documents.count - 1 == indexPath.row && page < 15 && isEnd == false { // !isEnd 이렇게 표현할 수도 있음
                page += 1
                KakaoAPIManager.shared.callRequest(query: searchBar.text!, page: page) { data in
                    self.videoList.documents.append(contentsOf: data.documents)
                    self.videoTableView.reloadData()
                }
            }
        }
    }
    
    
}

extension KakaoVideoViewController {
    

}

