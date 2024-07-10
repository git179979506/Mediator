//
//  HomeViewController.swift
//  TableViewSections_Example
//
//  Created by zhaoshouwen on 2024/6/22.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import PageState
import SnapKit
import Base
import PlanInterface

public class HomeViewController: UIViewController {
    
    var items: [FundModel] = []

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        items = getFundList()
        tableView.reloadData()
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        tableView.sectionHeaderHeight = .leastNonzeroMagnitude
        tableView.sectionFooterHeight = .leastNonzeroMagnitude
        tableView.rowHeight = 60
        return tableView
    }()
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.ns.dequeueCell(UITableViewCell.self, for: indexPath)
        if let item = items[safe: indexPath.row] {
            cell.selectionStyle = .none
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = "\(item.name) - \(item.code) - \(item.type)"
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = items[safe: indexPath.row], let planType = item.planType {
            if let vc = MTPlanRoutable?.planDetail(code: item.code, type: planType) {
                vc.hidesBottomBarWhenPushed = true
                vc.navigationItem.title = "\(item.name) - \(item.code)"
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

extension FundModel {
    var planType: PlanType? {
        switch type {
        case "plan1":
            return .type1
        case "plan2":
            return .type2
        default:
            return nil
        }
    }
}
