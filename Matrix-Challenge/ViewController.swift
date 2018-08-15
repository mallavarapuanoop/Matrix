//
//  ViewController.swift
//  Matrix-Challenge
//
//  Created by Anoop Mallavarapu on 8/15/18.
//  Copyright © 2018 AnoopMallavarapu. All rights reserved.
//

import UIKit

struct GetPosition{               // declaring struct with row and column as properties
    
    var row: Int
    var column: Int
    
}

class ViewController: UIViewController {
    
    @IBOutlet weak var EnterValForMatrix: UILabel!
    
    @IBOutlet weak var NumOfRow: UILabel!
    
    @IBOutlet weak var NumOfCol: UILabel!
    
    @IBOutlet weak var CostPath: UILabel!
    
    @IBOutlet weak var DisplayCost: UILabel!
    
    @IBOutlet weak var RowValue: UITextField!
    
    @IBOutlet weak var ColValue: UITextField!
    
    @IBOutlet weak var CostLessThann50: UILabel!
    
    @IBOutlet weak var YESorNO: UILabel!
    
    @IBOutlet weak var ElementsVisited: UILabel!
    
    
    var rowValue: Int = 0
    var ColumnValue: Int  = 0
    var matrix = [[Int]]()                                 // declaring an empty matrix i.e arrays of array
    var elementsInPath = [Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func EnterButon(_ sender: UIButton) {
        
        RowValue.resignFirstResponder()
        ColValue.resignFirstResponder()
        guard let rowText = Int(RowValue.text!) else {
            EnterValForMatrix.textColor = UIColor.red
            return}
        
        guard let colText = Int(ColValue.text!) else {
            EnterValForMatrix.textColor = UIColor.red
            return}
        EnterValForMatrix.textColor = UIColor.black
        // Enter the row value
        rowValue = rowText//Int(RowValue.text!)!
        // enter the column value
        ColumnValue = colText//Int(ColValue.text!)!
        
        
        // matrix with random numbers
        matrix = [[Int]](repeating: [Int](repeating: 0, count: ColumnValue), count: rowValue)
        
        for i in 0...rowValue-1
        {
            for j in 0...ColumnValue-1
            {
                matrix[i][j] = Int(arc4random_uniform(15))
            }
        }
        
        print(matrix)
        matrixFun()           //function
        elementsInPath.removeAll()
    }
    
    
    @IBAction func ClearButton(_ sender: UIButton) {
        
        
        RowValue.text = ""
        ColValue.text = ""
        DisplayCost.text = ""
        YESorNO.text = ""
        elementsInPath.removeAll()
        ElementsVisited.text = ""
        
        
    }
    
    func matrixFun()
    {
        // declaring the three variables
        var FirstPosition = GetPosition(row: 0, column: 0)
        var secondPosition = GetPosition(row: 0, column: 0)
        var thirdPosition = GetPosition(row: 0, column: 0)
        
        var currentPosition = GetPosition(row: 0, column: 0)        // declaring the 1st position
        
        var cost: Int = 0                                        //  declaring a variable for storing cost
        
        for elements in 0..<(matrix[0].count - 1)              // iterating through the loop for number of columns count -1
        {
            
            var ColumnArray = [Int]()                      // declaring an empty array
            
            
            if currentPosition.column == 0{              // loops only once has the column value changes after 1st iteration
                
                for x in matrix
                {
                    
                    ColumnArray.append(x[elements])          // appending the first elements of matrix array at row 0 in columnarray; iterates until loop ends
                    
                }
                let small = ColumnArray.min()              // finding the minimum value in columnarray
                
                elementsInPath.append(small!)
                cost = cost+small!                     // assigning the cost with the element
                
                // if the cost is more than 50 execution stops
                if cost >= 50
                {
                    DisplayCost.text = String(cost)
                    YESorNO.text = " YES "
                    break
                }
                else{
                    YESorNO.text = " NO "
                }
                
                currentPosition.row = ColumnArray.index(of: small!)!   // updating the row position
                print(currentPosition)                                // now the current position is at minimum value in first columns array
                
            }
            
            
            if currentPosition.row == 0                             // enters this block if the element's row value is 0
            {
                // three possible positions it can move next
                FirstPosition = GetPosition(row: currentPosition.row, column: currentPosition.column + 1)
                
                secondPosition = GetPosition(row: currentPosition.row + 1, column: currentPosition.column + 1)
                
                thirdPosition = GetPosition(row: matrix.count-1, column: currentPosition.column + 1)
                
            }
            else if currentPosition.row == matrix.count-1          // enters this block if the element's row value is 1 less than matrix.count
            {
                // three possible positions it can move next
                FirstPosition = GetPosition(row: currentPosition.row - 1, column: currentPosition.column + 1)
                
                secondPosition = GetPosition(row: currentPosition.row, column: currentPosition.column + 1)
                
                thirdPosition = GetPosition(row: 0, column: currentPosition.column + 1)
            }
                
            else{                                                // if either the case it enters this block of code
                
                // three possible positions it can move next
                FirstPosition = GetPosition(row: currentPosition.row - 1, column: currentPosition.column + 1)
                
                secondPosition = GetPosition(row: currentPosition.row, column: currentPosition.column + 1)
                
                thirdPosition = GetPosition(row: currentPosition.row + 1, column: currentPosition.column + 1)
            }
            
            // the elements at the respective indexes
            let ElementOne = matrix[FirstPosition.row][FirstPosition.column]
            let ElementTwo = matrix[secondPosition.row][secondPosition.column]
            let ElementThree = matrix[thirdPosition.row][thirdPosition.column]
            
            // comparing the elements and the least element will be assigned to row
            if ElementOne < ElementTwo && ElementOne < ElementThree{
                currentPosition.column = currentPosition.column + 1           // column is just incremented with 1
                currentPosition.row = FirstPosition.row
                elementsInPath.append(ElementOne)
                cost = cost+ElementOne
            }
            else if ElementTwo < ElementOne && ElementTwo < ElementThree{
                currentPosition.column = currentPosition.column + 1
                currentPosition.row = secondPosition.row
                elementsInPath.append(ElementTwo)
                cost = cost+ElementTwo
            }
            else{
                currentPosition.column = currentPosition.column + 1
                currentPosition.row = thirdPosition.row
                elementsInPath.append(ElementThree)
                cost = cost+ElementThree
                
            }
            
            print(currentPosition)                           // updating the position
            ElementsVisited.text = "\(elementsInPath)"
            print(elementsInPath)
            if cost >= 50                                   // checking if the cost is more than 50
            {
                DisplayCost.text = String(cost)
                YESorNO.text = " YES "
                break
            }
            else{
                YESorNO.text = " NO "
            }
            DisplayCost.text = String(cost)
            
        }
    }
    
}
