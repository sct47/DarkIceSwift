//
//  DetailViewController.swift
//  darkIce
//
//  Created by Scott Murray on 22/6/20.
//  Copyright © 2020 Scott Murray. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var account: Account?

    override func viewDidLoad() {
        super.viewDidLoad()
        populateFields()
        title = "Account Details"
    }
    
    func populateFields() {
        guard let account = account else { return }
        nameLabel.text = "Name: \(account.name.first) \(account.name.last)"
        balanceLabel.text = "Account Balance: \(account.accountBalance)"
        Helpers.fetchImage(urlString: account.picture) { (image) in
            self.imageView.image = image
        }
    }
}
