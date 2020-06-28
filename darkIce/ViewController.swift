//
//  ViewController.swift
//  darkIce
//
//  Created by Scott Murray on 21/6/20.
//  Copyright © 2020 Scott Murray. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var accounts = [Account]()
    var activeAccounts = [Account]()
    var maleAccounts = [Account]()
    var femaleAccounts = [Account]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Accounts"
        let urlString = "https://darkiceinteractive.com/skillstests/xamarinmobiledeveloper/accounts.json"
        
        loadJson(fromURLString: urlString) { (result) in
            switch result {
            case .success(let data):
                self.parse(jsonData: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
                }
            }
    }
    
    
    private func loadJson(fromURLString urlString: String,
                          completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }

                if let data = data {
                    completion(.success(data))
                }
            }

            urlSession.resume()
        }
    }

    private func parse(jsonData: Data) {
        do {
            accounts = try JSONDecoder().decode([Account].self, from: jsonData)
            sortAndFilter()
        } catch {
            print(error)
        }
    }
    
    func sortAndFilter() {
        activeAccounts = accounts.filter({ $0.isActive == true && $0.isRecent == true })
        activeAccounts.sort {
            if $0.age != $1.age {
                return $0.age > $1.age
            } else {
                return $0.accountBalance < $1.accountBalance
            }
        }
//        checkYear()
        maleAccounts = activeAccounts.filter({ $0.gender == "male"})
        femaleAccounts = activeAccounts.filter({ $0.gender == "female" })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        if section == 0 {
            label.text = "Male Accounts"
            label.backgroundColor = .systemBlue
        } else {
            label.text = "Female Accounts"
            label.backgroundColor = .systemPink
        }
        return label
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return maleAccounts.count
        } else {
            return femaleAccounts.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AccountTableViewCell
        if indexPath.section == 0 {
            cell.setupCell(account: maleAccounts[indexPath.row])
        } else {
            cell.setupCell(account: femaleAccounts[indexPath.row])
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "detailVC"),
            let detailVC = viewController as? DetailViewController else { return }
        if indexPath.section == 0 {
            detailVC.account = maleAccounts[indexPath.row]
        } else {
            detailVC.account = femaleAccounts[indexPath.row]
        }
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
