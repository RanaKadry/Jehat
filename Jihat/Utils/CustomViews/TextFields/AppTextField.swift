//
//  AppTextField.swift
//  SelfService
//
//  Created by Imac on 7/11/20.
//  Copyright © 2020 IbnSinai. All rights reserved.
//

import UIKit

enum AppTextFieldInputType: Int {
    case normal
    case number
    case date
}

protocol AppTextFieldDelegate: UITextFieldDelegate {
    func didClick(_ appTextField: AppTextField, isSuffix: Bool)
}

@IBDesignable
class AppTextField: UIView {
    weak var delegate: AppTextFieldDelegate?

    let textColor = UIColor(hexString: "#A5A5A5")

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()

    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    lazy var prefixImageView: UIImageView = buildImage()
    lazy var suffixImageView: UIImageView = buildImage()

    private func buildImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24)
        ])
        imageView.contentMode = .scaleAspectFit
        return imageView
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        shadowRadius = 10
        shadowOffsetY = 3
        shadowOpacity = 1
        shadow_Color = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16)
        cornerRadius = 10
        addSubview(stackView)
        stackView.fillSuperView(shouldUseSafeArea: false, padding: UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14))
//        stackView.addArrangedSubview(prefixImageView)
//        stackView.addArrangedSubview(textField)
        textField.textColor = textColor
        textField.placeHolderColor = textColor
        suffixImageView.isUserInteractionEnabled = true
        suffixImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(suffixAction)))
    }

    @objc private func suffixAction() {
        delegate?.didClick(self, isSuffix: true)
    }

    fileprivate var _fontSize: CGFloat {
        return textField.font?.pointSize ?? 18
    }

    fileprivate var _fontName: String {
        return textField.font?.fontName ?? "Muli-Regular"
    }
}

extension AppTextField {
    @IBInspectable
    var prefixImage: UIImage? {
        get {
            prefixImageView.image
        } set {
            stackView.addArrangedSubview(prefixImageView)
            stackView.addArrangedSubview(textField)
            let img = newValue?.flippedImageToRight()
            prefixImageView.image = img
        }
    }

    @IBInspectable
    var suffixImage: UIImage? {
        get {
            suffixImageView.image
        } set {
            stackView.addArrangedSubview(textField)
            stackView.addArrangedSubview(suffixImageView)
            let img = newValue?.flippedImageToRight()
            suffixImageView.image = img
        }
    }

    @IBInspectable
    var textFieldColor: UIColor? {
        get {
            return textField.textColor
        } set {
            textField.textColor = newValue
        }
    }

    @IBInspectable
    var textFieldPlaceHolderColor: UIColor? {
        get {
            return textField.placeHolderColor
        } set {
            textField.placeHolderColor = newValue
        }
    }

    @IBInspectable
    var textFieldLocalizedPlaceHolder: String {
        get {
            return textField.localizationKey
        } set {
            textField.localizationKey = newValue
        }
    }

    @IBInspectable
    var fontSize: CGFloat {
        get {
            return _fontSize
        }
        set {
            textField.font = UIFont(name: _fontName, size: newValue)
        }
    }

    @IBInspectable
    var isSecure: Bool {
        get {
            return textField.isSecureTextEntry
        }
        set {
            textField.isSecureTextEntry = newValue
        }
    }

    @IBInspectable
    var isEnabled: Bool {
        get {
            return textField.isEnabled
        }
        set {
            textField.isEnabled = newValue
        }
    }

    @IBInspectable
    var removePrefixImage: Bool {
        get {
            stackView.arrangedSubviews.contains(prefixImageView)
        }
        set {
            if newValue {
                prefixImageView.isHidden = true
                stackView.removeArrangedSubview(prefixImageView)
            }
        }
    }

    @IBInspectable
    var inputType: Int {
        get {
            textField.keyboardType.rawValue
        }
        set {
            let type = AppTextFieldInputType(rawValue: newValue) ?? .normal
            switch type {
            case .normal:
                textField.inputView = nil
                textField.keyboardType = .default
            case .number:
                textField.inputView = nil
                textField.keyboardType = .numberPad
            case .date:
                let pickerView = UIDatePicker()
                pickerView.maximumDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())
                pickerView.setDate(Date(), animated: false)
                pickerView.datePickerMode = .date
                pickerView.addTarget(self, action: #selector(pickerValueChanged(sender:)), for: .valueChanged)
                textField.inputView = pickerView
            }
        }
    }

    @objc private func pickerValueChanged(sender: UIDatePicker) {
        let dateStr = sender.date.getDateString(formate: DateFormates.monthSlashYear.rawValue)
        textField.text = dateStr
    }
}
