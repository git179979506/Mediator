//
//  DemoImageCell.swift
//  TableViewSections_Example
//
//  Created by zhaoshouwen on 2024/6/23.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit

// 显示截图，模拟 section 中多个 cell 的UI
open class DemoImageCell:  BaseCardCell {
    
    private var _height: Constraint?
    
    public func updateImage(_ name: String, bundle: Bundle? = nil) {
        let image = UIImage(named: name, in: bundle, compatibleWith: nil)
        if let image = image, image.size.width > 0 {
            let width = UIScreen.main.bounds.size.width - edgeInset.left - edgeInset.right
            let height = (width * image.size.height / image.size.width).rounded()
            _height?.update(offset: height)
        }
        contentImageView.image = image
    }

    public override func configureSubviews() {
        super.configureSubviews()
        cardView.cornerStyle = .single
        cardView.addSubview(contentImageView)
        
        // 正常开发不需要裁剪子视图可以省略，Demo中截图都带背景颜色需要裁剪
        cardView.clipsToBounds = true
    }
    
    public override func configureConstraints() {
        super.configureConstraints()
        
        contentImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            _height = make.height.equalTo(40).constraint
        }
    }
    
    let contentImageView = UIImageView()
}
