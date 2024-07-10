//
//  PortfolioTool.swift
//  PortfolioInterface
//
//  Created by zhaoshouwen on 2024/7/8.
//

import Foundation
import Mediator
import Base
import TableViewSections

public var MTCommunityCommonSections: MTCommunityCommonSectionsProtocol? {
    return MT(MTCommunityCommonSectionsProtocol.self)
}

// 接口建议有一个统一的前缀，这里用 MT
public protocol MTCommunityCommonSectionsProtocol: MediatorProtocol {
    func getTopCommentsSection(code: String) -> TableViewSectionType & SectionLoaderType
}
