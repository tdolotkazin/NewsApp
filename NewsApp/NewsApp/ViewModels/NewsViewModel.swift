import Foundation
import UIKit

class NewsViewModel {

  private var newsRepository = NewsRepository(apiManager: APIManager())
  private var news: [News] = []
  private var featuredNews: News?
  var newsAreLoading: Bool = true
  var loadingCompletion: (() -> ())?

  init() {
    newsRepository.delegate = self
  }

  func getNews(for index: Int, featured: Bool) -> NewsCellViewModel {
    let news = featured ? featuredNews! : news[index]
    let cellViewModel = NewsCellViewModel(news: news)
    return cellViewModel
  }

  func getNewsCount() -> Int {
    return news.count
  }
}

extension NewsViewModel: NewsRepositoryDelegate {
  func allNewsAreFetched(regular: [News], featured: News) {
    newsAreLoading = false
    self.news = regular
    self.featuredNews = featured
    loadingCompletion?()
  }
}
