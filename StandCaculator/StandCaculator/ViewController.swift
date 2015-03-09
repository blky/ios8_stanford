//
//  ViewController.swift
//  StandCaculator
//
//  Created by Cindy Zheng on 3/5/15.
//  Copyright (c) 2015 Cindy Z. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsIntheMiddleofTypingANumber = false
    var operandStack = [Double]()
    var operatorStack = [String]()
    
    
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        println("digit is \(digit)")
        
        if userIsIntheMiddleofTypingANumber {
            display.text = display.text! + digit

        } else {
            display.text = digit
            userIsIntheMiddleofTypingANumber = true
        }
        
    }
    
    @IBAction func enter() {
        
        userIsIntheMiddleofTypingANumber = false
        operandStack.append(self.displayValue)
        println("operandStack is \(operandStack)")
        
    }
    
    @IBAction func Operate(sender: UIButton) {
        if userIsIntheMiddleofTypingANumber {
            enter()
        }
        
        let operation = sender.currentTitle!
        
        println("operation is \(operation)")
        
        switch operation {
        case "✖️": performOperation { $0 * $1 }
        case "➗":performOperation { $1 / $0 }
        case "➕":performOperation { $0 + $1 }
        case "➖":performOperation { $1 - $0 }
        case "➰": performOperation {sqrt($0)}
            
        default: break

        }
    
    }
    
    func performOperation (operation: (Double,Double)-> Double) {
        if operandStack.count >= 2 {
            displayValue = operation( operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation (operation:  Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation( operandStack.removeLast() )
            enter()
        }
    }
    
    var displayValue:Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsIntheMiddleofTypingANumber = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }

}

