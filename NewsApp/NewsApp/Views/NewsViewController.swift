import UIKit

class NewsViewController: UITableViewController {

  let newsViewModel = NewsViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    newsViewModel.loadingCompletion = { [weak self] in
      self?.updateUI()
    }
  }

  func updateUI() {
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
}

extension NewsViewController {
  override func numberOfSections(in tableView: UITableView) -> Int {
    2
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0
    {
      return 1
    } else {
      return newsViewModel.getNewsCount()
    }
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if !newsViewModel.newsAreLoading {
      if indexPath.section == 0 {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FeatureNewsCell") as? FeaturedNewsCell {
          let cellViewModel = newsViewModel.getNews(for: indexPath.row, featured: true)
          cell.update(with: cellViewModel)
          return cell
        } else {fatalError()}
      } else {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as? NewsCell {
          let cellViewModel = newsViewModel.getNews(for: indexPath.row, featured: false)
          cell.update(with: cellViewModel)
          return cell
        }
      }
    }
    return UITableViewCell()
  }
}

extension NewsViewController {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    var url: URL
    if indexPath.section == 0 {
      url = newsViewModel.getNews(for: 0, featured: true).url!
    } else {
      url = newsViewModel.getNews(for: indexPath.row, featured: false).url!
    }
    let webViewController = WebViewController()
    webViewController.url = url
    present(webViewController, animated: true, completion: nil)
  }
}

