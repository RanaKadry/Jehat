//
//  PhoneNumberTextField.swift
//  MandoBee
//
//  Created by Peter Bassem on 27/07/2021.
//

import UIKit
import FlagPhoneNumber

protocol PhoneNumberTextFieldDelegate: AnyObject {
    func phoneNumberTextFieldIsValidPhone(_ isValid: Bool)
    func phoneNumberTextFieldDisplayCountriesListViewController()
}

class PhoneNumberTextField: FPNTextField {
    
    // MARK: - Variables
    private static var listController = FPNCountryListViewController(style: .grouped)
    private(set) var isPhoneValid: Bool = false
    var formattedPhone: String? {
        isPhoneValid ? getFormattedPhoneNumber(format: .National)?.removeWhiteSpaces() : nil // getRawPhoneNumber()
    }
    var countryCodePhone: String? {
        isPhoneValid ? getFormattedPhoneNumber(format: .International)?.removeWhitespace() : nil
    }
    
    weak var phoneNumberDelegate: PhoneNumberTextFieldDelegate?
    
    // MARK: - IBInspectable
    @IBInspectable var showPhoneExample: Bool = true

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        // To force textfield direction in rtl languages..
        semanticContentAttribute = .forceLeftToRight
        textAlignment = .left

        subviews.forEach {
            $0.semanticContentAttribute = .forceLeftToRight
        }
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let newRect = CGRect(
            x: frame.size.width - 40,
            y: -0,
            width: 32,
            height: frame.size.height
        )
        return newRect
    }
    
    // MARK: - Private Configuration
    private func configure() {
        PhoneNumberTextField.listController.setup(repository: countryRepository)
        PhoneNumberTextField.listController.didSelect = { [weak self] country in
            self?.setFlag(countryCode: country.code)
        }
        displayMode = .list
        flagButtonSize = .init(width: 40, height: 40)
        flagButton.imageEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 10)
        hasPhoneNumberExample = showPhoneExample
        placeHolderColor = DesignSystem.Colors.textPlaceholder.color
        setFlag(countryCode: .SA)
        delegate = self
    }
    
    static func createListCountriesNavigationController() -> UINavigationController {
        let listNavigationController = UINavigationController(rootViewController: listController)
        listController.title = "countries".localized()
        return listNavigationController
    }
    
    // MARK: - Helpers
    func updateCountry(withFlagCode code: String) {
        let code = FPNCountryCode(rawValue: code) ?? .SA
        setFlag(countryCode: code)
    }
}

// MARK: - FPNTextFieldDelegate
extension PhoneNumberTextField: FPNTextFieldDelegate {
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) { }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        isPhoneValid = isValid
        phoneNumberDelegate?.phoneNumberTextFieldIsValidPhone(isValid)
        let validationImage = isValid ? DesignSystem.Icon.success.image : DesignSystem.Icon.error.image
        let imageView = UIImageView(image: validationImage)
        imageView.contentMode = .center
        rightViewMode = .whileEditing
        rightView = imageView
    }
    
    func fpnDisplayCountryList() {
        phoneNumberDelegate?.phoneNumberTextFieldDisplayCountriesListViewController()
    }
}
