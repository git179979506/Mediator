//
//  Mediator+plan.swift
//  Plan
//
//  Created by zhaoshouwen on 2024/7/7.
//

import Foundation
import Mediator
import PlanInterface

extension Mediator: MTPlanRoutableProtocol {
    public func planDetail(code: String, type: PlanInterface.PlanType) -> UIViewController {
        switch type {
        case .type1:
            let vc = PlanType1ViewController(code: code)
            return vc
        case .type2:
            let vc = PlanType2ViewController()
            vc.code = code
            return vc
        }
    }
}
