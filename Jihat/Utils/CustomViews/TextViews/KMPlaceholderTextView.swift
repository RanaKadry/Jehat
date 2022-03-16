//
//  KMPlaceholderTextView.swift
//
//  Copyright (c) 2016 Zhouqi Mo (https://github.com/MoZhouqi)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

@IBDesignable
open class KMPlaceholderTextView: UITextView {
    
    private struct Constants {
        static let defaultiOSPlaceholderColor: UIColor = {
            return UIColor(red: 0.0, green: 0.0, blue: 0.0980392, alpha: 0.22)
        }()
    }
  
    public lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = font
        label.textColor = placeholderColor
        label.textAlignment = LocalizationHelper.isArabic() ? .right : .left // textAlignment
        label.text = placeholder
        label.numberOfLines = 0
        label.backgroundColor = UIColor.clear
        return label
    }()
    
    private var placeholderLabelConstraints = [NSLayoutConstraint]()
    
    @IBInspectable open var placeholder: String = "" {
        didSet {
            placeholderLabel.text = placeholder.localized()
        }
    }
    
    @IBInspectable open var placeholderColor: UIColor = KMPlaceholderTextView.Constants.defaultiOSPlaceholderColor {
        didSet {
            placeholderLabel.textColor = placeholderColor
        }
    }
    
    override open var font: UIFont! {
        didSet {
            if placeholderFont == nil {
                placeholderLabel.font = font
            }
        }
    }
    
    open var placeholderFont: UIFont? {
        didSet {
            let font = (placeholderFont != nil) ? placeholderFont : self.font
            placeholderLabel.font = font
        }
    }
    
    override open var textAlignment: NSTextAlignment {
        didSet {
            placeholderLabel.textAlignment = textAlignment
        }
    }
    
    override open var text: String! {
        didSet {
            textDidChange()
        }
    }
    
    override open var attributedText: NSAttributedString! {
        didSet {
            textDidChange()
        }
    }
    
    override open var textContainerInset: UIEdgeInsets {
        didSet {

        }
    }
    
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        #if swift(>=4.2)
        let notificationName = UITextView.textDidChangeNotification
        #else
        let notificationName = NSNotification.Name.UITextView.textDidChangeNotification
        #endif
      
        NotificationCenter.default.addObserver(self,
            selector: #selector(textDidChange),
            name: notificationName,
            object: nil)
        addSubview(placeholderLabel)
        placeholderLabel.fillSuperview()
        
//        placeholderLabel.frame = .init(x: 8, y: 6, width: frame.size.width, height: 0)
//        placeholderLabel.sizeToFit()
    }
    
    @objc private func textDidChange() {
        placeholderLabel.isHidden = !text.isEmpty
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        placeholderLabel.fillSuperview()
//        placeholderLabel.frame = .init(x: 8, y: 6, width: frame.size.width, height: 0)
//        placeholderLabel.sizeToFit()
    }
    
    deinit {
      #if swift(>=4.2)
      let notificationName = UITextView.textDidChangeNotification
      #else
      let notificationName = NSNotification.Name.UITextView.textDidChangeNotification
      #endif
      
        NotificationCenter.default.removeObserver(self,
            name: notificationName,
            object: nil)
    }
    
}
