import Foundation


class NewsCellViewModel {
  var news: News?

  var title: String
  var url: URL?
  let image: Data?
  let description: String
  let publishedAt: String

  init(news: News) {
    self.title = news.title
    self.url = news.url
    self.image = news.image
    self.description = news.description
    self.publishedAt = "01.01.2022"
  }
}
