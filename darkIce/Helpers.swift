//
//  Helpers.swift
//  darkIce
//
//  Created by Scott Murray on 23/6/20.
//  Copyright © 2020 Scott Murray. All rights reserved.
//

import Foundation
import UIKit

class Helpers {
    static func fetchImage(urlString:String,completion:@escaping (UIImage?)->()) {
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }).resume()
    }
}
