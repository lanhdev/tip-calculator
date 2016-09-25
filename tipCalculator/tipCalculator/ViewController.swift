//
//  ViewController.swift
//  tipCalculator
//
//  Created by Macintosh on 9/21/16.
//  Copyright © 2016 Lanh Hoang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    struct dataArray {
        static var defaultPercentages = [0.15, 0.2, 0.25]
    }
    
    //override func viewWillAppear(_ animated: Bool) {
    //    super.viewWillAppear(animated)
    //}
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let defaults = UserDefaults.standard
        let firstTip_value = defaults.integer(forKey: "firstPercentage")
        let secondTip_value = defaults.integer(forKey: "secondPercentage")
        let thirdTip_value = defaults.integer(forKey: "thirdPercentage")
        
        let firstTip_ratio = Double(firstTip_value) * 0.01
        let secondTip_ratio = Double(secondTip_value) * 0.01
        let thirdTip_ratio = Double(thirdTip_value) * 0.01
        
        let firstTip_text = String(format: "%d%%", firstTip_value)
        let secondTip_text = String(format: "%d%%", secondTip_value)
        let thirdTip_text = String(format: "%d%%", thirdTip_value)
        
        tipControl.setTitle(firstTip_text, forSegmentAt: 0)
        tipControl.setTitle(secondTip_text, forSegmentAt: 1)
        tipControl.setTitle(thirdTip_text, forSegmentAt: 2)
        
        dataArray.defaultPercentages = [firstTip_ratio, secondTip_ratio, thirdTip_ratio]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        let tipPercentages = dataArray.defaultPercentages
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }

}

