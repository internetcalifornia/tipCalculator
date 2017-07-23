//
//  PartyViewController.swift
//  tipCalculator
//
//  Created by Scott Eremia-Roden on 7/19/17.
//  Copyright © 2017 kitsunebokkusu. All rights reserved.
//

import UIKit
import MessageUI
import Messages

class PartyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, MFMessageComposeViewControllerDelegate {
    
    
    
    
    
    var partySize: Int?
    var friends: [Friend]? = []

    @IBOutlet weak var partyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        partyTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadFriends()
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
            vc.navigationItem.title = "Person"
            vc.previousVC = self
            // set the index to the correct row so we know which friend's data to load
            if let index = partyTableView.indexPathForSelectedRow {
                vc.friendIndex = index
            }
            
            
        }
    }
 
    
    // MARK: Friend Data Loading
    
    func loadFriends() {
        let total = self.partyTableView.numberOfRows(inSection: 0)
        for row in 0...total {
            //print("row is: \(row)")
            let index = IndexPath(row: row, section: 0)
            //print("this is the index \(index)")
            guard let friend = Friend.loadFriendData(friendIndex: index) else {
                //print("exit scope of loading friends")
                return
            }
            
            self.friends?.append(friend)
        }
        
        
    }
    
    // MARK: Table Setup
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partySize ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (partySize ?? 0) > 0 {
            return "Party"
        }
        return ""
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let tipView = self.parent?.childViewControllers[0] as? TipViewController else {
            return
        }
        //print("touchedOutside")
        tipView.billAmountField.endEditing(true)
        tipView.billAmountField.resignFirstResponder()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as? FriendTableViewCell else {
            return UITableViewCell()
        }
        guard let tipViewController = self.parent?.childViewControllers[0] as? TipViewController else {
            print("no parent controller as TipViewController")
            return cell
        }
        let rows = partyTableView.numberOfRows(inSection: 0)
        let number = indexPath.row + 1
        if let friend = Friend.loadFriendData(friendIndex: indexPath) {
            let firstName = friend.firstName
            let lastName = friend.lastName
            cell.friendLabel.text = "\(firstName) \(lastName)"
            if friend.phoneNumber == nil {
                print("hide button")
                cell.sendMessageButton.isHidden = true
            } else {
                cell.sendMessageButton.isHidden = false
            }
        } else {
            cell.friendLabel.text = "Person #\(number)"
            cell.sendMessageButton.isHidden = true
        }
        
        
        
        guard let tipTotal = tipViewController.bill?.tipAmount else {
            cell.friendTipLabel.text = "$0.00"
            return cell
        }
        let splitTipDouble = tipTotal / Double(rows)
        cell.friendTipLabel.text = String(format: "$%.2f", splitTipDouble)
        
        
        
        
        
        //print("phone number for this person = \(friend.phoneNumber)")
        
        
        
        return cell
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        //print("result for this controller is /n /n /n /n /n \(String(describing: result))")
        switch (result) {
            case MessageComposeResult.cancelled: self.dismiss(animated: true, completion: nil)
            case MessageComposeResult.failed: print(MessageComposeResult.failed.rawValue); self.dismiss(animated: true, completion: nil)
            case MessageComposeResult.sent: self.dismiss(animated: true) { print("success") }
        }
    }
    
    @IBAction func SendMessage(sender: Any) {
        guard let cell = (sender as AnyObject).superview??.superview as? FriendTableViewCell else {
            return // or fatalError() or whatever
        }
        
        let indexPath = partyTableView.indexPath(for: cell)
        //print("selected \(indexPath) from the button!")
        let messageViewController = MFMessageComposeViewController()
        
        
        messageViewController.messageComposeDelegate = self
        guard let tipViewController = self.parent?.childViewControllers[0] as? TipViewController else {
            print("no parent controller as TipViewController")
            return
        }
        guard let totalTipValue = tipViewController.bill?.tipAmount else {
            return
        }
        //print("Yay so far")
        let portionOfTip = totalTipValue / Double(self.partySize ?? 1)
        let tipInDollar = String(format: "$%.2f", portionOfTip)
        messageViewController.body = "Your portion of the meal is \(tipInDollar)"
        if let recipient = Friend.loadFriendData(friendIndex: indexPath)?.phoneNumber {
            print("no phone for friend")
            messageViewController.recipients = [recipient]
        }
        
        
        self.present(messageViewController, animated: true, completion: nil)
        
        
    }
    
    

}
