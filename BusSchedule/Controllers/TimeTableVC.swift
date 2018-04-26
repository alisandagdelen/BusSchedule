//
//  TimeTableVC.swift
//  BusSchedule
//
//  Created by alisandagdelen on 10.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class TimeTableVC: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var tblTimeTableDetails: UITableView!
    var timeTableViewModel:TimeTableViewModelProtocol!
    let disposeBag = DisposeBag()
    
    // MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fillUI()
    }
    
    // MARK: UI Setup Methods
    
    func setupUI() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(), style: .plain, target: self, action: nil)
        
        self.navigationItem.title = timeTableViewModel.stationName
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        //        let backgroundQ = ConcurrentDispatchQueueScheduler(qos: .background)
        self.navigationItem.rightBarButtonItem?.rx.tap
            //            .observeOn(backgroundQ)
            .bind(onNext: { [unowned self] in
                self.timeTableViewModel.changeDateType()
            }).disposed(by: disposeBag)
        
        tblTimeTableDetails.register(UINib(nibName: TCellTimeTableDetails.nibName, bundle: nil), forCellReuseIdentifier: TCellTimeTableDetails.nibName)
        tblTimeTableDetails.tableFooterView = UIView.init(frame: CGRect.zero)
        tblTimeTableDetails.allowsSelection = false;
    }
    
    // MARK: Binding
    
    func fillUI() {
        
        timeTableViewModel.selectedDateType
            .distinctUntilChanged()
            .map { $0 == .departure ? #imageLiteral(resourceName: "departure") : #imageLiteral(resourceName: "arrival") }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] in
                self.navigationItem.rightBarButtonItem?.image = $0
            }).disposed(by: disposeBag)
        
        // TableView fill
        
        timeTableViewModel.timeTableDetails.asObservable()
            .bind(to: tblTimeTableDetails.rx.items(dataSource: configureDataSource()))
            .disposed(by: disposeBag)
    }
    
    // MARK: TableViewConfig
    
    func configureDataSource() -> RxTableViewSectionedReloadDataSource<SectionModel<String, TimeTableDetails>> {
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, TimeTableDetails>>(
            configureCell: { (_, tv, ip, timeTableDetails: TimeTableDetails) in
                let cell = tv.dequeueReusableCell(withIdentifier: TCellTimeTableDetails.nibName) as! TCellTimeTableDetails
                cell.lblHour.text = timeTableDetails.time?.hourFromTimeStampWithTimeZone
                cell.lblRoute.text = timeTableDetails.briefRoute
                cell.lblDirection.text = "Line \(timeTableDetails.lineNumber) direction \(timeTableDetails.direction)"
                
                return cell
        },
            titleForHeaderInSection: { dataSource, sectionIndex in
                return dataSource[sectionIndex].model
        })
        
        return dataSource
    }
}
