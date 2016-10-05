//
//  ViewController.swift
//  tipCalculator
//
//  Created by Macintosh on 9/21/16.
//  Copyright © 2016 Lanh Hoang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var billField: UITextField!
  @IBOutlet weak var tipCalcLabel: UILabel!
  @IBOutlet weak var totalCalcLabel: UILabel!
  @IBOutlet weak var billLabel: UILabel!
  @IBOutlet weak var tipLabel: UILabel!
  @IBOutlet weak var totalLabel: UILabel!
  @IBOutlet weak var tipControl: UISegmentedControl!
  @IBOutlet weak var numPeopleControl: UIStepper!
  @IBOutlet weak var numPeopleCalcLabel: UILabel!
  @IBOutlet weak var amountPersonCalcLabel: UILabel!
  @IBOutlet weak var numPeopleLabel: UILabel!
  @IBOutlet weak var amountPersonLabel: UILabel!
  
  let defaults = UserDefaults.standard
  let calendar = Calendar.current
  let unitFlags = Set<Calendar.Component>([.year, .month, .day, .hour, .minute, .second])
  
  struct data {
    static var defaultPercentages = [0.15, 0.2, 0.25]
    static var billFieldData = ""
    static let lightTextColor = UIColor.red
    static let lightBarColor = UIColor.lightGray
    static let darkTextColor = UIColor.green
    static let darkBarColor = UIColor.darkGray
  }
  
  // Setting text field
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if textField.text == "00" {
      textField.text = "0"
    }
    let invalidCharacters = CharacterSet(charactersIn: "0123456789.").inverted
    return string.rangeOfCharacter(from: invalidCharacters, options: [], range: string.startIndex ..< string.endIndex) == nil
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    billField.keyboardType = UIKeyboardType.decimalPad
    billField.becomeFirstResponder()
    billField.delegate = self
    
    numPeopleControl.autorepeat = true
    numPeopleControl.wraps = true
    numPeopleControl.minimumValue = 1
    numPeopleControl.maximumValue = 10

    let currentTime = NSDate()
    let prevTime = defaults.object(forKey: "quitAppTime") as? Date ?? currentTime as Date
    let diffTime = calendar.dateComponents(unitFlags, from: prevTime as Date,  to: currentTime as Date)
    numPeopleCalcLabel.text = "1"
    
    if Int(diffTime.minute!) <= 10 {
      billField.text = defaults.string(forKey: "billFieldPrevData") ?? ""
    } else {
      billField.text = ""
    }
    calculateTip()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // Animate ViewController
    self.view.alpha = 0.0
    UIView.animate(withDuration: 0.8) {
      self.view.alpha = 1.0
    }
    
    // Load percentage value that user save in Settings
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
    
    data.defaultPercentages = [firstTip_ratio, secondTip_ratio, thirdTip_ratio]
    
    calculateTip()
    
    // Theme selector for ViewController
    let selectedTheme = defaults.integer(forKey: "selectedTheme")
    switch selectedTheme {
    case 0:
      lightTheme()
    case 1:
      darkTheme()
    default:
      break
    }
  }
  
  // Light theme config
  func lightTheme() {
    UIApplication.shared.statusBarStyle = .default
    navigationController?.navigationBar.barTintColor = data.lightBarColor
    navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: data.lightTextColor]
    view.backgroundColor = UIColor(patternImage: UIImage(named: "light.jpg")!)
    tipControl.tintColor = data.lightTextColor
    numPeopleControl.tintColor = data.lightTextColor
    billLabel.textColor = data.lightTextColor
    tipLabel.textColor = data.lightTextColor
    totalLabel.textColor = data.lightTextColor
    tipCalcLabel.textColor = data.lightTextColor
    totalCalcLabel.textColor = data.lightTextColor
    numPeopleCalcLabel.textColor = data.lightTextColor
    amountPersonCalcLabel.textColor = data.lightTextColor
    numPeopleLabel.textColor = data.lightTextColor
    amountPersonLabel.textColor = data.lightTextColor
  }
  
  // Dark theme config
  func darkTheme() {
    UIApplication.shared.statusBarStyle = .lightContent
    navigationController?.navigationBar.barTintColor = data.darkBarColor
    navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: data.darkTextColor]
    view.backgroundColor = UIColor(patternImage: UIImage(named: "dark.jpg")!)
    tipControl.tintColor = data.darkTextColor
    numPeopleControl.tintColor = data.darkTextColor
    billLabel.textColor = data.darkTextColor
    tipLabel.textColor = data.darkTextColor
    totalLabel.textColor = data.darkTextColor
    tipCalcLabel.textColor = data.darkTextColor
    totalCalcLabel.textColor = data.darkTextColor
    numPeopleCalcLabel.textColor = data.darkTextColor
    amountPersonCalcLabel.textColor = data.darkTextColor
    numPeopleLabel.textColor = data.darkTextColor
    amountPersonLabel.textColor = data.darkTextColor
  }
  
  // Tap to screen to hide keyboard
  @IBAction func onTap(_ sender: AnyObject) {
    view.endEditing(true)
  }
  
  // Calculate total tip and tip amount per person
  func calculateTip() {
    let tipPercentages = data.defaultPercentages
    
    let bill = Double(billField.text!) ?? 0
    let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
    let total = bill + tip
    let numPeople = numPeopleControl.value
    let amountPerson = total / numPeople
    
    let tipFormat = NumberFormatter()
    tipFormat.numberStyle = .currency
    tipFormat.locale = NSLocale.current
    tipFormat.groupingSeparator = ","
    tipFormat.decimalSeparator = "."
    tipFormat.usesGroupingSeparator = true
    tipFormat.minimumFractionDigits = 2
    tipFormat.minimumIntegerDigits = 1
    
    tipCalcLabel.text = tipFormat.string(from: NSNumber(value: tip))
    totalCalcLabel.text = tipFormat.string(from: NSNumber(value: total))
    amountPersonCalcLabel.text = tipFormat.string(from: NSNumber(value: amountPerson))
    numPeopleCalcLabel.text = String(format: "%d", Int(numPeople))
  }
  
  // Display calculated tip
  @IBAction func tipDisplay (_ sender: AnyObject) {
    data.billFieldData = billField.text!
    calculateTip()
  }
  
}

