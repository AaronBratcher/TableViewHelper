//
//  DynamicTableView.swift
//  My Money
//
//  Created by Aaron Bratcher on 9/26/14.
//  Copyright (c) 2014 Aaron L. Bratcher. All rights reserved.
//

import Foundation
import UIKit

public struct TableViewHelper {
    var tableView:UITableView
    
	public init(tableView:UITableView) {
        self.tableView = tableView
    }
    
	public mutating func addCell(_ section:Int, cell:UITableViewCell, name:String) {
        let newCell = Cell(section: section, name: name, tableViewCell: cell)
        cells.append(newCell)
        var indexPath:IndexPath
        
        if let count = cellCount[section] {
            cellCount[section] = count+1
            indexPath = IndexPath(row: count, section: section)
        } else {
            cellCount[section] = 1
            indexPath = IndexPath(row: 0, section: section)
        }
        
        indexedCells[indexPath] = newCell
    }
    
	public mutating func hideCell(_ name:String) {
        var removePaths = [IndexPath]()
        let removeSections = NSMutableIndexSet()
        
        for section in 0..<numberOfSections() {
            for row in 0..<numberOfRowsInSection(section) {
                let indexPath = IndexPath(row: row, section: section)
                let cell = indexedCells[indexPath]!
                if cell.name == name && cell.visible {
                    cell.visible = false
                    removePaths.append(indexPath)
                    cellCount[section] = cellCount[section]! - 1
                    if cellCount[section] == 0 {
                        removeSections.add(section)
                    }
                }
            }
        }
        
        recalcIndexedCells()
        
        if removeSections.count == 0 {
            tableView.deleteRows(at: removePaths, with: .top)
        } else {
            tableView.deleteSections(removeSections as IndexSet, with: .top)
        }
    }
    
	public mutating func showCell(_ name:String) {
        var addPaths = [IndexPath]()
        var cellSection = 0
        var section = 0
        var row = 0
        for cell in cells {
            if cellSection != cell.section {
                cellSection = cell.section
                if row > 0 {
                    section += 1
                }
                row = 0
            }
            
            if cell.visible {
                row += 1
            } else {
                if cell.name == name {
                    let indexPath = IndexPath(row: row, section: section)
                    cell.visible = true
                    addPaths.append(indexPath)
                }
            }
        }
        
        let initialCount = numberOfSections()
        recalcIndexedCells()
        
        if initialCount == numberOfSections() {
            tableView.insertRows(at: addPaths, with: .top)
        } else {
            tableView.reloadData()
        }
    }
    
	public func cellNameAtIndexPath(_ indexPath:IndexPath) -> String? {
        for path in indexedCells.keys {
            if (path as NSIndexPath).section == (indexPath as NSIndexPath).section && (path as NSIndexPath).row == (indexPath as NSIndexPath).row {
              return indexedCells[path]!.name
            }
        }
        
        return nil
    }
    
    public func indexPathForCellNamed(_ name:String) -> IndexPath? {
        for path in indexedCells.keys {
            let cell = indexedCells[path]!
            if cell.name == name {
                return path
            }
        }
        
        return nil
    }
	
	public func indexPathsForCellNamed(_ name:String) -> [IndexPath] {
		var paths = [IndexPath]()
		for path in indexedCells.keys {
			let cell = indexedCells[path]!
			if cell.name == name {
				paths.append(path)
			}
		}
		
		return paths
	}
	
    public func visibleCellsWithName(_ name:String) -> [UITableViewCell] {
        var matchingCells = [UITableViewCell]()
        for cell in cells {
            if cell.name == name && cell.visible {
                matchingCells.append(cell.tableViewCell)
            }
        }
        
        return matchingCells
    }
    
    /// returns true if ALL cells with that name are visible
    public func cellIsVisible(_ name:String) -> Bool {
        var visible = true
        for cell in cells {
            if cell.name == name && !cell.visible {
                visible = false
                break
            }
        }
        
        return visible
    }
    
    
    public func numberOfSections() -> Int {
        var count = 0
        
        for section in cellCount.keys {
            if cellCount[section]! > 0 {
                count += 1
            }
        }
        
        return count
    }
    
    public func numberOfRowsInSection(_ section: Int) -> Int {
        if let count = cellCount[section] {
            return count
        } else {
            return 0
        }
    }
    
    public func cellForRowAtIndexPath(_ indexPath: IndexPath) -> UITableViewCell {
        var cell:Cell?
        for path in indexedCells.keys {
            if (path as NSIndexPath).section == (indexPath as NSIndexPath).section && (path as NSIndexPath).row == (indexPath as NSIndexPath).row {
                cell = indexedCells[path]
                break
            }
        }

        return cell!.tableViewCell
    }
    
    fileprivate class Cell {
        var section:Int
        var name:String
        var tableViewCell:UITableViewCell
        var visible = true
        
        init(section:Int, name:String, tableViewCell:UITableViewCell) {
            self.section = section
            self.name = name
            self.tableViewCell = tableViewCell
        }
    }
    
    fileprivate var cells = [Cell]()
    fileprivate var indexedCells = [IndexPath:Cell]()
    fileprivate var cellCount = [Int:Int]()
    
    fileprivate mutating func recalcIndexedCells() {
        var index = 0
        var section = 0
        var cellSection = 0
        indexedCells = [IndexPath:Cell]();
        cellCount = [Int:Int]()
        for cell in cells {
            if cell.section != cellSection {
                if index > 0 {
                    cellCount[section] = index
                    section += 1
                }
                cellSection = cell.section
                index = 0
            }
            
            if cell.visible {
                let indexPath = IndexPath(row: index, section: section)
                indexedCells[indexPath] = cell
                index += 1
            }
        }
        
        cellCount[section] = index
    }

}
