import Foundation

class NewsRepository {
  private var news: [News] = []
  private var featuredNews: News?
  let apiManager: APIManager

  init(apiManager: APIManager) {
    self.apiManager = apiManager
    self.apiManager.delegate = self
    fetchAllNews()
  }

  private func fetchAllNews() {
    apiManager.fetchFeaturedNews()
    apiManager.fetchRegularNews()
  }

  func getNewsFor(index: Int, isFeatureNews: Bool) -> News? {
    if isFeatureNews {
      return featuredNews
    } else {
      return news[index]
    }
  }
}

extension NewsRepository: APIManagerDelegate {
  func regularNewsParsed(news: [News]) {
    self.news.append(contentsOf: news)
  }

  func featuredNewsParsed(news: News) {
    featuredNews = news
  }
}
