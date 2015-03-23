//
//  CaculatorBrain.swift
//  mySTCalculator
//
//  Created by Cindy Zheng on 3/22/15.
//  Copyright (c) 2015 Cindy Z. All rights reserved.
//

import Foundation
class CaculatorBrain{
    
  
    enum Op : Printable {
        case Operand (Double)
        case UnaryOperation ( String, Double ->Double)
        case BinaryOperation (String, (Double,Double) -> Double)
        
        var description:String {
            get {
                switch self {
                case .Operand(let operand): return "\(operand)"
                case .UnaryOperation(let symbol,_ ): return symbol
                case .BinaryOperation(let symbol,_): return symbol
                }
            }
           
        }
    }

    private var optStack = [Op]()
    
    //can be public later for other to add more opeartion in the future,but so far let it be private
    private var knownOps =  [String:Op]()
    
    init(){
        func learningOp(op:Op){
            knownOps[op.description] = op
        }
        learningOp(Op.BinaryOperation("+", +))
        learningOp(Op.BinaryOperation("×", *))
        learningOp(Op.BinaryOperation("÷") { $1/$0})
        learningOp(Op.BinaryOperation("-"){ $1-$0})
        learningOp(Op.UnaryOperation("√", sqrt))
            
                
                
//        knownOps["+"] =  Op.BinaryOperation( "+", + )
//        knownOps["-"] =  Op.BinaryOperation( "+" ){$1-$0}
//        knownOps["×"] =  Op.BinaryOperation( "×", * )
//        knownOps["÷"] =  Op.BinaryOperation( "÷" ) { $1/$0}
        knownOps["√"] = Op.UnaryOperation("√", sqrt)
    }
    
    func pushOperand (operand:Double) -> Double? {
        optStack.append(Op.Operand(operand))
        
        return evaluate()
    }
    
    func performOperation(symbol:String) -> Double? {
        if let operation = knownOps[symbol] {
            optStack.append(operation)
        }
       return evaluate()
    }

    private func evaluation(ops:[Op]) ->(result: Double?,remainingOps:[Op]) {
            if !ops.isEmpty {
            var remainOps = ops  // to make a pass by value array mutable.
            let op = remainOps.removeLast()
                switch op {
                case .Operand(let operand): return (operand,remainOps)
                    
                case .UnaryOperation(_, let operation):
                    let operandEvaluation = evaluation(remainOps)
                    if let operand = operandEvaluation.result {
                        return (operation(operand),operandEvaluation.remainingOps)
                    }
                case .BinaryOperation(_,let operation):
                    let opt1Evaluate = evaluation(remainOps)
                    if let operand1 = opt1Evaluate.result {
                        let opt2Evaluate = evaluation(opt1Evaluate.remainingOps)
                        if let operand2 = opt2Evaluate.result {
                            return ( operation (operand1,operand2) ,  opt2Evaluate.remainingOps)
                        }
                    }
                }
                
        }
        
     
        return (nil, ops)
    }
    
    func evaluate()-> Double? {
        
        let (result,remainder) = evaluation(optStack)
        println("\(optStack) result \(result) = \(remainder) left over")
        return result
        
    }

}




