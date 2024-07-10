//
//  PlanTopCommentsSection.swift
//  TableViewSections_Example
//
//  Created by zhaoshouwen on 2024/6/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import TableViewSections
import Base

public class PlanTopCommentsSection: TableViewSectionType & SectionLoaderType {
    public let code: String
    // 控制Section是否显示
    public var section_isDisplay: Bool {
        return imageNamed != nil
    }
    
    var imageNamed: String?
    
    init(code: String) {
        self.code = code
    }
    
    public func loadCache() {
        // 按需加载缓存数据
    }
    
    // 网络请求
    public func loadData(callback: @escaping ErrorTask) {
        CommnuityAPI.otherApi(params: ["code": code]).reqeust { [weak self] in
            defer { callback(nil) }
            guard let self = self else { return }
            self.imageNamed = "plan_top_comments"
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageNamed == nil ? 0 : 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.ns.dequeueCell(PlanTopCommnetsCell.self, for: indexPath)
        if let imageNamed = imageNamed {
            cell.updateImage(imageNamed, bundle: .community)
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat? {
        return 768
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: 跳转
    }
}

extension Bundle {
    // TODO: 公共逻辑提取
    static var community: Bundle? {
        if let path = Bundle(for: PlanTopCommentsSection.self).path(forResource: "Community", ofType: "bundle") {
            return Bundle(path: path)
        }
        return nil
    }
}
