//
//  AgreementRadioButtonDelegate.swift
//  Jihat
//
//  Created by Ahmed Barghash on 06/11/2021.
//

import Foundation

class AgreementRadioButtonDelegate: MBRadioButtonContainerDelegate {
    
    typealias AgreementSelection = (_ agreement: AgreementType) -> Void
    
    private let agreeRadioButton: MBRadioButton
    private let disagreeRadioButton: MBRadioButton
    private let agreementSelection: AgreementSelection
    
    init(agreeRadioButton: MBRadioButton, disagreeRadioButton: MBRadioButton, agreementSelection: @escaping AgreementSelection) {
        self.agreeRadioButton = agreeRadioButton
        self.disagreeRadioButton = disagreeRadioButton
        self.agreementSelection = agreementSelection
    }
    
    func mBRadioButtonContainerDidSelect(_ button: MBRadioButton, isSelected selected: Bool) {
        switch button {
        case agreeRadioButton: agreementSelection(.agree)
        case disagreeRadioButton: agreementSelection(.disagree)
        default: break
        }
    }
    
}
