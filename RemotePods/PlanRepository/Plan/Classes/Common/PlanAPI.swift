//
//  PlanAPI.swift
//  Plan
//
//  Created by zhaoshouwen on 2024/7/4.
//

import Foundation
import Base

enum PlanAPI {
    case someApi
    case otherApi(params: [String: Any])
    
    // 模拟网络请求，这里不考虑错误的情况
    func reqeust(callback: @escaping VoidTask) {
        let duration = Int.random(in: 500...1000)
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(duration)) {
            callback()
        }
    }
}
