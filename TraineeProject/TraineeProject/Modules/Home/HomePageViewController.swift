//
//  HomePageViewController.swift
//  TraineeProject
//
//  Created by TTN on 02/05/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {
    
    @IBOutlet weak var homePageTableView: UITableView!
    let homeVM = HomeViewModel()
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchHomeScreenData), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        homePageTableView.addSubview(self.refreshControl)
        homePageTableView.register(CustomTableViewCell.nib(), forCellReuseIdentifier: CustomTableViewCell.identifier)
        homePageTableView.register(BannerTableViewCell.nib(), forCellReuseIdentifier: BannerTableViewCell.identifier)
        homePageTableView.delegate = self
        homePageTableView.dataSource = self
        homePageTableView.estimatedRowHeight = UITableView.automaticDimension
        homePageTableView.rowHeight = UITableView.automaticDimension
        fetchHomeScreenData()
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = Theme.current.background
        homePageTableView.backgroundColor = Theme.current.background
    }
    
    @objc func fetchHomeScreenData(){
        homeVM.fetchHomeApiData { (success, message) in
            self.refreshControl.endRefreshing()
            if success {
                self.homePageTableView.reloadData()
            } else {
                print(message)
            }
        }
    }

   
}

extension HomePageViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        homeVM.homeApiData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = homePageTableView.dequeueReusableCell(withIdentifier: BannerTableViewCell.identifier, for: indexPath) as! BannerTableViewCell
            cell.configure(homeVM.homeApiData[indexPath.row])
            return cell
        } else {
            let cell = homePageTableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
            cell.configure(homeVM.homeApiData[indexPath.row])
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return homePageTableView.frame.width * (9/16)
        } else {
            return UITableView.automaticDimension
        }
    }
    
}
