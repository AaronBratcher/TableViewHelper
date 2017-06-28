//
//  ViewController.swift
//  Tester
//
//  Created by Aaron Bratcher on 10/02/2014.
//  Copyright (c) 2014 Aaron L. Bratcher. All rights reserved.
//

import UIKit
import TableViewHelper

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var helper:TableViewHelper!

    override func viewDidLoad() {
        helper = TableViewHelper(tableView:tableView)
        
        helper.addCell(section: 0, cell: tableView.dequeueReusableCell(withIdentifier: "S0R0")! as UITableViewCell, name: "S0R0")
        helper.addCell(section: 0, cell: tableView.dequeueReusableCell(withIdentifier: "S0R1")! as UITableViewCell, name: "S0R1", isInitiallyHidden: true)

        helper.addCell(section: 1, cell: tableView.dequeueReusableCell(withIdentifier: "S1R0")! as UITableViewCell, name: "S1R0", isInitiallyHidden: true)

        helper.addCell(section: 2, cell: tableView.dequeueReusableCell(withIdentifier: "S2R0")! as UITableViewCell, name: "S2R0")
        helper.addCell(section: 2, cell: tableView.dequeueReusableCell(withIdentifier: "S2R1")! as UITableViewCell, name: "S2R1")
        helper.addCell(section: 2, cell: tableView.dequeueReusableCell(withIdentifier: "S2R2")! as UITableViewCell, name: "S2R2")
		
		helper.addCell(section: 3, cell: tableView.dequeueReusableCell(withIdentifier: "S3R0")! as UITableViewCell, name: "S3R0")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        helper.hideInitiallyHiddenCells()
        
        let count = helper.numberOfSections()
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return helper.numberOfRows(in: section)
    }
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if (indexPath as NSIndexPath).section == 0 && (indexPath as NSIndexPath).row == 1 {
			return 193
		}
		
		return tableView.rowHeight
	}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return helper.cellForRow(at: indexPath)
    }
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
        if let name = helper.cellName(at: indexPath) {
			switch name {
			case "S0R0":
				if !helper.cellIsVisible("S0R1") {
					helper?.showCell("S0R1")
				} else {
					helper?.hideCell("S0R1")
				}

			case "S0R1":
				helper?.hideCell(name)

			case "S1R0":
				helper?.showCell("S2R0")
				helper?.showCell("S2R1")
				helper?.showCell("S2R2")
				helper?.hideCell(name)
				
			case "S3R0":
				break

			default:
				helper.hideCell(name)
				helper.showCell("S1R0")
			}

			if name != "S0R0" {
				helper?.hideCell("S0R1")
			}
		}
	}
    
    
    @IBAction func showHideCell(_ sender: AnyObject) {
        let button = sender as! UIButton
        let label = button.titleLabel!
        let title = label.text!
        
        if helper.cellIsVisible(title) {
            helper.hideCell(title)
        } else {
            helper.showCell(title)
        }
    }
    
}

