//
//  PartyViewController.swift
//  tipCalculator
//
//  Created by Scott Eremia-Roden on 7/19/17.
//  Copyright © 2017 kitsunebokkusu. All rights reserved.
//

import UIKit

class PartyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {
    
    
    var partySize: Int?
    

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
            // setting the title to friend will update later if a friend is found
            vc.navigationItem.title = "Friend"
            // set the index to the correct row so we know which friend's data to load
            vc.friendIndex = partyTableView.indexPathForSelectedRow
            
        }
    }
 
    
    
    
    // MARK: Table Setup
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partySize ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendTableViewCell
        return cell
    }
    
    

}
