//
//  FriendDetailViewController.swift
//  tipCalculator
//
//  Created by Scott Eremia-Roden on 7/19/17.
//  Copyright © 2017 kitsunebokkusu. All rights reserved.
//

import UIKit

class FriendDetailViewController: UIViewController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        dump(self.navigationItem)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    

}
