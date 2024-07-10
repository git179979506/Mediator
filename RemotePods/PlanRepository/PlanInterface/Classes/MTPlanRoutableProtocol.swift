//
//  MTPlanRoutable.swift
//  PlanInterface
//
//  Created by zhaoshouwen on 2024/7/7.
//

import Foundation
import Mediator

public enum PlanType: String {
    case type1
    case type2
}

/// 组合详情路由，一般通过URL路由实现！这里的目的是介绍 Mediator 组件间通信方案！！！
public protocol MTPlanRoutableProtocol: MediatorProtocol {
    /// 获取组合详情页
    func planDetail(code: String, type: PlanType) -> UIViewController
}

public var MTPlanRoutable: MTPlanRoutableProtocol? {
    return MT(MTPlanRoutableProtocol.self)
}
