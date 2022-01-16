import Foundation

struct News {
  let title: String
  let url: URL?
  let image: Data?
  let description: String
  let publishedAt: Date?

  init(newsData: SingleNewsData) {
    self.title = newsData.title
    self.url = URL(string: newsData.url)
    if let imageURL = URL(string: newsData.urlToImage) {
      self.image = try? Data(contentsOf: imageURL)
    } else {
      self.image = nil
    }
    self.description = newsData.description
    self.publishedAt = Date.fromString(newsData.publishedAt)
  }
}
