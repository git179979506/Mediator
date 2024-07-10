//
//  PortfolioStatusViewModel.swift
//  Portfolio
//
//  Created by zhaoshouwen on 2024/7/9.
//

import Foundation
import Base
import Mediator
import PortfolioInterface

/// 自选逻辑简单封装，不考虑网络请求，实际业务开发中逻辑更复杂
class PortfolioStatusViewModel: OTPortfolioStatusVM {
    let code: String
    // 使用回调代替数据绑定
    var updateCallback: OneParamTask<Bool>?
    var isExist = false
    
    private var observer: NSObjectProtocol?
    
    init(code: String) {
        self.code = code
        self.isExist = Mediator.shared().portfolio_isExist(code: code)
        
        observer = NotificationCenter.default.addObserver(
            forName: .portfolioStatusDidChanged,
            object: code,
            queue: .main
        ) { [weak self] notif in
            guard let self = self else { return }
            if let userInfo = notif.userInfo,
               let code = userInfo[kPortfolioStatusCode] as? String,
                self.code == code,
                let value = userInfo[kPortfolioStatusValue] as? Bool,
                self.isExist != value {
                
                self.isExist = value
                self.updateCallback?(value)
            }
        }
    }
    
    func update() {
        self.isExist = Mediator.shared().portfolio_isExist(code: code)
    }
    
    func toggle() {
        if isExist {
            remove()
        } else {
            add()
        }
    }
    
    func add() {
        Mediator.shared().portfolio_add(code: code, notif: false) { [weak self] in
            guard let self = self else { return }
            self.isExist = true
            updateCallback?(true)
            Mediator.shared().portfolio_postStatusDidChangedNotification(code: self.code, value: true)
        }
    }
    
    func remove() {
        Mediator.shared().portfolio_remove(code: code, notif: false) { [weak self] in
            guard let self = self else { return }
            self.isExist = false
            updateCallback?(false)
            Mediator.shared().portfolio_postStatusDidChangedNotification(code: self.code, value: false)
        }
    }
    
    deinit {
        if let observer = observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }
}
