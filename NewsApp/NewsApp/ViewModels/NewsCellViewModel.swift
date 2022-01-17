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
    self.publishedAt = Date.toString(news.publishedAt) ?? "No date"
  }

  private func formatDate(date: Date?) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d, yyyy"
    dateFormatter.timeZone = .current
    if let date = date {
      return dateFormatter.string(from: date)
    } else {
      return nil
    }
  }
}
