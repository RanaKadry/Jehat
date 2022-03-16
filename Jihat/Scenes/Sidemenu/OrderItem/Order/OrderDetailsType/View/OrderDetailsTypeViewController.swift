//
//  OrderDetailsTypeViewController.swift
//  Jihat
//
//  Created by Peter Bassem on 30/09/2021.
//

import UIKit

final class OrderDetailsTypeViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var orderNumberLabel: UnderlinedLabel!
    @IBOutlet private weak var orderCreationDateLabel: UILabel!
    @IBOutlet private weak var orderStatusLabel: UILabel!
    @IBOutlet private weak var expectedDateLabel: UILabel!
    @IBOutlet private weak var employeeLabel: UILabel!
    @IBOutlet weak var employeeLabelHeight: NSLayoutConstraint!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet weak var typeLabelHeight: NSLayoutConstraint!
    @IBOutlet private weak var subjectLabel: UILabel!
    @IBOutlet weak var subjectLabelHeight: NSLayoutConstraint!
    @IBOutlet private weak var detailsLabel: UILabel!
    @IBOutlet private weak var detailsLabelheight: NSLayoutConstraint!
    @IBOutlet private weak var priorityLabel: UILabel!
    @IBOutlet private weak var departmentLabel: UILabel!
    @IBOutlet weak var departmentLabelHeight: NSLayoutConstraint!
    
    // MARK: - Variables
    var presenter: OrderDetailsTypePresenterProtocol!
    
    var _scrollView: UIScrollView {
        return scrollView
    }
    var _orderNumberLabel: UnderlinedLabel {
        return  orderNumberLabel
    }
    var _orderCreationDateLabel: UILabel {
        return  orderCreationDateLabel
    }
    var _orderStatusLabel: UILabel {
        return  orderStatusLabel
    }
    var _expectedDateLabel: UILabel {
        return  expectedDateLabel
    }
    var _employeeLabel: UILabel {
        return  employeeLabel
    }
    var _employeeLabelHeight: NSLayoutConstraint {
        return employeeLabelHeight
    }
    var _typeLabel: UILabel {
        return  typeLabel
    }
    var _typeLabelHeight: NSLayoutConstraint {
        return typeLabelHeight
    }
    var _subjectLabel: UILabel {
        return  subjectLabel
    }
    var _subjectLabelHeight: NSLayoutConstraint {
        return subjectLabelHeight
    }
    var _detailsLabel: UILabel {
        return  detailsLabel
    }
    var _detailsLabelheight: NSLayoutConstraint {
        return detailsLabelheight
    }
    var _priorityLabel: UILabel {
        return  priorityLabel
    }
    var _departmentLabel: UILabel {
        return  departmentLabel
    }
    var _departmentLabelHeight: NSLayoutConstraint {
        return departmentLabelHeight
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.layoutIfNeeded()
//        presenter.performUpdateViewHeight(height: scrollView.contentSize.height.toDouble())
//        presenter.performUpdateViewHeight(height: 1000.toDouble())
    }
}

// MARK: - Helpers
extension OrderDetailsTypeViewController {
    
}

// MARK: - Selectors
extension OrderDetailsTypeViewController {
    
}
