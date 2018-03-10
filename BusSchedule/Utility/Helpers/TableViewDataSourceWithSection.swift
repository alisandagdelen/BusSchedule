//
//  TableViewDataSourceWithSection.swift
//  BusSchedule
//
//  Created by alisandagdelen on 10.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//


import UIKit

class TableViewDataSourceWithSection<CellType: UITableViewCell, Section:Hashable, Model>: NSObject, UITableViewDataSource {
    
    typealias configureCellClosure = (CellType,Model) -> ()
    typealias configureSectionClosure = (UILabel,Section) -> ()
    
    var cellIdentifier: String!
    var items: [Section:[Model]]!
    var sections: [Section]!
    var configureCell: configureCellClosure
    var configureSection: configureSectionClosure
    
    init(cellIdentifier: String, sections: [Section], items: [Section:[Model]], configureCell: @escaping configureCellClosure, configureSection: @escaping configureSectionClosure) {
        self.configureSection = configureSection
        self.configureCell = configureCell
        super.init()
        
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.sections = sections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let itemsInSection = self.items[sections[section]] else { return 0 }
        return itemsInSection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? CellType else { return UITableViewCell() }
        guard let section = self.items[sections[indexPath.section]] else { return cell }
        let object = section[indexPath.row]
        configureCell(cell, object)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let titleLabel = UILabel()
        let section = self.sections[section]
        configureSection(titleLabel, section)
        return titleLabel.text
    }
}
