//
//  Button.swift
//  Books
//
//  Created by Spencer Prescott on 5/21/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import UIKit

final class Button: UIButton {
    enum Style {
        case filled
        case outline
        case alternate(textColor: UIColor)
        
        func backgroundColor(for state: UIControl.State) -> UIColor {
            switch self {
            case .filled:
                switch state {
                case .disabled:
                    return .lightGray
                case .highlighted:
                    return UIColor.primaryBlue.withAlphaComponent(0.6)
                default:
                    return .primaryBlue
                }
            case .outline:
                return .clear
            case .alternate:
                return .clear
            }
        }
        
        func borderColor(for state: UIControl.State) -> UIColor {
            switch self {
            case .filled:
                return .clear
            case .outline:
                switch state {
                case .disabled:
                    return .lightGray
                default:
                    return .primaryBlue
                }
            case .alternate:
                return .clear
            }
        }
        
        func textColor(for state: UIControl.State) -> UIColor {
            switch self {
            case .filled:
                return .white
            case .outline:
                switch state {
                case .disabled:
                    return .lightGray
                default:
                    return .primaryBlue
                }
            case .alternate(let color):
                switch state {
                case .disabled:
                    return color.withAlphaComponent(0.7)
                default:
                    return color
                }
            }
        }
    }
    
    init(style: Style) {
        super.init(frame: .zero)
        self.update(style: style)
        contentEdgeInsets.left = 10
        contentEdgeInsets.right = 10
        contentEdgeInsets.top = 10
        contentEdgeInsets.bottom = 10
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func update(style: Style) {
        let states: [UIControl.State] = [.normal, .selected, .disabled, .highlighted]
        states.forEach { controlState in
            setTitleColor(style.textColor(for: controlState), for: controlState)
            setBackgroundImage(UIImage.make(color: style.backgroundColor(for: controlState)), for: controlState)
            backgroundColor = style.backgroundColor(for: controlState)
            layer.borderColor = style.borderColor(for: controlState).cgColor
        }
        clipsToBounds = true
        layer.borderWidth = 2.0
        layer.cornerRadius = 5.0
    }
    
}
