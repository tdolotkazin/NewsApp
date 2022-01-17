import Foundation

struct NewsData: Codable {
  let articles: [SingleNewsData]
}

struct SingleNewsData: Codable {
  let title: String
  let description: String
  let url: String
  let urlToImage: String
  let publishedAt: String
}

