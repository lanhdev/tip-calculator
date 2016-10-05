//
//  SettingsViewController.swift
//  tipCalculator
//
//  Created by Macintosh on 9/24/16.
//  Copyright © 2016 Lanh Hoang. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var firstField: UITextField!
  @IBOutlet weak var secondField: UITextField!
  @IBOutlet weak var thirdField: UITextField!
  
  @IBOutlet weak var tipPerLabel: UILabel!
  @IBOutlet weak var firstLabel: UILabel!
  @IBOutlet weak var secondLabel: UILabel!
  @IBOutlet weak var thirdLabel: UILabel!
  @IBOutlet weak var themesLabel: UILabel!
  
  @IBOutlet weak var saveLabel: UIButton!
  @IBOutlet weak var defaultLabel: UIButton!
  
  @IBOutlet weak var selectedTheme: UISegmentedControl!
  
  let defaults = UserDefaults.standard
  
  struct data {
    static let defaultPercentages = [15, 20, 25]
    static let lightTextColor = UIColor.red
    static let lightBarColor = UIColor.lightGray
    static let darkTextColor = UIColor.green
    static let darkBarColor = UIColor.darkGray
    static let keyboardType = UIKeyboardType.numberPad
  }
  
  // Setting text field that accept characters only from 0 to 9
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if textField.text == "00" {
      textField.text = "0"
    }
    let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
    return string.rangeOfCharacter(from: invalidCharacters, options: [], range: string.startIndex ..< string.endIndex) == nil
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    firstField.keyboardType = data.keyboardType
    secondField.keyboardType = data.keyboardType
    thirdField.keyboardType = data.keyboardType
    firstField.delegate = self
    secondField.delegate = self
    thirdField.delegate = self
    
    selectedTheme.selectedSegmentIndex = defaults.integer(forKey: "selectedTheme")
    loadTheme()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // Animate ViewController
    self.view.alpha = 0.0
    UIView.animate(withDuration: 0.8) {
      self.view.alpha = 1.0
    }
  }
  
  @IBAction func settingsTap(_ sender: AnyObject) {
    view.endEditing(true)
  }
  
  // Apply user percentage value
  @IBAction func applyButton(_ sender: AnyObject) {
    let firstTip_user = Int(firstField.text!) ?? data.defaultPercentages[0]
    let secondTip_user = Int(secondField.text!) ?? data.defaultPercentages[1]
    let thirdTip_user = Int(thirdField.text!) ?? data.defaultPercentages[2]
    
    defaults.set(firstTip_user, forKey: "firstPercentage")
    defaults.set(secondTip_user, forKey: "secondPercentage")
    defaults.set(thirdTip_user, forKey: "thirdPercentage")
    defaults.synchronize()
  }
  
  // Reset percentage value to default value
  @IBAction func resetButton(_ sender: AnyObject) {
    let firstTip_default = data.defaultPercentages[0]
    let secondTip_default = data.defaultPercentages[1]
    let thirdTip_default = data.defaultPercentages[2]
    
    defaults.set(firstTip_default, forKey: "firstPercentage")
    defaults.set(secondTip_default, forKey: "secondPercentage")
    defaults.set(thirdTip_default, forKey: "thirdPercentage")
    defaults.synchronize()
  }
  
  // Theme selector for SettingsViewController
  func loadTheme() {
    switch selectedTheme.selectedSegmentIndex {
    case 0:
      lightTheme()
    case 1:
      darkTheme()
    default:
      break
    }
    
    defaults.set(selectedTheme.selectedSegmentIndex, forKey: "selectedTheme")
    defaults.synchronize()
  }
  
  // Light theme config
  func lightTheme() {
    UIApplication.shared.statusBarStyle = .default
    navigationController?.navigationBar.barTintColor = data.lightBarColor
    navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: data.lightTextColor]
    view.backgroundColor = UIColor(patternImage: UIImage(named: "light.jpg")!)
    selectedTheme.tintColor = data.lightTextColor
    tipPerLabel.textColor = data.lightTextColor
    firstLabel.textColor = data.lightTextColor
    secondLabel.textColor = data.lightTextColor
    thirdLabel.textColor = data.lightTextColor
    themesLabel.textColor = data.lightTextColor
  }
  
  
  // Dark theme config
  func darkTheme() {
    UIApplication.shared.statusBarStyle = .lightContent
    navigationController?.navigationBar.barTintColor = data.darkBarColor
    navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: data.darkTextColor]
    view.backgroundColor = UIColor(patternImage: UIImage(named: "dark.jpg")!)
    selectedTheme.tintColor = data.darkTextColor
    tipPerLabel.textColor = data.darkTextColor
    firstLabel.textColor = data.darkTextColor
    secondLabel.textColor = data.darkTextColor
    thirdLabel.textColor = data.darkTextColor
    themesLabel.textColor = data.darkTextColor
  }
  
  @IBAction func themesControl(_ sender: UISegmentedControl) {
    loadTheme()
  }
}
