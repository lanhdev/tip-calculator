//
//  InitialViewController.swift
//  tipCalculator
//
//  Created by Macintosh on 10/2/16.
//  Copyright © 2016 Lanh Hoang. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
  
  @IBOutlet weak var initialButton: UIButton!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    view.backgroundColor = UIColor(patternImage: UIImage(named: "green.jpg")!)
    self.initialButton.setBackgroundImage(UIImage(named: "money.png"), for: UIControlState.normal)
    self.initialButton.alpha = 0.0
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
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    UIButton.animate(withDuration: 3, delay: 1, options: .curveEaseIn, animations: {
      self.initialButton.alpha = 1.0
      }) { (true) in
        print ("Completed")
    }
  }
  
}
