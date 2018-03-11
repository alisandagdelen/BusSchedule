//
//  ViewController.swift
//  BusSchedule
//
//  Created by alisandagdelen on 10.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import UIKit

class StationsVC: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var tblStations: UITableView!
    
    private var dataSource: TableViewDataSourceWithSection<UITableViewCell, Country, City>!
    var stationsViewModel: StationsViewModelProtocol!
    
    // MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if stationsViewModel == nil {
            stationsViewModel = StationsViewModel()
        }
        setupUI()
        fillUI()
    }
    
    // MARK: UI Setup Methods
    
    func setupUI() {
        tblStations.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tblStations.tableFooterView = UIView.init(frame: CGRect.zero)
        tblStations.delegate = self
    }
    
    // MARK: Binding
    
    func fillUI() {
        // TableView fill
        self.dataSource = TableViewDataSourceWithSection<UITableViewCell, Country, City>(cellIdentifier: "cell", sections: stationsViewModel.countries, items: stationsViewModel.stations, configureCell: { (cell, stationsName) in
            cell.textLabel?.text = stationsName.description
        }, configureSection: { (titleLabel, country) in
            titleLabel.text = country.description
        })
        tblStations.dataSource = dataSource
        tblStations.reloadData()
    }
    
    // MARK: Navigation Methods
    
    func presentTimeTableVC(city:City, dataService:BusScheduleApi = BusScheduleService.sharedInstance) {
        
        let timeTableVC = self.storyboard!.instantiateViewController(withIdentifier: String(describing: TimeTableVC.self)) as! TimeTableVC
        timeTableVC.timeTableViewModel = TimeTableViewModel(city: city, dataService: dataService, dateType: .departure)
        self.navigationController?.pushViewController(timeTableVC, animated: true)
    }
}

// MARK: TableView delegate Methods

extension StationsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblStations.deselectRow(at: indexPath, animated: false)
        let selectedCountry = stationsViewModel.countries[indexPath.section]
        guard let stations = stationsViewModel.stations[selectedCountry] else { return }
        let selectedCity = stations[indexPath.row]
        presentTimeTableVC(city: selectedCity)
    }
}

