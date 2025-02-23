import UIKit

class MachineLearningViewController: UIViewController {
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Welcome to Machine Learning Class"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Machine Learning View Controller"
        setupUI()
    }

    private func setupUI() {
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
