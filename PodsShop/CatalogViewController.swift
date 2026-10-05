import UIKit
import SnapKit

struct Product {
    let id: String
    let name: String
    let price: Decimal
}

final class CatalogViewController: UITableViewController {
    private let products = [
        Product(id: "p1", name: "Coffee beans", price: 12),
        Product(id: "p2", name: "Grinder", price: 89),
        Product(id: "p3", name: "Kettle", price: 45),
    ]
    private var cart: [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shop"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector(signOut))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Checkout", style: .done, target: self, action: #selector(checkout))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { products.count }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(products[indexPath.row].name) — $\(products[indexPath.row].price)"
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cart.append(products[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @objc private func checkout() {
        guard !cart.isEmpty else { return }
        let total = cart.reduce(Decimal(0)) { $0 + $1.price }
        let alert = UIAlertController(title: "Order placed", message: "Total $\(total)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        cart.removeAll()
    }

    @objc private func signOut() {
        SessionStore.shared.signOut()
        navigationController?.setViewControllers([LoginViewController()], animated: true)
    }
}
