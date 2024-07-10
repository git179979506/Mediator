//
//  PortfolioListViewController.swift
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

public class PortfolioListViewController: UIViewController {
    
    var items: [FundModel] = []

    public override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    func configureSubviews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func loadData() {
        tableView.ps.item = PSLabelItem.empty(text: "加载中...")
            .config { item in
                item.layoutOffset = CGPoint(x: 0, y: -150)
            }
        _loadData { [ weak self] models in
            self?.items = models
            if models.isEmpty == true {
                self?.tableView.ps.item = SimpleEmptyView(.noContent)
            } else {
                self?.tableView.ps.item = nil
            }
            
            self?.tableView.reloadData()
        }
    }
    
    // 模拟请求自选数据
    func _loadData(callback: @escaping OneParamTask<[FundModel]>) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let funds = getFundList()
            var dict: [String: FundModel] = [:]
            for fund in funds {
                dict[fund.code] = fund
            }
            callback(PortfolioUserDefaults.codes.compactMap { return dict[$0] })
        }
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

extension PortfolioListViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.ns.dequeueCell(UITableViewCell.self, for: indexPath)
        if let item = items[safe: indexPath.row] {
            cell.selectionStyle = .none
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = "\(item.name) - \(item.code)"
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
