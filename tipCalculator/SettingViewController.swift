//
//  SettingViewController.swift
//  tipCalculator
//
//  Created by Scott Eremia-Roden on 7/19/17.
//  Copyright © 2017 kitsunebokkusu. All rights reserved.
//

import UIKit

struct tipStrings {
    static let first = "firstTipPercentage"
    static let second = "secondTipPercentage"
    static let third = "thirdTipPercentage"
}

extension String {
    var removeAllCharactersNotNumbers: String? {
        return self.trimmingCharacters(in: CharacterSet(charactersIn: "0123456789").inverted)
    }
}

class SettingViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var thirdTipPercentage: UITextField!
    @IBOutlet weak var secondTipPercentage: UITextField!
    @IBOutlet weak var firstTipPercentage: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        loadTips()
        
        
    }
    
    override func transition(from fromViewController: UIViewController, to toViewController: UIViewController, duration: TimeInterval, options: UIViewAnimationOptions = [], animations: (() -> Void)?, completion: ((Bool) -> Void)? = nil) {
        dump(fromViewController)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Save tips into the User Defaults
    @IBAction func updateTipPercentages(_ sender: Any) {
        guard let first = firstTipPercentage.text?.removeAllCharactersNotNumbers, let firstDouble = Double(first) else {
            return
        }
        guard let second = secondTipPercentage.text?.removeAllCharactersNotNumbers, let secondDouble = Double(second) else {
            return
        }
        guard let third = thirdTipPercentage.text?.removeAllCharactersNotNumbers, let thirdDouble = Double(third) else {
            return
        }
        LocalSettings.saveSetting(forKey: tipStrings.first, value: firstDouble)
        LocalSettings.saveSetting(forKey: tipStrings.second, value:  secondDouble)
        LocalSettings.saveSetting(forKey: tipStrings.third, value: thirdDouble)
    }
    
    /// Load the tips from the User Defaults
    func loadTips() {
        let firstPercentage = LocalSettings.loadStringSetting(forKey: tipStrings.first)
        let secondPercentage = LocalSettings.loadStringSetting(forKey: tipStrings.second)
        let thirdPercentage = LocalSettings.loadStringSetting(forKey: tipStrings.third)
        
        self.thirdTipPercentage.text = thirdPercentage
        self.secondTipPercentage.text = secondPercentage
        self.firstTipPercentage.text = firstPercentage
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
