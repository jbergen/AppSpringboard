//
//  GroupedTableViewController.swift
//  AppSpringboard
//
//  Created by Joseph Bergen on 7/14/18.
//  Copyright © 2018 Joseph Bergen. All rights reserved.
//

import UIKit

class GroupedTableViewController: UITableViewController {
    private var data = [String]()

    convenience init() {
        self.init(style: .grouped)
        title = "Grouped Table"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "REUSE")
        data = DataStore.shared.dataArray(count: 50)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "REUSE", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
}
