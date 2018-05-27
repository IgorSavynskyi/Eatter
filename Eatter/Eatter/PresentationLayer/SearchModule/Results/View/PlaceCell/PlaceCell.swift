import UIKit

class PlaceCell: UICollectionViewCell {
    // MARK: - Private Props
    @IBOutlet weak private var cardView: UIView!
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var ratingLabel: UILabel!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var foodTypesLabel: UILabel!
    @IBOutlet weak private var availabilityLabel: UILabel!
    @IBOutlet weak private var availabilityLightView: UIView!
    lazy private var downloader = ImageDownloader()
    
    // MARK: - API
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyles()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateShadowLayer()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        downloader.cancelDownload()
        imageView.image = nil
    }
    
    func renderPlace(_ place: PlaceViewModel) {
        nameLabel.text = place.name
        foodTypesLabel.text = place.cuisineTypes.joined(separator: ", ")
        availabilityLightView.backgroundColor = place.isOpenNow ? .availableColor : .red
        availabilityLabel.text = place.isOpenNow ? "Open now" : "Closed now"
        if let rating = place.ratingAverage, rating > 0 {
            ratingLabel.text = "Rating: " + String.init(format: "%.1f", rating)
        } else {
           ratingLabel.text = "Be first to rate"
        }
        
        if let logo = place.logo {
            downloadMedia(logo)
        }
    }
    
    // MARK: - Private API
    private func setupStyles() {
        cardView.layer.cornerRadius = 8
        imageView.layer.cornerRadius = 8
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.masksToBounds = true
        availabilityLightView.layer.cornerRadius = availabilityLightView.bounds.height/2
        
        nameLabel
            .font(.titleFont)
            .textColor(.textColor)
        
        applyStyle(font: .smallFont, textColor: .textColor, to: foodTypesLabel, availabilityLabel, ratingLabel)
    }
    
    
    private func downloadMedia(_ url: String) {
        guard let url = URL(string: url) else { return }
        downloader.downloadImage(from: url) {[weak self] (result) in
            if case let .success(image) = result {
                self?.setMedia(image)
            }
        }
    }
    
    private func setMedia(_ image: UIImage) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    
    private func updateShadowLayer() {
        cardView.applyDefaultStyleShadow(cardView.layer.cornerRadius)
    }
    
}
