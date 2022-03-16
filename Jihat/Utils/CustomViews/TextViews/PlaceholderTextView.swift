//
//  PlaceholderTextView.swift
//  Jihat
//
//  Created by Peter Bassem on 11/10/2021.
//

import UIKit

@IBDesignable
class PlaceholderTextView: UITextView {

   // MARK: - Variables
    @IBInspectable
    var placeholderText: String = "" {
        didSet { configurePlaceholderText() }
    }
    @IBInspectable
    var placeholderColor: UIColor = .clear {
        didSet { configurePlaceholderColor() }
    }
    @IBInspectable
    var mTextColor: UIColor?
    
    private(set) var isTextEmpty: Bool = true
    var textIsEmptyListener: ((Bool) -> Void)?
    
    // MARK: - Initializers
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidBeginEditingNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidEndEditingNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidChangeNotification, object: nil)
    }
    
    // MARK: - Private Configuration
    private func configure() {
        textAlignment = LocalizationHelper.isArabic() ? .right : .left
        NotificationCenter.default.addObserver(self, selector: #selector(textViewDidBeginEditing(_:)), name: UITextView.textDidBeginEditingNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(textViewDidEndEditing(_:)), name: UITextView.textDidEndEditingNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(textViewDidChange(_:)), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    private func showPlacholdr(_ show: Bool) {
        if show {
            text = placeholderText.localized()
            textColor = placeholderColor
        } else {
            text = nil
            textColor = mTextColor
        }
    }
    
    private func configurePlaceholderText() {
        text = placeholderText.localized()
    }
    
    private func configurePlaceholderColor() {
        textColor = placeholderColor
    }
    
    @objc
    func textViewDidBeginEditing(_ textView: UITextView) {
        if !text.isEmpty && text == placeholderText.localized() {
            showPlacholdr(false)
        }
    }
    
    @objc
    func textViewDidChange(_ sender: UITextView) {
        isTextEmpty = text.isEmpty
        textIsEmptyListener?(text.isEmpty)
    }
    
    @objc
    func textViewDidEndEditing(_ textView: UITextView) {
        if text.isEmpty {
            showPlacholdr(true)
        }
    }
}
