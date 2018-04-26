//
//  ViewController.swift
//  BusSchedule
//
//  Created by alisandagdelen on 10.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class StationsVC: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var tblStations: UITableView!
    
    private var dataSource: TableViewDataSourceWithSection<UITableViewCell, Country, City>!
    var stationsViewModel: StationsViewModelProtocol!
    let disposeBag = DisposeBag()
    
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
    }
    
    // MARK: Binding
    
    func fillUI() {
        // TableView fill
        
        stationsViewModel.stations.asObservable()
            .bind(to: tblStations.rx.items(dataSource: configureDataSource()))
            .disposed(by: disposeBag)
        
        // TableView didSelect rx solution
        
        tblStations.rx.itemSelected
            .map { [unowned self] indexPath in
                return (indexPath, self.stationsViewModel.stations.value[indexPath.section].items[indexPath.row])
            }
            .subscribe(onNext: { [unowned self] (indexPath, selectedCity) in
                self.tblStations.deselectRow(at: indexPath, animated: false)
                self.presentTimeTableVC(city: selectedCity)
            }).disposed(by: disposeBag)
        
        //        tblStations.rx.modelSelected(City.self)
        //            .subscribe(onNext: { [unowned self] (selectedCity) in
        //                print(selectedCity)
        //                self.presentTimeTableVC(city: selectedCity)
        //            }).disposed(by: disposeBag)
    }
    
    // MARK: Navigation Methods
    
    func presentTimeTableVC(city:City, dataService:BusScheduleApi = BusScheduleService.sharedInstance) {
        
        let timeTableVC = self.storyboard!.instantiateViewController(withIdentifier: String(describing: TimeTableVC.self)) as! TimeTableVC
        timeTableVC.timeTableViewModel = TimeTableViewModel(city: city, dataService: dataService, dateType: .departure)
        self.navigationController?.pushViewController(timeTableVC, animated: true)
    }
    
    // TableView Configure
    
    func configureDataSource() -> RxTableViewSectionedReloadDataSource<SectionModel<String, City>> {
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, City>>(
            configureCell: { (_, tv, ip, stationsName: City) in
                let cell = tv.dequeueReusableCell(withIdentifier: "cell")!
                cell.textLabel?.text = stationsName.description
                return cell
        },
            titleForHeaderInSection: { dataSource, sectionIndex in
                return dataSource[sectionIndex].model
        })
        
        return dataSource
    }
}
