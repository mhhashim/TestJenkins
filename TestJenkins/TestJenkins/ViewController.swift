//
//  ViewController.swift
//  TestJenkins
//
//  Created by Hashim MH on 09/01/19.
//  Copyright © 2019 Hashim M H. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss a"
        timeLabel.text = "\(formatter.string(from: date))"
        versionLabel.text = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    }

}

