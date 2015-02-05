//
//  ViewController.swift
//  Tester
//
//  Created by Aaron Bratcher on 10/02/2014.
//  Copyright (c) 2014 Aaron L. Bratcher. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var helper:TableViewHelper?

    override func viewDidLoad() {
        helper = TableViewHelper(tableView:tableView)
        
        helper!.addCell(0, cell: tableView.dequeueReusableCellWithIdentifier("S0R0")! as UITableViewCell, name: "S0R0")
        helper!.addCell(0, cell: tableView.dequeueReusableCellWithIdentifier("S0R1")! as UITableViewCell, name: "S0R1")

		helper!.addCell(1, cell: tableView.dequeueReusableCellWithIdentifier("S1R0")! as UITableViewCell, name: "S1R0")

        helper!.addCell(2, cell: tableView.dequeueReusableCellWithIdentifier("S2R0")! as UITableViewCell, name: "S2R0")
        helper!.addCell(2, cell: tableView.dequeueReusableCellWithIdentifier("S2R1")! as UITableViewCell, name: "S2R1")
        helper!.addCell(2, cell: tableView.dequeueReusableCellWithIdentifier("S2R2")! as UITableViewCell, name: "S2R2")
		
		helper!.addCell(3, cell: tableView.dequeueReusableCellWithIdentifier("S3R0")! as UITableViewCell, name: "S3R0")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let count = helper!.numberOfSections()
        return count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return helper!.numberOfRowsInSection(section)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return helper!.cellForRowAtIndexPath(indexPath)
    }
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
		
		if let name = helper!.cellNameAtIndexPath(indexPath) {
			switch name {
			case "S0R0":
				if !helper!.cellIsVisible("S0R1") {
					helper?.showCell("S0R1")
				}

			case "S0R1":
				helper?.hideCell(name)

			case "S1R0":
				helper?.showCell("S2R0")
				helper?.showCell("S2R1")
				helper?.showCell("S2R2")
				
			case "S3R0":
				break

			default:
				helper!.hideCell(name)
			}
		}
	}
    
    
    @IBAction func showHideCell(sender: AnyObject) {
        let button = sender as UIButton
        let label = button.titleLabel!
        let title = label.text!
        
        if helper!.cellIsVisible(title) {
            helper!.hideCell(title)
        } else {
            helper!.showCell(title)
        }
    }
    
}

