//
//  DynamicTableView.swift
//  My Money
//
//  Created by Aaron Bratcher on 9/26/14.
//  Copyright (c) 2014 Aaron L. Bratcher. All rights reserved.
//

import Foundation
import UIKit


class TableViewHelper {
    var tableView:UITableView
    
    init(tableView:UITableView) {
        self.tableView = tableView
    }
    
    func addCell(section:Int, cell:UITableViewCell, name:String) {
        let newCell = Cell(section: section, name: name, tableViewCell: cell)
        cells.append(newCell)
        var indexPath:NSIndexPath
        
        if let count = cellCount[section] {
            cellCount[section] = count+1
            indexPath = NSIndexPath(forRow: count, inSection: section)
        } else {
            cellCount[section] = 1
            indexPath = NSIndexPath(forRow: 0, inSection: section)
        }
        
        indexedCells[indexPath] = newCell
    }
    
    
    func hideCell(name:String) {
        var removePaths = [NSIndexPath]()
        var removeSections = NSMutableIndexSet()
        
        for section in 0..<numberOfSections() {
            for row in 0..<numberOfRowsInSection(section) {
                let indexPath = NSIndexPath(forRow: row, inSection: section)
                let cell = indexedCells[indexPath]!
                if cell.name == name && cell.visible {
                    cell.visible = false
                    removePaths.append(indexPath)
                    cellCount[section] = cellCount[section]! - 1
                    if cellCount[section] == 0 {
                        removeSections.addIndex(section)
                    }
                }
            }
        }
        
        recalcIndexedCells()
        
        if removeSections.count == 0 {
            tableView.deleteRowsAtIndexPaths(removePaths, withRowAnimation: .Top)
        } else {
            tableView.deleteSections(removeSections, withRowAnimation: .Top)
        }
    }
    
    func showCell(name:String) {
        var addPaths = [NSIndexPath]()
        var cellSection = 0
        var section = 0
        var row = 0
        for cell in cells {
            if cellSection != cell.section {
                cellSection = cell.section
                if row > 0 {
                    section++
                }
                row = 0
            }
            
            if cell.visible {
                row++
            } else {
                if cell.name == name {
                    let indexPath = NSIndexPath(forRow: row, inSection: section)
                    cell.visible = true
                    addPaths.append(indexPath)
                }
            }
        }
        
        let initialCount = numberOfSections()
        recalcIndexedCells()
        
        if initialCount == numberOfSections() {
            tableView.insertRowsAtIndexPaths(addPaths, withRowAnimation: .Top)
        } else {
            tableView.reloadData()
        }
    }
    
    func cellNameAtIndexPath(indexPath:NSIndexPath) -> String? {
        for path in indexedCells.keys {
            if path.section == indexPath.section && path.row == indexPath.row {
              return indexedCells[path]!.name
            }
        }
        
        return nil
    }
    
    func indexPathForCellNamed(name:String) -> NSIndexPath? {
        for path in indexedCells.keys {
            let cell = indexedCells[path]!
            if cell.name == name {
                return path
            }
        }
        
        return nil
    }
    
    func visibleCellsWithName(name:String) -> [UITableViewCell] {
        var matchingCells = [UITableViewCell]()
        for cell in cells {
            if cell.name == name {
                matchingCells.append(cell.tableViewCell)
            }
        }
        
        return matchingCells
    }
    
    /// returns true if ALL cells with that name are visible
    func cellIsVisible(name:String) -> Bool {
        var visible = true
        for cell in cells {
            if cell.name == name && !cell.visible {
                visible = false
                break
            }
        }
        
        return visible
    }
    
    
    func numberOfSections() -> Int {
        var count = 0
        
        for section in cellCount.keys {
            if cellCount[section] > 0 {
                count++
            }
        }
        
        return count
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if let count = cellCount[section] {
            return count
        } else {
            return 0
        }
    }
    
    func cellForRowAtIndexPath(indexPath: NSIndexPath) -> UITableViewCell {
        var cell:Cell?
        for path in indexedCells.keys {
            if path.section == indexPath.section && path.row == indexPath.row {
                cell = indexedCells[path]
                break
            }
        }

        return cell!.tableViewCell
    }
    
    private class Cell {
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
    
    private var cells = [Cell]()
    private var indexedCells = [NSIndexPath:Cell]()
    private var cellCount = [Int:Int]()
    
    private func recalcIndexedCells() {
        var index = 0
        var section = 0
        var cellSection = 0
        indexedCells = [NSIndexPath:Cell]();
        cellCount = [Int:Int]()
        for cell in cells {
            if cell.section != cellSection {
                if index > 0 {
                    cellCount[section] = index
                    section++
                }
                cellSection = cell.section
                index = 0
            }
            
            if cell.visible {
                let indexPath = NSIndexPath(forRow: index, inSection: section)
                indexedCells[indexPath] = cell
                index++
            }
        }
        
        cellCount[section] = index
    }

}