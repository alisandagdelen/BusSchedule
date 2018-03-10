//
//  ViewController.swift
//  BusSchedule
//
//  Created by alisandagdelen on 10.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import UIKit

class StationsVC: UIViewController {

    @IBOutlet weak var tblStations: UITableView!
    
    private var dataSource: TableViewDataSourceWithSection<UITableViewCell, Country, City>!
    var stationsViewModel: StationsViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        stationsViewModel = StationsViewModel()
        fillUI()
    }
    
    func setupUI() {
        tblStations.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tblStations.tableFooterView = UIView.init(frame: CGRect.zero)
        tblStations.delegate = self
    }
    
    func fillUI() {
        self.dataSource = TableViewDataSourceWithSection<UITableViewCell, Country, City>(cellIdentifier: "cell", sections: stationsViewModel.countries, items: stationsViewModel.stations, configureCell: { (cell, stationsName) in
            cell.textLabel?.text = stationsName.description
        }, configureSection: { (titleLabel, country) in
            titleLabel.text = country.description
        })
        tblStations.dataSource = dataSource
        tblStations.reloadData()
    }
    
    func presentTimeTableVC(city:City, dataService:BusScheduleApi = BusScheduleService.sharedInstance) {
        
        let timeTableVC = self.storyboard!.instantiateViewController(withIdentifier: String(describing: TimeTableVC.self)) as! TimeTableVC
        timeTableVC.timeTableViewModel = TimeTableViewModel(city: city, dataService: dataService, dateType: .departure)
        self.navigationController?.pushViewController(timeTableVC, animated: true)
    }
}

extension StationsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblStations.deselectRow(at: indexPath, animated: false)
        let selectedCountry = stationsViewModel.countries[indexPath.section]
        guard let stations = stationsViewModel.stations[selectedCountry] else { return }
        let selectedCity = stations[indexPath.row]
        presentTimeTableVC(city: selectedCity)
    }
}

