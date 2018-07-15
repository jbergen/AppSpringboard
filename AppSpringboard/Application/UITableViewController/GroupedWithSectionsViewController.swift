//
//  GroupedWithSectionsViewController.swift
//  AppSpringboard
//
//  Created by Joseph Bergen on 7/14/18.
//  Copyright © 2018 Joseph Bergen. All rights reserved.
//

import UIKit

/**

 Grouped UITableViewController *WITH SECTIONS*

 View Controller that is good for displaying a lists of data.

 `grouped` essentially means that the section headers are gray bars that look different from the cells
 and scroll with the table view. See "SETTIGNS" app.

 DOCS
 ====
 UITableViewController: https://developer.apple.com/documentation/uikit/uitableviewcontroller?changes=_6
 UITableViewDelegate: https://developer.apple.com/documentation/uikit/uitableviewdelegate?changes=_6
 UITableViewDataSource: https://developer.apple.com/documentation/uikit/uitableviewdatasource?changes=_6
 UITableViewCell: https://developer.apple.com/documentation/uikit/uitableviewcell?changes=_6

 **/

class GroupedWithSectionsViewController: UITableViewController {

    // The array of data that the table will refer to when rendering the table and cells
    private var data = [[String]]()

    // This convenience init function allows us to set the style to `.plain` without having
    convenience init() {
        // because we're using a convenience init fxn, we need to call a required init function
        self.init(style: .grouped)
        title = "Grouped Table"

        /**
         register the cell type with the tableView. Here we're using the base class & a string which is ok if
         you're not doing anything a little more than adding text and default cell features
         **/
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "REUSE")

        // we set the data array to a randomized arrays of strings from the data store
        let sec1 = DataStore.shared.dataArray(count: 10)
        let sec2 = DataStore.shared.dataArray(count: 3)
        let sec3 = DataStore.shared.dataArray(count: 15)
        data = [sec1, sec2, sec3]
    }


    // MARK: UITableViewDataSource

    /**
     The following functions belong to the Data Source. Information that the tableview needs to render
     itself is provided in these functions.
     **/

    /**
     This function return the number of sections in the table. it must be at least 1 for anything to appear.
     In general a section is just a collection of like items. Here we've set it to `1` because we're only
     creating one data array
     **/
    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }

    /**
     This function returns the number of rows in each section. Because our data is only one array of strings
     we can simply return the number of items contained in the array.
     **/
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }

    /**
     This function returns the instance of UITableViewCell that the table will show. Inside this function
     you will need to modify the cell in some way (pass in data or set the title).
     **/
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /**
         Because the table may have thousands of rows to display, it saves memory by only creating as many cell instances
         as can be shown on the screen at any one time. When a cell goes off screen, it goes into a sort of recycling bin
         where it awaits to be used again. When another cell comes into view, the table view will look for an unused cell
         this recycling bin, and if it can't find one, then it will create a new one. This process is `dequeueing`
         **/
        let cell = tableView.dequeueReusableCell(withIdentifier: "REUSE", for: indexPath)

        // We set the cell's default `textLabel` to show the string contained within our data array
        cell.textLabel?.text = data[indexPath.section][indexPath.row]

        // return the cell to be used by the tableView
        return cell
    }

    /**
     This function returns a view that is used as the head for the section. It's entirely possible that a section
     might not need a head view or also that it might need other views/ui inside it.
     **/
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 40)
        label.text = "Section \(section)"
        return label
    }

    /**
     Return the height of the header view in this function for it to be sized correctly
     **/
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
