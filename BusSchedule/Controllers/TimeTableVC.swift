//
//  TimeTableVC.swift
//  BusSchedule
//
//  Created by alisandagdelen on 10.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import UIKit

class TimeTableVC: UIViewController {
    
    @IBOutlet weak var tblTimeTableDetails: UITableView!
    var timeTableViewModel:TimeTableViewModelProtocol!
    
    private var dataSource: TableViewDataSourceWithSection<TCellTimeTableDetails, String, TimeTableDetails>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fillUI()
    }
    
    func setupUI() {
        self.navigationItem.title = timeTableViewModel.stationName
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let rightBarButtonImage = timeTableViewModel.selectedDateType.value == .departure ? #imageLiteral(resourceName: "departure") : #imageLiteral(resourceName: "arrival")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightBarButtonImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(changeDateType(_:)))
        
        tblTimeTableDetails.register(UINib(nibName: TCellTimeTableDetails.nibName, bundle: nil), forCellReuseIdentifier: TCellTimeTableDetails.nibName)
        tblTimeTableDetails.tableFooterView = UIView.init(frame: CGRect.zero)
        print(timeTableViewModel.selectedDateType.value)
    }
    
    func fillUI() {
        
        timeTableViewModel.timeTableDetails.bind { [unowned self] timeTableDetails in
            let dates = self.timeTableViewModel.dates
            self.dataSource = TableViewDataSourceWithSection<TCellTimeTableDetails, String, TimeTableDetails>(cellIdentifier: TCellTimeTableDetails.nibName, sections: dates, items: timeTableDetails, configureCell
                : { (cell, timeTableDetails) in
                    cell.lblHour.text = timeTableDetails.time?.hourFromTimeStampWithTimeZone
                    cell.lblRoute.text = timeTableDetails.briefRoute
                    cell.lblDirection.text = "Line \(timeTableDetails.lineNumber) direction \(timeTableDetails.direction)"
            }, configureSection: { (titleLabel:UILabel, date:String) in
                titleLabel.text = date
            })
            self.tblTimeTableDetails.dataSource = self.dataSource
            self.tblTimeTableDetails.reloadData()
        }
        
        timeTableViewModel.selectedDateType.bind { [unowned self] in
            self.navigationItem.rightBarButtonItem?.image = $0 == .departure ? #imageLiteral(resourceName: "departure") : #imageLiteral(resourceName: "arrival")
            print($0)
        }
    }
    
    @objc func changeDateType(_ sender:UIButton) {
        timeTableViewModel.changeDateType()
    }
}
