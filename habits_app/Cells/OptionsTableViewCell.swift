import UIKit

class OptionsTableViewCell: UITableViewCell {

    let titleLabel = UILabel()
    let valueLabel = UILabel()
    let subtitleLabel = UILabel()
    let leftPercentageLabel = UILabel()
    let rightPercentageLabel = UILabel()
    let barGraphView = BarGraphView()

    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25  // ✅ Fully rounded corners for iMessage-style look
        view.layer.masksToBounds = true  // ✅ Ensures smooth corners
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        [titleLabel, valueLabel, subtitleLabel, leftPercentageLabel, rightPercentageLabel, barGraphView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            cardView.addSubview($0)
        }

        contentView.addSubview(cardView)

        // ✅ Updated Constraints for Better Spacing
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
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

            barGraphView.topAnchor.constraint(equalTo: leftPercentageLabel.bottomAnchor, constant: 8),
            barGraphView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            barGraphView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            barGraphView.heightAnchor.constraint(equalToConstant: 16),
            barGraphView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -20)
        ])
    }

    func configure(title: String, value: String, progress: Float, leftPercent: String, rightPercent: String) {
        titleLabel.text = title
        valueLabel.text = value
        subtitleLabel.text = "Insurance Coverage"
        leftPercentageLabel.text = leftPercent
        rightPercentageLabel.text = rightPercent
        barGraphView.progress = CGFloat(progress)
    }
}
