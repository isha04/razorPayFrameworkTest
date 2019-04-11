//
//  PaymentViewController.swift
//  razorFramework
//
//  Created by Isha Dua on 10/04/19.
//  Copyright © 2019 Isha Dua. All rights reserved.
//

import UIKit
import Razorpay

class PaymentViewController: UIViewController, RazorpayPaymentCompletionProtocol {
    
    var razorpay: Razorpay!
    private let amountInPaise: Int
    private let userEmail: String
    
    public init(amount: Double, userEmail: String) {
        self.amountInPaise = Int(amount * 100)
        self.userEmail = userEmail
        super.init(nibName: nil, bundle: nil)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        razorpay = Razorpay.initWithKey("Inset-api", andDelegate: self)
        showPaymentForm()
    }
    
    func showPaymentForm() {
        self.navigationController?.isNavigationBarHidden = true
        let options: [String:Any] = [
            "amount" : "\(amountInPaise)", //Amount has to be input in in paise
            "description": "purchase description",
            "image": UIImage(named: "paymentsIcon") as Any,
            "name": "Zolostays",
            "prefill": [
                "contact": "9797979797",
                "email": "\(userEmail)"
            ],
            "theme": [
                "color": "#0000FF"
            ]
        ]
        razorpay.open(options)
    }
    
    public func onPaymentError(_ code: Int32, description str: String) {
        print("sucess")
    }
    
    public func onPaymentSuccess(_ payment_id: String) {
        print("failure")
    }
    
    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

