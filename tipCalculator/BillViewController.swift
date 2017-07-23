//
//  BillViewController.swift
//  tipCalculator
//
//  Created by Scott Eremia-Roden on 7/19/17.
//  Copyright © 2017 kitsunebokkusu. All rights reserved.
//

import UIKit

class BillViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let tipView = self.childViewControllers[0] as? TipViewController else {
            return
        }
        print("touchedOutside")
        tipView.billAmountField.endEditing(true)
        tipView.billAmountField.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

