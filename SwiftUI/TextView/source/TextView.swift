//
//  TextView.swift
//  FineRoutine
//
//  Created by KITANO on 2020/03/19.
//  Copyright © 2020 kitano. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

struct TextView: UIViewRepresentable {
    
    @Binding private var text: String
    
    private(set) var placeholder: String

    fileprivate let didEndSubject = PassthroughSubject<Void, Never>()
    fileprivate let didChangeSubject = PassthroughSubject<Void, Never>()

    /// Initializer
    init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }

    /// Create a coordinator to coordinate the UIView.
    func makeCoordinator() -> TextView.Coordinator {
        return Coordinator(self)
    }

    /// Create a UIView that actually displayed.
    func makeUIView(context: UIViewRepresentableContext<TextView>) -> PlaceholderTextView {

        // Create a PlaceholderTextView
        let textView = PlaceholderTextView()
        textView.delegate = context.coordinator
        textView.font = .inputText
        textView.placeholderLabel.font = .placeholderText
        textView.placeholderLabel.textColor = .placeholderText
        textView.setInputAccessoryView()

        return textView
    }

    /// Update the UIView states.
    func updateUIView(_ uiView: PlaceholderTextView, context: UIViewRepresentableContext<TextView>) {

        uiView.text = text
        uiView.placeholder = placeholder
        uiView.updateView()

        // Update the textview value which the coordinator has.
        context.coordinator.textView = self
    }

    /// Call actions when each events occur.
    func onEvent(onChanged: (() -> Void)? = nil, onEnded: (() -> Void)? = nil) -> some View {
        return onReceive(didChangeSubject) {
            onChanged?()
        }
        .onReceive(didEndSubject) {
            onEnded?()
        }
    }
}

extension TextView {
    final class Coordinator: NSObject, UITextViewDelegate {
        
        fileprivate var textView: TextView

        /// Initializer
        init(_ textView: TextView) {
            self.textView = textView
        }

        /// Called when text has changed.
        func textViewDidChange(_ textView: UITextView) {

            // Feed back to the binding text.
            self.textView.text = textView.text

            // Send to the subscriber.
            self.textView.didChangeSubject.send()
        }

        /// Called when editing has ended.
        func textViewDidEndEditing(_ textView: UITextView) {

            // Feed back to the binding text.
            self.textView.text = textView.text

            // Send to the subscriber.
            self.textView.didEndSubject.send()
        }
    }
}
