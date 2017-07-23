//
//  TipViewController.swift
//  tipCalculator
//
//  Created by Scott Eremia-Roden on 7/19/17.
//  Copyright © 2017 kitsunebokkusu. All rights reserved.
//

import UIKit

class TipViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var billAmountField: UITextField!
    let billAmountFieldLimit: Int = 6
    
    @IBOutlet weak var tipTotalAmountLabel: UILabel!
    
    @IBOutlet weak var totalAmountDueLabel: UILabel!

    @IBOutlet weak var tipSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var partySizeStepper: UIStepper!
    
    var bill: Bill?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.billAmountField.frame.height))
        billAmountField.rightView = paddingView
        billAmountField.rightViewMode = UITextFieldViewMode.always
        billAmountField.delegate = self
        billAmountField.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }
    
    
     override func viewDidAppear(_ animated: Bool) {
        loadTips()
        
        
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= billAmountFieldLimit
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func adjustPartySize(_ sender: Any) {
        
        guard let vc = self.parent?.childViewControllers[1] as? PartyViewController else {
            return
        }
        
        vc.partySize = Int(self.partySizeStepper.value)
        vc.loadFriends()
        billAmountChanged(sender)
        vc.partyTableView.reloadData()
    }
    
    @IBAction func tipPercentageChanged(_ sender: Any) {
        billAmountChanged(sender)
        guard let vc = self.parent?.childViewControllers[1] as? PartyViewController else {
            return
        }
        vc.partyTableView.reloadData()
        
    }
    
    @IBAction func billAmountChanged(_ sender: Any) {
        
        let tipIndex = self.tipSegmentedControl.selectedSegmentIndex
        
        guard let tipValue = self.tipSegmentedControl.titleForSegment(at: tipIndex) else {
            return
        }
        guard let billValue = self.billAmountField.text else {
            return
        }
        self.bill = calculateTotals(billAmount: billValue, tipPercentage: tipValue)
        
        // Assign the values to to the UI
        
        self.totalAmountDueLabel.text = self.bill?.totalBillWithTipDollarAmount ?? "$0.00"
        self.tipTotalAmountLabel.text = self.bill?.tipDollarAmount ?? "$0.00"
        guard let vc = self.parent?.childViewControllers[1] as? PartyViewController else {
            return
        }
        vc.partyTableView.reloadData()
        return
        
    }
    
    
    
    
    func calculateTotals(billAmount: String, tipPercentage: String) -> Bill? {
        
        guard let billAmountValue = billAmount.removeAllCharactersNotNumbers else {
            return nil
        }
        
        guard let tipPercentageValue = tipPercentage.removeAllCharactersNotNumbers else {
            return nil
        }
        
        guard let billValue = Double(billAmountValue), let tipValue = Double(tipPercentageValue) else {
            return nil
        }
        
        return Bill(billAmountValue: billValue, percentageValue: tipValue)
        
    }
    
    func loadTips() {
        guard var firstTipString = LocalSettings.loadStringSetting(forKey: tipStrings.first), let firstTip = Int(firstTipString) else {
            print("could not load the first tip string")
            return
        }
        
        firstTipString = String(format: "%d%%", firstTip)
        tipSegmentedControl.setTitle(firstTipString , forSegmentAt: 0)
        
        
        guard var secondTipString = LocalSettings.loadStringSetting(forKey: tipStrings.second), let secondTip = Int(secondTipString) else {
            print("could not load the second tip string")
            return
        }
        secondTipString = String(format: "%d%%", secondTip)
        tipSegmentedControl.setTitle(secondTipString, forSegmentAt: 1)
        
        
        guard var thirdTipString = LocalSettings.loadStringSetting(forKey: tipStrings.third), let thirdTip = Int(thirdTipString) else {
            print("could not load the third tip string")
            return
        }
        thirdTipString = String(format: "%d%%", thirdTip)
        tipSegmentedControl.setTitle(thirdTipString, forSegmentAt: 2)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
