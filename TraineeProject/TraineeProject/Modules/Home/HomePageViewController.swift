//
//  HomePageViewController.swift
//  TraineeProject
//
//  Created by TTN on 02/05/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit

@IBOutlet weak var homePageTableView: UITableView!
    let homeVM = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        homePageTableView.register(CustomTableViewCell.nib(), forCellReuseIdentifier: CustomTableViewCell.identifier)
        homePageTableView.delegate = self
        homePageTableView.dataSource = self
        fetchHomeScreenData()
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = Theme.current.background
        homePageTableView.backgroundColor = Theme.current.background
    }
    
    func fetchHomeScreenData(){
        homeVM.fetchHomeApiData { (success, message) in
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
        let cell = homePageTableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        cell.configure(homeVM.homeApiData[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 310.0
    }
    
}

