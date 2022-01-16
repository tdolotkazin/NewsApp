import UIKit

class NewsViewController: UITableViewController {

  let newsRepository = NewsRepository(apiManager: APIManager())

  override func viewDidLoad() {
    super.viewDidLoad()

  }
}

