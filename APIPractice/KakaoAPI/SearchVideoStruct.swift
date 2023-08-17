//
//  SearchVideoStruct.swift
//  APIPractice
//
//  Created by ChaewonMac on 2023/08/17.
//

import Foundation

// MARK: - SearchVideo
struct SearchVideo: Codable {

    let meta: Meta
    var documents: [Document]
 
}

// MARK: - Document
struct Document: Codable {
    let thumbnail: String
    let datetime: String
    let playTime: Int
    let title: String
    let author: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case thumbnail, datetime
        case playTime = "play_time"
        case title, author, url
    }
}

// MARK: - Meta
struct Meta: Codable {
    let totalCount: Int
    let isEnd: Bool
    let pageableCount: Int

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
    }
}

