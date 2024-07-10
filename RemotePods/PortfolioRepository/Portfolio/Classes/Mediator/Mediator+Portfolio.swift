//
//  Mediator+Portfolio.swift
//  Portfolio
//
//  Created by zhaoshouwen on 2024/7/8.
//

import Foundation
import Mediator
import PortfolioInterface
import Base

// 简单模拟自选相关逻辑
extension Mediator: MTPortfolioToolProtocol {
    /// 查询是否已加自选，正常是调用后端接口
    public func portfolio_isExist(code: String) -> Bool {
        return PortfolioUserDefaults.codes.contains(code)
    }
    
    /// 加自选，正常是调用后端接口
    public func portfolio_add(code: String, notif: Bool = true, callback: (() -> Void)? = nil) {
        if !PortfolioUserDefaults.codes.contains(code) {
            PortfolioUserDefaults.codes.append(code)
        }
        postNotificationIfNeeded(notif: notif, code: code, value: true)
        callback?()
    }
    
    /// 删除自选，正常是调用后端接口
    public func portfolio_remove(code: String, notif: Bool = true, callback: (() -> Void)? = nil) {
        PortfolioUserDefaults.codes.removeAll { $0 == code }
        postNotificationIfNeeded(notif: notif, code: code, value: true)
        callback?()
    }
    
    public func portfolio_postStatusDidChangedNotification(code: String, value: Bool) {
        NotificationCenter.default.post(name: .portfolioStatusDidChanged, object: code, userInfo: [kPortfolioStatusCode: code, kPortfolioStatusValue: value])
    }
    
    public func portfolio_getStatusVM(code: String) -> OTPortfolioStatusVM {
        let vm = PortfolioStatusViewModel(code: code)
//        vm.callback = updateCallback
        return vm
    }
    
    func postNotificationIfNeeded(notif: Bool, code: String, value: Bool) {
        guard notif else { return }
        portfolio_postStatusDidChangedNotification(code: code, value: value)
    }
}
