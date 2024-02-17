import UIKit
import SnapKit
import Kingfisher

/// A table view cell for displaying launch list items.
final class LaunchListTableViewCell: RxReusableTableViewCell {

    // MARK: - Internal interface
    /// The model type associated with this cell.
    typealias Model = LaunchListItem

    /// Configures the cell with the provided model.
    /// - Parameter model: The model used to configure the cell.
    func configure(_ model: Model) {
        nameLabel.text = model.name
        if let imageURL = model.imageURL {
            launchImageView.kf.setImage(with: imageURL)
        } else {
            launchImageView.image = UIImage(named: Constants.defaultRocketLaunchImage)
        }
        dateLabel.text = model.net
        serviceProviderLabel.text = model.launchServiceProvider
        locationLabel.text = model.location
    }

    // MARK: - Private interface
    private enum Constants {
        static let launchImageViewCornerRadius: CGFloat = 8
        static let launchImageViewHeight: CGFloat = 70
        static let nameLabelNumberOfLines = 2
        static let cellStackViewVerticalPadding: CGFloat = 10
        static let cellStackViewSpacing: CGFloat = 16
        static let cellStackViewPadding: CGFloat = 16
        static let cellSideMargin: CGFloat = 8
        static let cellTopBottomMargin: CGFloat = 4
        static let narrowStackViewSpacing: CGFloat = 4
        static let defaultRocketLaunchImage = "default_rocket_launch_image"
    }

    // MARK: - UI elements
    private lazy var launchImageView: UIImageView = {
        let image = UIImage()
        let imageView = UIImageView(image: image)
        imageView.tintColor = .black
        imageView.layer.cornerRadius = Constants.launchImageViewCornerRadius
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = Constants.nameLabelNumberOfLines
        return label
    }()

    private lazy var dateImageView: UIImageView = {
        let image = UIImage(systemName: "calendar")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .label
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        return imageView
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        return label
    }()

    private lazy var dateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = Constants.narrowStackViewSpacing
        return stackView
    }()

    private lazy var serviceProviderImageView: UIImageView = {
        let image = UIImage(systemName: "flag")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .label
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        return imageView
    }()

    private lazy var serviceProviderLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        return label
    }()

    private lazy var serviceProviderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = Constants.narrowStackViewSpacing
        return stackView
    }()

    private lazy var locationImageView: UIImageView = {
        let image = UIImage(systemName: "mappin")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .label
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        return imageView
    }()

    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        return label
    }()

    private lazy var locationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = Constants.narrowStackViewSpacing
        return stackView
    }()

    private lazy var textInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.spacing = Constants.narrowStackViewSpacing
        return stackView
    }()

    private lazy var cellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = Constants.cellStackViewSpacing
        return stackView
    }()

    private lazy var cellContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = Constants.launchImageViewCornerRadius
        return view
    }()

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Private setup
private extension LaunchListTableViewCell {

    func addSubviews() {
        dateStackView.addArrangedSubview(dateImageView)
        dateStackView.addArrangedSubview(dateLabel)
        serviceProviderStackView.addArrangedSubview(serviceProviderImageView)
        serviceProviderStackView.addArrangedSubview(serviceProviderLabel)
        locationStackView.addArrangedSubview(locationImageView)
        locationStackView.addArrangedSubview(locationLabel)
        textInfoStackView.addArrangedSubview(dateStackView)
        textInfoStackView.addArrangedSubview(serviceProviderStackView)
        textInfoStackView.addArrangedSubview(locationStackView)
        cellStackView.addArrangedSubview(launchImageView)
        cellStackView.addArrangedSubview(textInfoStackView)
        cellContentView.addSubview(nameLabel)
        cellContentView.addSubview(cellStackView)
        addSubview(cellContentView)
    }

    func setConstraints() {
        launchImageView.snp.makeConstraints { make in
            make.height.width.equalTo(Constants.launchImageViewHeight)
        }

        nameLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(Constants.cellStackViewPadding)
            make.trailing.equalToSuperview().offset(-Constants.cellStackViewPadding)
        }

        cellStackView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(Constants.cellTopBottomMargin)
            make.leading.equalToSuperview().offset(Constants.cellStackViewPadding)
            make.trailing.bottom.equalToSuperview().offset(-Constants.cellStackViewPadding)
        }

        cellContentView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.cellTopBottomMargin)
            make.bottom.equalToSuperview().offset(-Constants.cellTopBottomMargin)
            make.leading.equalToSuperview().offset(Constants.cellSideMargin)
            make.trailing.equalToSuperview().offset(-Constants.cellSideMargin)
        }
    }
}

// swiftlint:disable all
// MARK: - Preview
@available(iOS 17, *)
#Preview("LaunchItemTableViewCell") {
    let cell = LaunchListTableViewCell(style: .default, reuseIdentifier: "")
    cell.configure(.init(id: "",
                         imageURL: URL(string: "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/launcher_images/proton-m_image_20191211081456.jpeg"),
                         name: "Falcon Heavy | Psyche",
                         net: "Oct. 12, 2023, 4:16 p.m.",
                         launchServiceProvider: "SpaceX | USA",
                         location: "Kennedy Space Center, FL, USA"))
    return cell
}
// swiftlint:enable all
