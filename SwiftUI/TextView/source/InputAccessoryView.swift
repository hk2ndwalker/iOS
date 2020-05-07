//
//  InputAccessoryView.swift
//  FineRoutine
//
//  Created by KITANO on 2020/04/01.
//  Copyright © 2020 kitano. All rights reserved.
//

import UIKit

/// InputAccessoryView
/// A container for putting custom buttons on the inputAccessoryView of UITextView or UITextField.
class InputAccessoryView: UIView {

    /// The height of internal toolbar
    private static let ToolbarHeight: CGFloat = 44.0

    /// Toolbar
    private(set) var toolbar: UIToolbar!

    /// Layout constraints
    private var leftConstraint: NSLayoutConstraint? = nil
    private var rightConstraint: NSLayoutConstraint? = nil

    /// The size that need for appearing subviews.
    override var intrinsicContentSize: CGSize {
        var size = bounds.size
        size.height = InputAccessoryView.ToolbarHeight + safeAreaInsets.bottom
        return size
    }

    /// Required Initializer
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    /// Initializer
    init() {
        super.init(frame: .zero)
        initialize()
    }

    /// Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    /// Common Initializer
    private func initialize() {

        // Create a UIToolbar.
        toolbar = UIToolbar()

        // Set layout constraints to the toolbar to fit my own bounds.
        addSubview(toolbar)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        toolbar.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        toolbar.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        toolbar.heightAnchor.constraint(equalToConstant: InputAccessoryView.ToolbarHeight).isActive = true

        // Turn off the autoresizing ability.
        translatesAutoresizingMaskIntoConstraints = false
    }

    /// Called when the safe area insets changes.
    override func safeAreaInsetsDidChange() {
        super.safeAreaInsetsDidChange()

        // Call following two functions to make the view's size recalculate.
        invalidateIntrinsicContentSize()
        setNeedsUpdateConstraints()
    }

    /// Called when its own is removed from its superview.
    override func removeFromSuperview() {
        super.removeFromSuperview()

        // Clear layout constraints.
        leftConstraint?.isActive = false
        leftConstraint = nil

        rightConstraint?.isActive = false
        rightConstraint = nil
    }

    /// Called when its own is moved to other superview.
    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        if let superview = superview {
            // Reset layout constraints to fit new superview's bounds.
            leftConstraint?.isActive = false
            leftConstraint = self.leftAnchor.constraint(equalTo: superview.leftAnchor)
            leftConstraint!.isActive = true

            rightConstraint?.isActive = false
            rightConstraint = self.rightAnchor.constraint(equalTo: superview.rightAnchor)
            rightConstraint!.isActive = true
        }
    }
}
