import Foundation

protocol APIManagerDelegate: AnyObject {
  func featuredNewsParsed(news: News)
  func regularNewsParsed(news:[News])
}

class APIManager {

  typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
  private var apiKey: String?
  lazy private var session = URLSession(configuration: .default)
  weak var delegate: APIManagerDelegate?

  init() {
    apiKey = getAPIKey()
  }

  private func getAPIKey() -> String? {
    guard let path = Bundle.main.path(forResource: "api-key", ofType: "json"),
          let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
          let json = try? JSONSerialization.jsonObject(with: data, options: []),
          let json = json as? Dictionary<String, String>,
          let apiKey = json["api-key"] else { return nil }
    return apiKey
  }

  func fetchFeaturedNews() {
    guard let initialUrl = URL(string: "https://newsapi.org/v2/top-headlines?country=us") else { return }
    let url = addQuery(item: URLQueryItem(name: "pageSize", value: "1"), to: initialUrl)
    executeAPIRequest(url: url) { data, response, error in
      guard let data = data,
            let newsData = self.parseJSON(from: data),
            let singleNewsData = newsData.articles.first else { return }
      let news = News(newsData: singleNewsData)
      self.delegate!.featuredNewsParsed(news: news)
    }
  }

  func fetchRegularNews() {
    guard let initialUrl = URL(string: "https://newsapi.org/v2/everything?domains=techcrunch.com&sortBy=popularity") else { return }
    let url = addQuery(item: URLQueryItem(name: "pageSize", value: "20"), to: initialUrl)
    executeAPIRequest(url: url) { data, response, error in
      guard let data = data,
            let newsData = self.parseJSON(from: data)?.articles else { return }
      var news = [News]()
      for singleNewsData in newsData {
        news.append(News(newsData: singleNewsData))
      }
      self.delegate?.regularNewsParsed(news: news)
    }
  }

  private func addQuery(item queryItem: URLQueryItem, to url: URL) -> URL {
    var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
    var queryItems = urlComponents?.queryItems ?? []
    queryItems.append(queryItem)
    urlComponents?.queryItems = queryItems
    return urlComponents?.url ?? url
  }

  private func executeAPIRequest(url: URL, completionHandler: @escaping CompletionHandler) {
    let urlWithApiKey = addQuery(item: URLQueryItem(name: "apiKey", value: apiKey), to: url)
    let task = session.dataTask(with: urlWithApiKey, completionHandler: completionHandler)
    task.resume()
  }

  private func parseJSON(from data: Data) -> NewsData? {
    let decoder = JSONDecoder()
    do {
      let newsData = try decoder.decode(NewsData.self, from: data)
      return newsData
    } catch {
      return nil
    }
  }
}
