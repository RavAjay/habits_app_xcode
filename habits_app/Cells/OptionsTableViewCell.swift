import UIKit

class OptionsTableViewCell: UITableViewCell {

    let titleLabel = UILabel()
    let valueLabel = UILabel()
    let subtitleLabel = UILabel()
    let leftPercentageLabel = UILabel()
    let rightPercentageLabel = UILabel()
    let barGraphView = BarGraphView()

    let gradientView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10  // ✅ Fully rounded corners for iMessage-style look
        view.layer.masksToBounds = false  // ✅ Allows shadow to be visible
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.15  // ✅ Slightly more noticeable shadow
        view.layer.shadowOffset = CGSize(width: 0, height: 3)  // ✅ Softer shadow positioning
        view.layer.shadowRadius = 8  // ✅ More diffused shadow
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1.9
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let gradientLayer = CAGradientLayer()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        applyGradient()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        gradientLayer.frame = gradientView.bounds
        gradientLayer.cornerRadius = 10

        if gradientLayer.superlayer == nil {
            gradientView.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    
    func setupFonts() {
        self.titleLabel.font = FontManager.getFont(size: .large)
        self.valueLabel.font = FontManager.getFont(size: .small)
        self.subtitleLabel.font = FontManager.getFont(size: .small)
        self.leftPercentageLabel.font = FontManager.getFont(size: .small)
        self.rightPercentageLabel.font = FontManager.getFont(size: .small)
        
        
    }

    private func setupViews() {
        [titleLabel, valueLabel, subtitleLabel, leftPercentageLabel, rightPercentageLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            cardView.addSubview($0)
        }

        contentView.addSubview(gradientView)
        contentView.addSubview(cardView)

        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            gradientView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            gradientView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            gradientView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),

            cardView.topAnchor.constraint(equalTo: gradientView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: gradientView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: gradientView.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: gradientView.bottomAnchor)
        ])

        // ✅ Layout Constraints for Labels & Graph
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),

            valueLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),

            leftPercentageLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 8),
            leftPercentageLabel.leadingAnchor.constraint(equalTo: subtitleLabel.leadingAnchor),

            rightPercentageLabel.centerYAnchor.constraint(equalTo: leftPercentageLabel.centerYAnchor),
            rightPercentageLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),

//            barGraphView.topAnchor.constraint(equalTo: leftPercentageLabel.bottomAnchor, constant: 8),
//            barGraphView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
//            barGraphView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
//            barGraphView.heightAnchor.constraint(equalToConstant: 16),
//            barGraphView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -20)
        ])
    }

    private func applyGradient() {
        gradientLayer.colors = [
            UIColor(red: 225/255, green: 227/255, blue: 215/255, alpha: 1).cgColor,
            UIColor.red.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        // Ensure the gradient has an initial frame
        gradientLayer.frame = gradientView.bounds
    }

    func configure(title: String, value: String, progress: Float, leftPercent: String, rightPercent: String, insurance:String) {
        titleLabel.text = title
        valueLabel.text = value
        subtitleLabel.text = insurance
        leftPercentageLabel.text = leftPercent
        rightPercentageLabel.text = rightPercent
        barGraphView.progress = CGFloat(progress)
        self.setupFonts()
    }
}
