//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Pujita Tipnis on 3/12/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit

class SnapsViewController: UIViewController {

    @IBOutlet weak var logoutButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        // Dismiss the view controller (the first screen) that
        // was presented modally by the view controller
        dismiss(animated: true, completion: nil)
    }


}
