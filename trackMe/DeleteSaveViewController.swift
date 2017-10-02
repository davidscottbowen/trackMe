//
//  DeleteSaveViewController.swift
//  trackMe
//
//  Created by David Bowen on 10/2/17.
//  Copyright © 2017 David Bowen. All rights reserved.
//

import UIKit
import KeychainSwift

class DeleteSaveViewController: UIViewController {
    
    let keychain = KeychainSwift()

    override func viewDidLoad() {
        super.viewDidLoad()
        keychain.delete("my key")

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
