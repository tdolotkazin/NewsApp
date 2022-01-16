
import Foundation

struct News {
  let title: String
  let url: URL?
  let urlToImage: URL?
  let description: String
  let publishedAt: Date?

  init(newsData: SingleNewsData) {
    self.title = newsData.title
    self.url = URL(string: newsData.url)
    self.urlToImage = URL(string: newsData.urlToImage)
    self.description = newsData.description
    self.publishedAt = Date.fromString(newsData.publishedAt)
  }
}
