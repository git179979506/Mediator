//
//  PlanType1ViewController.swift
//  TableViewSections_Example
//
//  Created by zhaoshouwen on 2024/6/22.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import PageState
import Base
import PortfolioInterface

class PlanType1ViewController: UIViewController {
    
    let code: String
    lazy var viewModel = PlanType1TableVM(code: code)
    
    init(code: String) {
        self.code = code
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureBottomView()
        loadData()
    }
    
    func configureBottomView() {
        let portfolioStatusVM = MTPortfolioTool?.portfolio_getStatusVM(code: code)
        portfolioStatusVM.map(bottomView.update)
    }
    
    func configureSubviews() {
        view.backgroundColor = .groupTableViewBackground
        
        // 放在 tableView 下面，作为背景
        view.addSubview(topBgView)
        topBgView.snp.makeConstraints {
            $0.top.leading.width.equalToSuperview()
            $0.height.equalTo(230)
        }
        
        view.addSubview(bottomView)
        view.addSubview(tableView)
        // tableView 不是根视图，需要自己处理内容填充，不然会产生奇怪的问题
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        bottomView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func loadData() {
        tableView.ps.item = PSLabelItem.empty(text: "加载中...")
            .config { item in
                item.layoutOffset = CGPoint(x: 0, y: -150)
            }
        topBgView.isHidden = true
        viewModel.loadData { [weak tableView, weak topBgView] error in
            topBgView?.isHidden = false
            tableView?.ps.item = nil
        }
    }
    
    // 响应 safeAreaInsets 变更，调整 tableView.contentInset
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        print(view.safeAreaInsets)
        tableView.contentInset = UIEdgeInsets(top: view.safeAreaInsets.top, left: 0, bottom: 0, right: 0)
    }
    
    // MARK: - Subview
    // 定义顶部背景视图
    private let topBgView = UIView().ns.config{
        $0.backgroundColor = .orange
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        viewModel.associateTableView(tableView, viewController: self, additional: nil)
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.sectionHeaderHeight = 12
        tableView.sectionFooterHeight = .leastNonzeroMagnitude
        // 背景色设置为头没，避免遮挡 topBgView
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    let bottomView = BottomView()
}

// 遵守 PullDownStretchable 协议
extension PlanType1ViewController: PullDownStretchable {
    // 返回可拉伸的view
    var stretchableView: UIView {
        return topBgView
    }
}
