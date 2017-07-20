//
//  PartyViewController.swift
//  tipCalculator
//
//  Created by Scott Eremia-Roden on 7/19/17.
//  Copyright © 2017 kitsunebokkusu. All rights reserved.
//

import UIKit

class PartyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    

    @IBOutlet weak var partyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        partyTableView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // MARK: Prepare for Seque to friend detail
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "friendDetailSegue" {
            guard let vc = segue.destination as? FriendDetailViewController else {
                print("didn't work")
                return
            }
            vc.navigationItem.title = "Something else"
            vc.navigationItem.backBarButtonItem = UIBarButtonItem(title: "back 2.0", style: .plain, target: nil, action: nil)
            
        }
    }
 
    
    
    // MARK: Table Setup
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendTableViewCell
        return cell
    }
    
    

}
