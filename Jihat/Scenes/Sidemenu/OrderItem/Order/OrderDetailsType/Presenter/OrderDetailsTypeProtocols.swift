//
//  OrderDetailsTypeProtocols.swift
//  Jihat
//
//  Created Peter Bassem on 30/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import CoreGraphics

// MARK: OrderDetailsType Protocols

protocol OrderDetailsTypeViewProtocol: BaseViewProtocol {
    var presenter: OrderDetailsTypePresenterProtocol! { get set }
    
    func refreshScrollView()
    func set(orderNumber: String)
    func set(creationDate: String)
    func set(status: String)
    func set(expectedCompletionDate: String)
    func set(employee: String)
    func set(employeeTextHeight: CGFloat)
    func set(type: String)
    func set(typeTextHeight: CGFloat)
    func set(subject: String)
    func set(subjectTextHeight: CGFloat)
    func set(details: String)
    func updateOrderDetailsLabelHeight(details: String)
    func set(priority: String)
    func set(department: String)
    func set(departmentHeight: CGFloat)
}

protocol OrderDetailsTypePresenterProtocol: BasePresenterProtocol {
    var view: OrderDetailsTypeViewProtocol? { get set }
    
    func viewDidLoad()
    
    var attatchmentsCount: Int { get }
    func configureAttatchemtCell(_ cell: AttatchmentCollectionViewCellProtocol, atIndex index: Int)
}

protocol OrderDetailsTypeRouterProtocol: BaseRouterProtocol {
    
}

protocol OrderDetailsTypeInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: OrderDetailsTypeInteractorOutputProtocol? { get set }
    
}

protocol OrderDetailsTypeInteractorOutputProtocol: BaseInteractorOutputProtocol {
    
    
}
