# TableViewHelper
Swift class to dynamically hide and show UITableView Rows.

See the included sample app.


##Basics##
Instantiate a copy of the class with a reference to the tableView:
```swift
helper = TableViewHelper(tableView:tableView)
```

Add all possible cells to the helper giving each a name (multiple cells can have the same name):
```swift
helper!.addCell(0, cell: tableView.dequeueReusableCellWithIdentifier("S0R0")! as UITableViewCell, name: "S0R0")
helper!.addCell(0, cell: tableView.dequeueReusableCellWithIdentifier("S0R1")! as UITableViewCell, name: "S0R1")

helper!.addCell(1, cell: tableView.dequeueReusableCellWithIdentifier("S1R0")! as UITableViewCell, name: "S1R0")
```

Reference the helper class for relevant UITableView source and delegate calls:
```swift
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
```

Hide or show cells by name (if multiple cells have the same name, then all with that name are shown or hidden):
```swift
helper!.hideCell("S0R1")
helper!.hideCell("S1R0")
helper!.showCell("S1R0")
```

##All public methods##
```swift
init(tableView:UITableView)
func addCell(section:Int, cell:UITableViewCell, name:String)

func hideCell(name:String)
func showCell(name:String)

func cellNameAtIndexPath(indexPath:NSIndexPath) -> String?
func indexPathForCellNamed(name:String) -> NSIndexPath? // first matching cell
func indexPathsForCellNamed(name:String) -> [NSIndexPath]
func visibleCellsWithName(name:String) -> [UITableViewCell]
func cellIsVisible(name:String) -> Bool // // returns true if ALL cells with that name are visible

func numberOfSections() -> Int
func numberOfRowsInSection(section: Int) -> Int
func cellForRowAtIndexPath(indexPath: NSIndexPath) -> UITableViewCell
```