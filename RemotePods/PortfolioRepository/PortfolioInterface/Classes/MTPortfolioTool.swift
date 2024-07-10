//
//  PortfolioTool.swift
//  PortfolioInterface
//
//  Created by zhaoshouwen on 2024/7/8.
//

import Foundation
import Mediator

public var MTPortfolioTool: MTPortfolioToolProtocol? {
    return MT(MTPortfolioToolProtocol.self)
}

public let kPortfolioStatusCode = "code"
public let kPortfolioStatusValue = "status"

extension Notification.Name {
    public static let portfolioStatusDidChanged = Notification.Name("portfolioStatusDidChanged")
}


public protocol OTPortfolioStatusVM: AnyObject {
    var isExist: Bool { get }
    var updateCallback: ((Bool) -> Void)? { get set }
    func update()
    func toggle()
    func add()
    func remove()
}

// 接口建议有一个统一的前缀，这里用 MT
public protocol MTPortfolioToolProtocol: MediatorProtocol {
    /// 查询是否已加自选，正常是调用后端接口
    func portfolio_isExist(code: String) -> Bool
    /// 加自选，正常是调用后端接口
    func portfolio_add(code: String, notif: Bool, callback: (() -> Void)?)
    /// 删除自选，正常是调用后端接口
    func portfolio_remove(code: String, notif: Bool, callback: (() -> Void)?)
    /// 发送自选状态变更通知
    func portfolio_postStatusDidChangedNotification(code: String, value: Bool)
    /// 获取 OTPortfolioStatusVM 实例
    func portfolio_getStatusVM(code: String) -> OTPortfolioStatusVM
}
