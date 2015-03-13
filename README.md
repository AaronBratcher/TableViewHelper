# TableViewHelper
Swift class to easily hide and show UITableView Rows

See the included sample for full usage.



##Usage##
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

Reference the helper class for most of the UITableView source and delegate calls:
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

Hide or show cells by name:
```swift
helper!.hideCell("S0R1")
helper!.hideCell("S1R0")
helper!.showCell("S1R0")
```



