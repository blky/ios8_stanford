//
//  ViewController.swift
//  mySTCalculator
//
//  Created by Cindy Zheng on 3/9/15.
//  Copyright (c) 2015 Cindy Z. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var brain = CaculatorBrain()
    
    @IBOutlet weak var display: UILabel!
    
    var UserIsTypeNumbers = false
    var operandStack = [Double]()
    
    @IBAction func appendDigit(sender: UIButton) {
        if UserIsTypeNumbers == true {
            display.text = display.text! + sender.currentTitle!
            
        } else {
            display.text = sender.currentTitle
            UserIsTypeNumbers = true
        }
        
    }
  
    @IBAction func operate(sender: UIButton) {
       
        
        if UserIsTypeNumbers == true {
             enter()
        }
        if let operation =  sender.currentTitle  {
            if let result = brain.performOperation(operation) {
                displayResult = result
            } else {
                displayResult = 0
            }
        }
    }
    
   
    
    @IBAction func enter() {
        UserIsTypeNumbers = false
        if let result = brain.pushOperand(displayResult) {
            displayResult = result
        } else {
            displayResult = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

  
    var displayResult:Double {
        
        get {
//            return NSString(string: display.text!).doubleValue
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue

        }
        set {
            display.text = "\(newValue) "
        }
    }

}

