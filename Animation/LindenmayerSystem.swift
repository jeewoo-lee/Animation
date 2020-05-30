//
//  LindenmayerSystem.swift
//  Animation
//
//  Created by Russell Gordon on 2020-05-22.
//  Copyright © 2020 Royal St. George's College. All rights reserved.
//

import Foundation
import CanvasGraphics

struct RuleSet {
    let odds: Int
    let successorText: String
}

struct LindenmayerSystem {
    
    // Definition of system
    let axiom: String
    let length: Double
    let initialDirection: Degrees
    let angle: Degrees
    let reduction: Double
    let rules: [Character:[RuleSet]]
    let generations: Int
    let pointToStartRenderingFrom: Point
    let hue: [Int]
    let saturation: [Int]
    let brightness: [Int]
   
    
    // Rendering state
    var word: String = ""
    var currentLength: Double = 0
    
    // Turtle to draw with
    let t: Tortoise
    
    init(axiom: String, length: Double, initialDirection: Degrees, angle: Degrees, reduction: Double, rules: [Character:[RuleSet]], generations: Int, pointToStartRenderingFrom: Point, turtleToRenderWith: Tortoise, hue: [Int], saturation: [Int], brightness: [Int]) {
        
        self.axiom = axiom
        self.length = length
        self.initialDirection = initialDirection
        self.angle = angle
        self.reduction = reduction
        self.rules = rules
        self.generations = generations
        self.pointToStartRenderingFrom = pointToStartRenderingFrom
        self.t = turtleToRenderWith
        
        self.hue = hue
        self.saturation = saturation
        self.brightness = brightness
        
        // Set up the system state
        word = axiom
        currentLength = length
        
        // Re-write the word for each generation
        for generation in 1...generations {
            
            // Create an empty new word
            var newWord = ""
            
            // Inspect each character of the old word
            for character in word {
                
                // Iterate over all the rules
                var match = false
                for (predecessor, successorRuleSet) in rules {
                    
                    // When a character matches, apply the rule
                    if predecessor == character {
                        
                        // Determine total of odds in RuleSet
                        var total = 0
                        for successorRule in successorRuleSet {
                            total += successorRule.odds
                        }
                        
                        // Generate a random integer between 1 and the total odds
                        let randomValue = Int.random(in: 1...total)
                        
                        // Find the rule to apply
                        var runningTotal = 0
                        for successorRule in successorRuleSet {
                            runningTotal += successorRule.odds
                            
                            // See if this is the rule to apply
                            if randomValue <= runningTotal {
                                
                                // Re-write the word based on selected rule
                                newWord.append(successorRule.successorText)
                                match = true
                                break // end the loop looking for a rule to apply
                            }
                        }
                        
                    }
                    
                }
                
                // If no match to rules, just copy the character to the new word
                if match == false {
                    newWord.append(character)
                }
                
            }
            
            // Replace the old word with the new word
            word = newWord
            print("After generation \(generation) the word is:")
            print(word)
            
            // Reduce the line length after generation 1
            if generation > 1 {
                currentLength /= reduction
            }
            
        }
        
    }
    
    // Render the next character of the system using the turtle provided
    func update(forFrame currentFrame: Int) {
        
        // Save current state of the canvas so that next L-system has "clean slate" to work with
        t.saveStateOfCanvas()
        
        // Required to bring canvas into same orientation and origin position as last run of draw() function for this turtle
        t.restoreStateOnCanvas()

        // Render the alphabet of the L-system
        if currentFrame < word.count {
            
            // Get an index for the current chracter in the axiom
            let index = word.index(word.startIndex, offsetBy: currentFrame)
            let character = word[index]
            
            // DEBUG: What character is being rendered?
            print(character, terminator: "")
            
            // Render based on this character
            switch character {
            case "S":
                t.penUp()
                t.setPosition(to: pointToStartRenderingFrom)
                t.left(by: initialDirection)
                t.penDown()
            case "F", "X":
                t.penDown()
                t.forward(steps: currentLength)
            case "f":
                t.penUp()
                t.forward(steps: currentLength)
            case "+":
                t.right(by: angle)
            case "-":
                t.left(by: angle)
            case "[":
                t.saveState()
            case "]":
                t.restoreState()
            case "1":
                t.setPenColor(to: Color(hue: hue[0], saturation: saturation[0], brightness: brightness[0], alpha: 100))
            case "2":
                t.setPenColor(to: Color(hue: hue[1], saturation: saturation[1], brightness: brightness[1], alpha: 100))
            case "3":
                t.setPenColor(to: Color(hue: hue[2], saturation: saturation[2], brightness: brightness[2], alpha: 100))
//            case "4":
//                t.setPenColor(to: Color(hue: hueArray[3], saturation: saturationArray[3], brightness: brightnessArray[3], alpha: 100))
//            case "5":
//                t.setPenColor(to: Color(hue: hueArray[4], saturation: saturationArray[4], brightness: brightnessArray[4], alpha: 100))
//            case "6":
//                t.setPenColor(to: Color(hue: hueArray[5], saturation: saturationArray[5], brightness: brightnessArray[5], alpha: 100))
//            case "7":
//                t.setPenColor(to: Color(hue: hueArray[6], saturation: saturationArray[6], brightness: brightnessArray[6], alpha: 100))
//            case "8":
//                t.setPenColor(to: Color(hue: hueArray[7], saturation: saturationArray[7], brightness: brightnessArray[7], alpha: 100))
//            case "9":
//                t.setPenColor(to: Color(hue: hueArray[8], saturation: saturationArray[8], brightness: brightnessArray[8], alpha: 100))
            default:
                break
            }
            
        }
        
        // Save state of the canvas so that next L-system has "clean slate" to work with
        t.restoreStateOfCanvas()
        
    }
    
}
