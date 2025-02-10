import UIKit

class CustomTableViewCell: UITableViewCell {
    
    // Group Name Label
    let groupLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium) // Main title font
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Bottom Labels (Calories, Steps, Distance, Hours)
    let detailsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular) // Sub-details font
        label.textColor = UIColor(white: 0.8, alpha: 1) // Lighter text color for sub-details
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Circular Image View
    let chartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 2.0
        imageView.layer.cornerRadius = 22 // Half of the width/height to make it circular
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Arrow Indicator
    let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right") // System chevron icon
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.black // Match dark theme
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Add Subviews
    func addSubviews() {
        addSubview(chartImageView)
        addSubview(groupLabel)
        addSubview(detailsLabel)
        addSubview(arrowImageView)
    }
    
    // Set up constraints for all views
    func setupConstraints() {
        // Chart Image View Constraints
        chartImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        chartImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        chartImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        chartImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        // Group Label Constraints (Top Text)
        groupLabel.leadingAnchor.constraint(equalTo: chartImageView.trailingAnchor, constant: 15).isActive = true
        groupLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        groupLabel.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -10).isActive = true
        
        // Details Label Constraints (Bottom Text)
        detailsLabel.leadingAnchor.constraint(equalTo: groupLabel.leadingAnchor).isActive = true
        detailsLabel.topAnchor.constraint(equalTo: groupLabel.bottomAnchor, constant: 5).isActive = true
        detailsLabel.trailingAnchor.constraint(equalTo: groupLabel.trailingAnchor).isActive = true
        
        // Arrow Image View Constraints
        arrowImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        arrowImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        arrowImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        arrowImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }
    
    // Configure Cell Data
    func configureCell(image: UIImage?, groupName: String, details: String) {
        chartImageView.image = image
        groupLabel.text = groupName
        detailsLabel.text = details
    }
}
