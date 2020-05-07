//
//  PlaceholderTextView.swift
//  FineRoutine
//
//  Created by KITANO on 2020/04/01.
//  Copyright © 2020 kitano. All rights reserved.
//

import UIKit

/// PlaceholderTextView
/// Wrapped UITextView to be able to show Placeholder.
class PlaceholderTextView: UITextView {

    /// Placeholder Label
    private(set) var placeholderLabel: UILabel!

    /// Placeholder text
    var placeholder: String = "" {
        willSet {
            self.placeholderLabel.text = newValue
            self.placeholderLabel.sizeToFit()
        }
    }

    /// Initializer
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        initialize()
    }

    /// Required Initializer
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    /// Common Initializer
    private func initialize() {

        // Adjust the content area.
        textContainerInset = UIEdgeInsets(top: 2, left: 0, bottom: 8, right: 0)
        textContainer.lineFragmentPadding = 0

        // Create a UILabel for showing the placeholder.
        placeholderLabel = UILabel(frame: CGRect(x: 0, y: 2, width: 0, height: 0))
        addSubview(placeholderLabel)

        // Add an observer for getting notifications when the input text changes.
        NotificationCenter.default.addObserver(self, selector: #selector(textChanged(notification:)), name: UITextView.textDidChangeNotification, object: nil)
    }

    /// Deinitializer
    deinit {
        // Remove added observers.
        NotificationCenter.default.removeObserver(self)
    }

    /// Called when the text changes.
    @objc private func textChanged(notification: NSNotification) {
        updateView()
    }

    /// Update the view appearance.
    func updateView() {

        // The placeholder label is showing as long as input text is empty.
        // Or, also if the placeholder text itself is empty, make the label hidden.
        self.placeholderLabel.isHidden = (placeholder.isEmpty || !text.isEmpty)
    }
}

extension PlaceholderTextView {

    // Set custom buttons to my own InputAccessoryView.
    func setInputAccessoryView() {

        /// Clear Button
        let clearButton = UIButton(type: .custom)
        clearButton.frame = CGRect(x: 0, y: 0, width: 100, height: 36)
        clearButton.layer.cornerRadius = 8.0
        clearButton.titleLabel?.font = .toolbarButtonTitle
        clearButton.setTitle("Clear", for: .normal)
        clearButton.setTitleColor(.white, for: .normal)
        clearButton.backgroundColor = .clearButton
        clearButton.addTarget(self, action: #selector(tapClearButton(sender:)), for: .touchUpInside)

        /// Done Button
        let doneButton = UIButton(type: .custom)
        doneButton.frame = CGRect(x: 0, y: 0, width: 100, height: 36)
        doneButton.layer.cornerRadius = 8.0
        doneButton.titleLabel?.font = .toolbarButtonTitle
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.backgroundColor = .doneButton
        doneButton.addTarget(self, action: #selector(tapDoneButton(sender:)), for: .touchUpInside)

        /// InputAccessoryView made with UIToolbar. (Refer to the InputAccessoryView.swift file)
        let inputAccessoryView = InputAccessoryView()
        inputAccessoryView.toolbar.setItems([
            UIBarButtonItem(customView: clearButton),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(customView: doneButton),
        ], animated: false)
        inputAccessoryView.toolbar.updateConstraintsIfNeeded()

        self.inputAccessoryView = inputAccessoryView
    }

    /// Called when the clear button is tapped.
    @objc private func tapClearButton(sender: UIButton) {

        // Clear inputted text and update view appearances.
        self.text = ""
        self.updateView()
    }

    /// Called when the done button is tapped.
    @objc private func tapDoneButton(sender: UIButton) {

        // Call endEditing function to hide the keyboard.
        self.endEditing(true)
    }
}
