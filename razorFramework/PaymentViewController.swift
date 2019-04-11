//
//  PaymentViewController.swift
//  razorFramework
//
//  Created by Isha Dua on 10/04/19.
//  Copyright © 2019 Isha Dua. All rights reserved.
//

import UIKit
import Razorpay

class PaymentViewController: UIViewController {
   
    lazy var handler = PaymentHandler(with: self)
    
    @IBAction func payTapped(_ sender: Any) {
        handler.initiatePayment(amount: 600)
    }
}

extension PaymentViewController: PaymentHandlerDelegate
{
    func paymentHandler(_ handler: PaymentHandler, didCompletePayment paymentId: String?, error: PaymentHandlerError?)
    {
        print("paymentHandler called")
    }
}
