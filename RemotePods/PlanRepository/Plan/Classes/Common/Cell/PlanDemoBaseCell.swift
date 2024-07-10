//
//  PlanDemoBaseCell.swift
//  TableViewSections_Example
//
//  Created by zhaoshouwen on 2024/6/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import Base

extension Bundle {
    // TODO: 公共逻辑提取
    static var plan: Bundle? {
        if let path = Bundle(for: PlanHoldingSection.self).path(forResource: "Plan", ofType: "bundle") {
            return Bundle(path: path)
        }
        return nil
    }
}


class PlanDemoBaseCell<T: PlanDemoBaseModelType>: DemoImageCell {

    func update(with model: T) {
        updateImage(model.demoImageNamed, bundle: .plan)
    }

}
