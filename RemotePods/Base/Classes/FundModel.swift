//
//  FundModel.swift
//  Base
//
//  Created by zhaoshouwen on 2024/7/4.
//

import Foundation

public struct FundModel {
    public var code: String
    public var name: String
    public var type: String
}

public func getFundList() -> [FundModel] {
    return (1...30).map { index in
        FundModel(code: "Test0\(index)", name: "测试组合\(index)", type: "plan\((index % 2) + 1)")
    }
}
