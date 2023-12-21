import UIKit

import UIKit

final class WishStoringViewController: UIViewController {
    private enum Constants {
        static let backgroundColor: UIColor = .blue
        static let tableViewBackgroundColor: UIColor = .red
        static let tableViewStyle: UITableView.Style = .plain
        static let numberOfSections = 2
        static let wishesKey = "wishes"
    }

    private var tableView: UITableView!
    private var wishArray: [String] = []
    private let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        loadWishes()
        configureTable()
    }

    private func configureTable() {
        tableView = UITableView(frame: .zero, style: Constants.tableViewStyle)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.backgroundColor = Constants.tableViewBackgroundColor

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        tableView.dataSource = self
        tableView.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.Constants.reuseId)
        tableView.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.Constants.reuseId)
    }
    private func loadWishes() {
        if let savedWishes = defaults.array(forKey: Constants.wishesKey) as? [String] {
            wishArray = savedWishes
        }
    }
    private func saveWishes() {
        defaults.set(wishArray, forKey: Constants.wishesKey)
    }
}

extension WishStoringViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return wishArray.count
        default: return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddWishCell.Constants.reuseId, for: indexPath) as? AddWishCell else {
                fatalError("Could not dequeue AddWishCell")
            }
            cell.addWish = { [weak self] wish in
                self?.wishArray.append(wish)
                self?.saveWishes()
                self?.tableView.reloadData()
            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.Constants.reuseId, for: indexPath) as? WrittenWishCell else {
                fatalError("Could not dequeue WrittenWishCell")
            }
            cell.configure(with: wishArray[indexPath.row])
            return cell
        default:
            fatalError("Unexpected section")
        }
    }
}

final class WrittenWishCell: UITableViewCell {
    enum Constants {
        static let reuseId: String = "WrittenWishCell"
        static let selectionStyle: UITableViewCell.SelectionStyle = .none
        static let backgroundColor: UIColor = .clear
        static let labelTopPadding: CGFloat = 10
        static let labelBottomPadding: CGFloat = -10
        static let labelLeadingPadding: CGFloat = 10
        static let labelTrailingPadding: CGFloat = -10
    }

    private let wishLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with wish: String) {
        wishLabel.text = wish
    }

    private func configureUI() {
        selectionStyle = Constants.selectionStyle
        backgroundColor = Constants.backgroundColor
        contentView.addSubview(wishLabel)

        NSLayoutConstraint.activate([
            wishLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.labelTopPadding),
            wishLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.labelBottomPadding),
            wishLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.labelLeadingPadding),
            wishLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.labelTrailingPadding)
        ])
    }
}

final class AddWishCell: UITableViewCell {
    enum Constants {
        static let reuseId = "AddWishCell"
        static let textViewTopInset: CGFloat = 8
        static let textViewHorizontalInset: CGFloat = 10
        static let textViewHeight: CGFloat = 100
        static let addButtonTopInset: CGFloat = 8
        static let addButtonHeight: CGFloat = 44
        static let addButtonBottomInset: CGFloat = -10
        static let textViewBackgroundColor: UIColor = .green
        static let textViewCornerRadius: CGFloat = 10
        static let addButtonTitle: String = "Add Wish"
    }

    private let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = Constants.textViewBackgroundColor
        textView.layer.cornerRadius = Constants.textViewCornerRadius
        textView.clipsToBounds = true
        return textView
    }()

    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.addButtonTitle, for: .normal)
        return button
    }()

    var addWish: ((String) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        contentView.addSubview(textView)
        contentView.addSubview(addButton)

        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.textViewTopInset),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.textViewHorizontalInset),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.textViewHorizontalInset),
            textView.heightAnchor.constraint(equalToConstant: Constants.textViewHeight),

            addButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: Constants.addButtonTopInset),
            addButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.textViewHorizontalInset),
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.textViewHorizontalInset),
            addButton.heightAnchor.constraint(equalToConstant: Constants.addButtonHeight),
            addButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.addButtonBottomInset)
        ])

        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }

    @objc private func addButtonTapped() {
        let wishText = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if !wishText.isEmpty {
            addWish?(wishText)
            textView.text = ""
        }
    }
}
