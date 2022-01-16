import UIKit

class FeaturedNewsCell: UITableViewCell {

  @IBOutlet weak var newsImage: UIImageView!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()

  }

  func update(with cellViewModel: NewsCellViewModel) {
    self.newsImage.image = UIImage(data: cellViewModel.image!)
    newsImage.contentMode = .scaleToFill
    newsImage.clipsToBounds = true
    self.titleLabel.text = cellViewModel.title
    self.dateLabel.text = cellViewModel.publishedAt
  }
}
