//
//  PortfolioUserDefaults.swift
//  Portfolio
//
//  Created by zhaoshouwen on 2024/7/8.
//

import Foundation
import Base

struct PortfolioUserDefaults {
    @UserDefault(key: "portfolio.codes", default: [])
    public static var codes: [String]
}
