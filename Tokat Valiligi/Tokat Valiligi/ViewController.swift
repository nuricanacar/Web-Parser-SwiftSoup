//
//  AppDelegate.swift
//  Web Parse
//
//  Created by nuricanacar on 14.07.2023.
//

import UIKit
import SwiftSoup

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: "http://www.tokat.gov.tr") else {
            print("Geçersiz URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Hata: \(error)")
                return
            }
            
            if let data = data, let html = String(data: data, encoding: .utf8) {
                do {
                    let doc = try SwiftSoup.parse(html)
                    let p = try doc.select("p").first()
                    if let pText = try p?.text() {
                        DispatchQueue.main.async {
                            print(pText)
                        }
                    }
                } catch let error {
                    print("Hata: \(error)")
                }
            }
        }
        
        task.resume()
    }
}

