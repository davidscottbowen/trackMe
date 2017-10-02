//
//  HomeViewController.swift
//  trackMe
//
//  Created by David Bowen on 10/1/17.
//  Copyright © 2017 David Bowen. All rights reserved.
//

import UIKit
import MapKit
import KeychainSwift

class HomeViewController: UIViewController {
    
    @IBOutlet weak var outputDisplay: UITextView!
    
    
    let keychain = KeychainSwift()


    override func viewDidLoad() {
        super.viewDidLoad()
        var saved = keychain.get("my key")
        if saved == nil {
            print("No saved data")
            saved = "No saved data"
        } else {
            print(String(describing: saved))
        }
        
        outputDisplay.text = String(describing: saved!)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
