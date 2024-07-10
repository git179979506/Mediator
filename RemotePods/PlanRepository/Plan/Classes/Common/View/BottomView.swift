//
//  BottomView.swift
//  Plan
//
//  Created by zhaoshouwen on 2024/7/9.
//

import UIKit
import Base
import PortfolioInterface

class BottomView: BaseView {
    
    var vm: OTPortfolioStatusVM?
    
    func update(with vm: OTPortfolioStatusVM) {
        self.vm = vm
        updateOptionalButton(value: vm.isExist)
        vm.updateCallback = { [weak self] value in
            self?.updateOptionalButton(value: value)
        }
    }
    
    func updateOptionalButton(value: Bool) {
        let title = value ? "取消自选" : "加自选"
        optionalButton.setTitle(title, for: .normal)
    }
    
    @objc func onTapOptionalButton() {
        vm?.toggle()
    }
    
    override func configureSubviews() {
        backgroundColor = .white
        stackView.addArrangedSubview(optionalButton)
        stackView.addArrangedSubview(applyButton)
        addSubview(stackView)
        
        optionalButton.addTarget(self, action: #selector(onTapOptionalButton), for: .touchUpInside)
    }
    
    override func configureConstraints() {
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(10)
            make.height.equalTo(40)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(10)
        }
    }
    
    let stackView = UIStackView().ns.config {
        $0.axis = .horizontal
        $0.spacing = 20
        $0.distribution = .fillEqually
    }
    
    let optionalButton = UIButton(type: .custom).ns.config {
        $0.setTitle("加自选", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .blue
        $0.layer.cornerRadius = 20
    }
    
    let applyButton = UIButton(type: .custom).ns.config {
        $0.setTitle("购买", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .red
        $0.layer.cornerRadius = 20
    }
}
