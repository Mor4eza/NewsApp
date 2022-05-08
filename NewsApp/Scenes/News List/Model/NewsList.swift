    //
    //  NewsList.swift
    //  NewsApp
    //
    //  Created by Morteza on 5/8/22.
    //

import Foundation

struct NewsList: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

    // MARK: - Article
struct Article: Codable {
    let author: String?
    let title, description: String
    let url: String
    let urlToImage: String
    let content: String
}
