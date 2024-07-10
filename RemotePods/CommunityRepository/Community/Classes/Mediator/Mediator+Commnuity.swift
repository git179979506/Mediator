//
//  Mediator+Portfolio.swift
//  Portfolio
//
//  Created by zhaoshouwen on 2024/7/8.
//

import Foundation
import Mediator
import Base
import CommunityInterface
import TableViewSections

extension Mediator: MTCommunityCommonSectionsProtocol {
    public func getTopCommentsSection(code: String) -> TableViewSectionType & SectionLoaderType {
        return PlanTopCommentsSection(code: code)
    }
}
