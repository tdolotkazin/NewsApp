import Foundation

protocol NewsRepositoryDelegate: AnyObject {
  func allNewsAreFetched(regular: [News], featured: News?)
}

class NewsRepository {

  weak var delegate: NewsRepositoryDelegate?
  private var news: [News] = []
  private var featuredNews: News?
  private let apiManager: APIManager
  private var newsFetchedFlag: Bool = false

  init(apiManager: APIManager) {
    self.apiManager = apiManager
    self.apiManager.delegate = self
    fetchAllNews()
  }

  private func fetchAllNews() {
    apiManager.fetchFeaturedNews()
    apiManager.fetchRegularNews()
  }

  func fetchNextPage() {
    apiManager.fetchRegularNews(nextPage: true)
  }
}

extension NewsRepository: APIManagerDelegate {
  func regularNewsParsed(news: [News], nextPage:Bool) {
    self.news.append(contentsOf: news)
    if nextPage {
      delegate?.allNewsAreFetched(regular: self.news, featured: nil)
      return
    }
    if newsFetchedFlag {
      delegate?.allNewsAreFetched(regular: self.news, featured: featuredNews!)
    } else {
      newsFetchedFlag = true
    }
  }

  func featuredNewsParsed(news: News) {
    featuredNews = news
    if newsFetchedFlag {
      delegate?.allNewsAreFetched(regular: self.news, featured: featuredNews!)
    } else {
      newsFetchedFlag = true
    }
  }
}
