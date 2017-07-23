//
//  Bill.swift
//  tipCalculator
//
//  Created by Scott Eremia-Roden on 7/20/17.
//  Copyright © 2017 kitsunebokkusu. All rights reserved.
//

import Foundation

struct Bill {
    var billAmountValue: Double?
    var billDollarAmount: String {
        guard let billValue = billAmountValue else {
            return "$0.00"
        }
        return String(format: "$%.2f", billValue)
    }
    
    var percentageValue: Double?
    var tipAmount: Double? {
        guard var percentageValue = percentageValue else {
            return nil
        }
        percentageValue = percentageValue / 100.0
        guard let billValue = billAmountValue else {
            return nil
        }
        return billValue * percentageValue
    }
    var tipPercentageAmount: String {
        guard let tipPercentageValue = percentageValue else {
            return "0%"
        }
        let tipPercentageAmount = String(format: "%d%%", tipPercentageValue)
        return tipPercentageAmount
    }
    
    var tipDollarAmount: String {
        guard let tipValue = tipAmount else {
            return "$0.00"
        }
        return String(format: "$%.2f", tipValue)
    }
    
    var totalBillWithTipAmount: Double? {
        guard let billAmountValue = billAmountValue, var tipPercentage = percentageValue else {
            return nil
        }
        tipPercentage = tipPercentage / 100.0
        //print(tipPercentage)
        return billAmountValue + (billAmountValue * tipPercentage)
    }
    var totalBillWithTipDollarAmount: String {
        guard let total = totalBillWithTipAmount else {
            return "$0.00"
        }
        let value = String(format: "$%.2f", total)
        return value
    }
}
