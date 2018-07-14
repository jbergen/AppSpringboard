//
//  MainMenuViewController.swift
//  AppSpringboard
//
//  Created by Joseph Bergen on 7/13/18.
//  Copyright © 2018 Joseph Bergen. All rights reserved.
//

import UIKit

private enum Topic {
    case tableViewController

    var title: String? {
        switch self {
        case .tableViewController:
            return "UITableViewController"
        }
    }

    var rowCount: Int {
        return self.rowType.count
    }

    func row(_ row: Int) -> SectionRowProtocol? {
        return self.rowType.init(value: row)
    }

    var rowType: SectionRowProtocol.Type {
        switch self {
        case .tableViewController:
            return TableViewControllerRow.self
        }
    }
}

protocol SectionRowProtocol {
    static var count: Int { get }
    var title: String { get }
    var viewController: UIViewController { get }
    init?(value: Int)
}

private enum TableViewControllerRow: Int, SectionRowProtocol {
    case plain
    case grouped

    static var count: Int = 2

    var title: String {
        switch self {
        case .plain:
            return "Plain"
        case .grouped:
            return "Grouped"
        }
    }

    var viewController: UIViewController {
        switch self {
        case .plain:
            return PlainTableViewController()
        case .grouped:
            return GroupedTableViewController()
        }
    }

    init?(value: Int) {
        guard let row = TableViewControllerRow(rawValue: value) else { return nil }
        self = row
    }
}

class MainMenuViewController: UITableViewController {
    private let genericCellReusableId = "reuse id";
    private let topics: [Topic] = [.tableViewController]

    convenience init() {
        self.init(style: .grouped)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main Menu"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: genericCellReusableId)
    }

    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = topics[indexPath.section].row(indexPath.row)?.viewController else { return }
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return topics.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics[section].rowCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: genericCellReusableId, for: indexPath)
        let sectionType = topics[indexPath.section]

        cell.accessoryType = .disclosureIndicator

        let rowType = sectionType.row(indexPath.row)
        cell.textLabel?.text = rowType?.title

        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let title = topics[section].title else { return nil }
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 20))
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: tableView.bounds.width - 60, height: 20))
        label.text = title
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        view.addSubview(label)
        return view
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return topics[section].title == nil ? 0 : 20
    }
}