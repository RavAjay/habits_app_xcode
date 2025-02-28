import UIKit

class OptionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var options: [(title: String, value: String, progress: Float, leftPercent: String, rightPercent: String)] = [
        ("Doctor's visit", "$120", 0.9, "90%", "10%"),
        ("Gym membership", "$50", 0.7, "70%", "30%"),
        ("Reading", "$0", 0.95, "95%", "5%")
    ]

    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Options"
        setupTableView()
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: "OptionsCell")

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OptionsCell", for: indexPath) as? OptionsTableViewCell else {
            return UITableViewCell()
        }

        let option = options[indexPath.row]
        cell.configure(title: option.title, value: option.value, progress: option.progress, leftPercent: option.leftPercent, rightPercent: option.rightPercent)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
