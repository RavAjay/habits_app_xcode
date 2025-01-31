// 1
import UIKit

// 2
class CustomTableViewCell: UITableViewCell
{
    // 3
    let groupLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let chartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // 4
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "GroupTVCell")
        
        // 5
        addSubviews()
        
        // 6
        setupConstraints()
    }
    
    // 4
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 5
    func addSubviews() {
        addSubview(groupLabel)
        addSubview(chartImageView)
    }
    
    // 6
    func setupConstraints() {
        setupGroupLabel()
        setupChartImageView()
    }
    
    func setupGroupLabel() {
        groupLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        groupLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        groupLabel.widthAnchor.constraint(equalToConstant: frame.width / 2).isActive = true
    }
    
    func setupChartImageView() {
        chartImageView.topAnchor.constraint(equalTo: topAnchor, constant: 7).isActive = true
        chartImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7).isActive = true
        chartImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7).isActive = true
        chartImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
    }
}
