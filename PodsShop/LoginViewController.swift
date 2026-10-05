import UIKit
import SnapKit

final class LoginViewController: UIViewController {
    private let email = UITextField()
    private let password = UITextField()
    private let button = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign in"
        view.backgroundColor = .systemBackground
        email.placeholder = "Email"
        email.borderStyle = .roundedRect
        password.placeholder = "Password"
        password.isSecureTextEntry = true
        password.borderStyle = .roundedRect
        button.setTitle("Sign in", for: .normal)
        button.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        let stack = UIStackView(arrangedSubviews: [email, password, button])
        stack.axis = .vertical
        stack.spacing = 12
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }

    @objc private func signIn() {
        SessionStore.shared.signIn(email: email.text ?? "", password: password.text ?? "") { [weak self] result in
            guard case .success = result else { return }
            self?.navigationController?.setViewControllers([CatalogViewController()], animated: true)
        }
    }
}
