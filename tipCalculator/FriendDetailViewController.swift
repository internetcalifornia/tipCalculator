//
//  FriendDetailViewController.swift
//  tipCalculator
//
//  Created by Scott Eremia-Roden on 7/19/17.
//  Copyright © 2017 kitsunebokkusu. All rights reserved.
//

import UIKit

class FriendDetailViewController: UIViewController, UINavigationControllerDelegate {
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    
    var friendIndex: IndexPath?
    weak var previousVC: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadFriend()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if (self.isMovingFromParentViewController) {
            guard let partyVC = previousVC as? PartyViewController else {
                print("didn't work :(")
                return
            }
            partyVC.partyTableView.reloadData()
        }
    }
    
    func loadFriend() {
        let friend = Friend.loadFriendData(friendIndex: self.friendIndex)
        //print(self.friendIndex ?? "no index")
        self.firstNameField.text = friend?.firstName
        self.lastNameField.text = friend?.lastName
        self.phoneNumberField.text = friend?.phoneNumber
        self.navigationItem.title = "\(friend?.firstName ?? "Friend") \(friend?.lastName ?? "")"
        if self.navigationItem.title == "" {
            self.navigationItem.title = "Friend"
        }
    }
    
    @IBAction func saveFriend() {
        let index = self.friendIndex
        let firstName = self.firstNameField.text
        let lastName = self.lastNameField.text
        var phoneNumber = self.phoneNumberField.text
        if phoneNumber == "" {
            phoneNumber = nil
        }
        Friend.saveFriendData(forIndex: index, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
        
    }
    
    
    
    
    
    
    

}
