import UIKit

class NewsCell: UITableViewCell {

  @IBOutlet weak var newsImage: UIImageView!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var containerView: UIView!

  override func awakeFromNib() {
    super.awakeFromNib()
    selectionStyle = .none
    createRoundedCorners()
    createShadow()
  }

  func createRoundedCorners() {
    containerView.layer.cornerRadius = 8
    containerView.layer.masksToBounds = true
  }

  func createShadow() {
    backgroundColor = .clear
    layer.masksToBounds = false
    layer.shadowOffset = CGSize(width: 0, height: 0)
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.3
    layer.shadowRadius = 5
  }

  func update(with cellViewModel: NewsCellViewModel) {
    self.newsImage.image = UIImage(data: cellViewModel.image!)
    newsImage.contentMode = .scaleAspectFill
    newsImage.clipsToBounds = true
    self.titleLabel.text = cellViewModel.title
    self.dateLabel.text = cellViewModel.publishedAt
    self.descriptionLabel.text = cellViewModel.description
  }
}
