//
//  PaymentHandler.swift
//  razorFramework
//
//  Created by Shivam Jaiswal on 11/04/19.
//  Copyright © 2019 Isha Dua. All rights reserved.
//

import Foundation
import Razorpay
import UIKit

protocol PaymentHandlerDelegate: AnyObject {
    func paymentHandler(_ handler: PaymentHandler, didCompletePayment paymentId: String?, error: PaymentHandlerError?)
}

class PaymentHandler {
    
    lazy var razorpay: Razorpay = {
        let razorpay = Razorpay.initWithKey(self.apiKey() , andDelegate: self)
        return razorpay
    }()
    
    weak var delegate: PaymentHandlerDelegate?
    private (set) var initiatedAmount: Double = 0
    
    init(with delegate: PaymentHandlerDelegate) {
        self.delegate = delegate
    }
    
    // can be over ridden if required
    func apiKey() -> String {
        return "rzp_test_oecEV6BUobeTZD"
    }
    
    func initiatePayment(amount: Double, email: String = "delfautlEmail@abc.com", contat: String = "999999999" ) {
        self.initiatedAmount = amount
        
        let options: [AnyHashable : Any] = [
            "amount" : "\(amount)", //Amount has to be input in in paise
            "description": "purchase description",
            "name": "Zolostays",
            "prefill": [
                "contact": contat,
                "email": email
            ],
            "theme": [
                "color": "#0000FF"
            ]
        ]
        razorpay.open(options)
    }
}

extension PaymentHandler: RazorpayPaymentCompletionProtocol
{
    func onPaymentError(_ code: Int32, description str: String) {
        delegate?.paymentHandler(self, didCompletePayment: nil, error: PaymentHandlerError(str,code))
    }
    
    func onPaymentSuccess(_ payment_id: String) {
        delegate?.paymentHandler(self, didCompletePayment: payment_id, error: nil)
    }
}


struct PaymentHandlerError: Error {
    let message: String
    let code: Int32
    init(_ message: String, _ code: Int32) {
        self.message = message
        self.code = code
    }
    
    public var localizedDescription: String {
        return message
    }
}
