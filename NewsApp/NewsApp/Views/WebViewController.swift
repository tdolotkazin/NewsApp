import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

  var webView: WKWebView!
  var url: URL!

  override func loadView() {
    webView = WKWebView()
    webView.navigationDelegate = self
    view = webView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    webView.load(URLRequest(url: url))
  }
}
