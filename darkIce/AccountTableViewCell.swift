//
//  AccountTableViewCell.swift
//  darkIce
//
//  Created by Scott Murray on 22/6/20.
//  Copyright © 2020 Scott Murray. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var accountBalance: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!
    
    func setupCell(account: Account) {
        switch account.eyeColor {
        case "brown eyes":
            name.textColor = .brown
        case "blue eyes":
            name.textColor = .blue
        case "green eyes":
            name.textColor = .green
        default:
            name.textColor = .black
        }
        name.text = "Name: \(account.name.first) \(account.name.last)"
        age.text = "Age: \(account.age)"
        accountBalance.text = "Balance: \(account.accountBalance)"
        fetchAccountImage(url: account.picture)
    }
    
    func fetchAccountImage(url: String) {
        Helpers.fetchImage(urlString: url) { (image) in
            self.pictureImageView.image = image
        }
    }
}
