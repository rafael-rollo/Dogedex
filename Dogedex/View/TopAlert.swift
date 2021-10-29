//
//  TopAlert.swift
//  Dogedex
//
//  Created by rafael.rollo on 29/10/21.
//

import UIKit

fileprivate class CustomTopAlert: UIView {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(size: 12)
        label.textColor = .secondarySystemBackground
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .openSans(.bold, size: 14)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return button
    }()
    
    private lazy var containerView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [label])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(top: 12, left: 24, bottom: 12, right: 24)
        return view
    }()
    
    var message: String = "" {
        didSet {
            label.text = message
        }
    }
    
    var autoClosable: Bool = true
    
    var parent: UIView?
    var topConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addAsSubview(in parent: UIView) {
        self.parent = parent
        
        parent.addSubview(self)
        self.constrainHorizontally(to: parent, withMargins: 24)
        self.topConstraint = self.constrainToTop(of: parent, withMargin: -124, notchSafe: true)
        
        // avoiding the layout constraining code above from being animated
        parent.layoutIfNeeded()
    }
    
    func show(in parent: UIView) {
        addAsSubview(in: parent)
        
        self.topConstraint?.constant = 0
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.parent?.layoutIfNeeded()
            
        } completion: { [weak self] _ in
            guard let self = self,
                  self.autoClosable else { return }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.close()
            }
        }
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        
        self.parent = nil
        self.topConstraint = nil
    }
    
    private func close() {
        guard let _ = parent,
              let topConstraint = topConstraint else { return }
        
        topConstraint.constant = -124
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.parent?.layoutIfNeeded()
            
        } completion: { [weak self] _ in
            self?.removeFromSuperview()
        }
    }
    
    func configureButton(for action: TopAlert.Action) {
        button.setTitle(action.title, for: .normal)
    
        let uiAction = UIAction { [weak self] _ in
            action.handler()
            self?.close()
        }
        button.addAction(uiAction, for: .touchUpInside)
        
        containerView.addArrangedSubview(button)
        autoClosable = false
    }
}

extension CustomTopAlert: ViewCode {
    func addTheme() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondaryLabel.withAlphaComponent(1)
        layer.masksToBounds = false
        layer.cornerRadius = 8
        layer.zPosition = 999
    }
    
    func addViews() {
        addSubview(containerView)
    }
    
    func addConstraints() {
        containerView.constrainTo(edgesOf: self)
    }
}

class TopAlert {
    struct Action {
        var title: String
        var handler: () -> Void
        
        init(title: String, handler: @escaping () -> Void) {
            self.title = title
            self.handler = handler
        }
    }
    
    static func show(message: String,
                     in controller: UIViewController,
                     action: TopAlert.Action? = nil) {
        
        let alert = CustomTopAlert()
        alert.message = message
        
        if let action = action {
            alert.configureButton(for: action)
        }
        
        alert.show(in: controller.view)
    }
}
