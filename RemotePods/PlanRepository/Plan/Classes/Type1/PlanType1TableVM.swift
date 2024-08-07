//
//  PlanType1TableVM.swift
//  TableViewSections_Example
//
//  Created by zhaoshouwen on 2024/6/23.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import TableViewSections
import Base
import CommunityInterface

class PlanType1TableVM: EstimatedTableViewModel {
    
    let code: String
    
    init(code: String) {
        self.code = code
    }
    
    func loadData(callback: @escaping ErrorTask) {
        // 请求页面框架
        PlanAPI.someApi.reqeust { [weak self] in
            guard let self = self else { return }
            // 可以根据框架数据动态组装section
            let sections: [PlanTableViewSectionType] = [
                ClosableSection(),
                PlanType1HeaderSection(),
                PlanType1IntroduceSection(),
                PlanNoticeSection(type: .type1), // section 复用
                PlanType1GrowthSection(),
                PlanProfitRatioSection(type: .type1), // section 复用
                PlanType1NewPlanSection(),
                PlanHoldingSection(type: .type1), // section 复用
                PlanManagerSection(type: .type1), // section 复用
                PlanQASection(type: .type1), // section 复用
                // 这里简单实现，直接强制解包了，不建议这么写
                MTCommunityCommonSections!.getTopCommentsSection(code: self.code), // section 扩模块复用
            ]
            
            // 请求 sction 的数据
            self.loadSections(sections, callBack: callback)
        }
    }
    
    // Demo采用所有Section数据加载完毕在渲染的策略，也可以分开渲染
    // - 使用 section_isDisplay 控制 Section 是不展示: sections(数据源) -> displayedSections(实际展示的，section_isDisplay == true)
    // - 前几个 Section 使用占位或缓存，提高视觉渲染速度
    private func loadSections(_ sections: [PlanTableViewSectionType], callBack: @escaping ErrorTask) {
        let group = DispatchGroup()
        var err: Error?
        
        sections.forEach { (sec) in
            group.enter()
            sec.loadData { (error) in
                group.leave()
                if error != nil { err = error }
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.updateSections(sections)
            self?.reloadTableView()
            callBack(err)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 根据 contentOffset 控制 stretchableView 形变
        
        // scaleWidth == false，stretchableView 宽度不变
        let continer = context.viewController as? PullDownStretchable
        continer?.stretchFixed(with: scrollView.contentOffset.y + scrollView.adjustedContentInset.top, scaleWidth: false)
        
        // scaleWidth == true，默认值，stretchableView 宽度改变
//        continer?.stretchFixed(with: scrollView.contentOffset.y + scrollView.adjustedContentInset.top)
    }
}
