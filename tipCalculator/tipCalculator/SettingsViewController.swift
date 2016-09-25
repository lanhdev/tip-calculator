//
//  SettingsViewController.swift
//  tipCalculator
//
//  Created by Macintosh on 9/24/16.
//  Copyright © 2016 Lanh Hoang. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var firstField: UITextField!
    @IBOutlet weak var secondField: UITextField!
    @IBOutlet weak var thirdField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    @IBAction func settingsTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    struct dataArray {
        static let defaultPercentages = [15, 20, 25]
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
    
    @IBAction func saveButton(_ sender: AnyObject) {
        let firstTip_user = Int(firstField.text!) ?? dataArray.defaultPercentages[0]
        let secondTip_user = Int(secondField.text!) ?? dataArray.defaultPercentages[1]
        let thirdTip_user = Int(thirdField.text!) ?? dataArray.defaultPercentages[2]
        
        let defaults = UserDefaults.standard
        defaults.set(firstTip_user, forKey: "firstPercentage")
        defaults.set(secondTip_user, forKey: "secondPercentage")
        defaults.set(thirdTip_user, forKey: "thirdPercentage")
        defaults.synchronize()
    }
    
    @IBAction func defaultButton(_ sender: AnyObject) {
        let firstTip_default = dataArray.defaultPercentages[0]
        let secondTip_default = dataArray.defaultPercentages[1]
        let thirdTip_default = dataArray.defaultPercentages[2]
        
        let defaults = UserDefaults.standard
        defaults.set(firstTip_default, forKey: "firstPercentage")
        defaults.set(secondTip_default, forKey: "secondPercentage")
        defaults.set(thirdTip_default, forKey: "thirdPercentage")
        defaults.synchronize()
    }
    
}
