//
//  ButtonContainerView.swift
//  Books
//
//  Created by Spencer Prescott on 5/21/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import UIKit

final class ButtonContainerView: UIView {
    private lazy var stackView: UIStackView = {
        let v = UIStackView()
        v.alignment = .center
        v.distribution = .fillEqually
        v.spacing = 5
        return v
    }()
    
    private lazy var separatorView = UIView(backgroundColor: .groupTableViewBackground)
    
    init(buttons: [Button] = [], axis: NSLayoutConstraint.Axis = .vertical) {
        super.init(frame: .zero)
        stackView.axis = axis
        setButtons(buttons)
        addSubview(stackView)
        addSubview(separatorView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(35)
            make.trailing.equalToSuperview().inset(35)
            make.bottom.equalTo(snp.bottomMargin).inset(5)
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        backgroundColor = .white
    }
    
    func setButtons(_ buttons: [UIButton]) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        buttons.forEach { button in
            stackView.addArrangedSubview(button)
            button.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(15)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
