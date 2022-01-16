import UIKit

class NewsCell: UITableViewCell {

  @IBOutlet weak var newsImage: UIImageView!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!

  override func awakeFromNib() {
        super.awakeFromNib()

    }

  func update(with cellViewModel: NewsCellViewModel) {
    self.newsImage.image = UIImage(data: cellViewModel.image!)
    self.titleLabel.text = cellViewModel.title
    self.dateLabel.text = cellViewModel.publishedAt
    self.descriptionLabel.text = cellViewModel.description
  }
}
