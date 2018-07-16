//
//  CustomCellTableViewController.swift
//  AppSpringboard
//
//  Created by Joseph Bergen on 7/16/18.
//  Copyright © 2018 Joseph Bergen. All rights reserved.
//

import UIKit

/**

 UITableViewController with custom UITableViewCell

 Instead of using UITableViewCell, we subclass it and create our own cell that knows how to draw itself.

 DOCS
 ====
 UITableViewController: https://developer.apple.com/documentation/uikit/uitableviewcontroller?changes=_6
 UITableViewDelegate: https://developer.apple.com/documentation/uikit/uitableviewdelegate?changes=_6
 UITableViewDataSource: https://developer.apple.com/documentation/uikit/uitableviewdatasource?changes=_6
 UITableViewCell: https://developer.apple.com/documentation/uikit/uitableviewcell?changes=_6

 **/

/**
 This subclass of UITableViewCell will draw a simple cell with two elements:
  • Name label that displays the text representation of the color
  • A color square that shows the color

 This cell class could live in its own file, but would need to be public (not private) to work
 **/
private class ColorCell: UITableViewCell {
    // To keep things safe, we create a static class variable to reference the reuse identifier
    static let reuseIdentifier = "color_cell"

    /**
     This is the data part of the cell and what the cell needs to property set itself up to display the data
    **/
    var color: Color? {
        /**
         didSet is a useful observer that triggers when the variable is set (after initialization)
         we use it here to update the UI elements in the cell with the latest data
        **/
        didSet {
            nameLabel.text = color?.name
            colorView.backgroundColor = color?.color()
        }
    }

    /**
     Making instances of the UI elements we need to be able to update.
     These are private because no other part of the code should know or care about them
    **/
    private let nameLabel = UILabel()
    private let colorView = UIView()

    /**
     In the init function we setup the basic views and add them to the view heirarchy

     note: we do not setup frame layouts here because the cell may not be properly sized at this point (prob not)
     note 2: you could setupt auto layout constraints here though
    **/
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.textColor = .darkGray
        contentView.addSubview(nameLabel) // in a cell, don't forget to add subviews to `contentView`
        colorView.layer.cornerRadius = 5
        contentView.addSubview(colorView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /**
     Use layoutSubviews to calculate your layout frames.

     note: DO NOT do anything more than layout here. This fxn gets called at key points and randomly too, a lot.
     note: if you use autolayout, you probably do not need to override this
    **/
    override func layoutSubviews() {
        let width = contentView.bounds.width - 40
        nameLabel.frame = CGRect(x: 20, y: 20, width: width, height: nameLabel.intrinsicContentSize.height)
        colorView.frame = CGRect(x: 20, y: nameLabel.frame.maxY + 10, width: width, height: width)
    }
}


class CustomCellTableViewController: UITableViewController {
    private var data = [Color]()

    convenience init() {
        self.init(style: .plain)
        title = "Custom Cell"

        /**
         register the cell type with the tableView. Here we're using the ColorCell class which takes a Color data object
         **/
        tableView.register(ColorCell.self, forCellReuseIdentifier: ColorCell.reuseIdentifier)

        data = DataStore.shared.colors
    }

    // MARK: UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    /**
     This function returns the instance of UITableViewCell that the table will show. Inside this function
     we pass in a data object from our data array to the cell, which will configure itself accordingly
     **/
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ColorCell.reuseIdentifier, for: indexPath)

        // Since `dequeReusableCell` returns a the base class UITableViewCell, we need to optionally cast it into our custom class
        if let cell = cell as? ColorCell {
            // Pass our data into the cell
            cell.color = data[indexPath.row]
        }

        // return the cell to be used by the tableView
        return cell
    }

    /**
     Here we've derived the height of the cell based on our layout. This could be more complex if the cell height was variable, for
     for our purposes, we can use a relatively simple calculation based on the width of our table
    **/
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.width + 30
    }
}
