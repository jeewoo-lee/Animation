
import Foundation
import CanvasGraphics

class Sketch : NSObject {
    
    // NOTE: Every sketch must contain an object of type Canvas named 'canvas'
    //       Therefore, the line immediately below must always be present.
    let canvas: Canvas
    
    // Tortoise to draw with
    let turtle: Tortoise
    let secondTurtle: Tortoise
    let thirdTurtle: Tortoise
    let fourthTurtle: Tortoise
    let fifthTurtle: Tortoise
    let sixthTurtle: Tortoise
    let seventhTurtle: Tortoise
    
    // L-systems
//    let anotherKochConstruction: LindenmayerSystem
//    let kochIsland: LindenmayerSystem
    let coniferousTree: LindenmayerSystem
//    let genericSystem: LindenmayerSystem
    let lightningBolt: LindenmayerSystem
//    let myLSystem: LindenmayerSystem
    let mitsubishi: LindenmayerSystem
    
    
    // This function runs once
    override init() {
        
        // Create canvas object – specify size
        canvas = Canvas(width: 500, height: 500)
        
        // Draw slowly
        //canvas.framesPerSecond = 1
        
        // Create turtles to draw with
        turtle = Tortoise(drawingUpon: canvas)
        secondTurtle = Tortoise(drawingUpon: canvas)
        thirdTurtle = Tortoise(drawingUpon: canvas)
        fourthTurtle = Tortoise(drawingUpon: canvas)
        fifthTurtle = Tortoise(drawingUpon: canvas)
        sixthTurtle = Tortoise(drawingUpon: canvas)
        seventhTurtle = Tortoise(drawingUpon: canvas)
        
        // Create two deterministic systems
//        anotherKochConstruction = LindenmayerSystem(axiom: "S-F",
//                                                    length: 100,
//                                                    initialDirection: 0,
//                                                    angle: 90,
//                                                    reduction: 3,
//                                                    rules: ["F": [RuleSet(odds: 1, successorText: "F+F-F-F+F")] ],
//                                                    generations: 4,
//                                                    pointToStartRenderingFrom: Point(x: 250, y: 100),
//                                                    turtleToRenderWith: turtle)
//
//        kochIsland = LindenmayerSystem(axiom: "SF-F-F-F",
//                                       length: 50,
//                                       initialDirection: 0,
//                                       angle: 90,
//                                       reduction: 3.75,
//                                       rules: ["F": [RuleSet(odds: 1, successorText: "F-F+F+FF-F-F+F")]],
//                                       generations: 3,
//                                       pointToStartRenderingFrom: Point(x: 0, y: 100),
//                                       turtleToRenderWith: secondTurtle)
//
//        genericSystem = LindenmayerSystem(axiom: "SF+F+F+F",
//                                          length: 50,
//                                          initialDirection: 90,
//                                          angle: 90,
//                                          reduction: 4,
//                                          rules: [
//
//                                                  "F" : [RuleSet(odds: 1, successorText: "F+f-FF+F+FF+Ff+FF-f+FF-F-FF-Ff-FFF")],
//                                                  "f" : [RuleSet(odds: 1, successorText: "ffffff")]
//
//                                                  ],
//                                          generations: 2,
//                                          pointToStartRenderingFrom: Point(x: 50, y: 50),
//                                          turtleToRenderWith: fourthTurtle)
//
        // Create a stochastic system
        coniferousTree = LindenmayerSystem(axiom: "SF",
                            length: 20,
                            initialDirection: 270,
                            angle: 21,
                            reduction: 1.25,
                            rules: ["F": [
                                         RuleSet(odds: 1, successorText: "3F[++1F[X]][+2F][-4F][--5F[X]]6F"),
                                         RuleSet(odds: 1, successorText: "3F[+1F][+2F][-4F]5F"),
                                         RuleSet(odds: 1, successorText: "3F[+1F][-2F][--6F]4F"),
                                         ],
                                    "X": [
                                         RuleSet(odds: 1, successorText: "X")
                                         ]
                                   ],
                            generations: 5,
                            pointToStartRenderingFrom: Point(x: 150, y: 400),
                            turtleToRenderWith: thirdTurtle, hue: [120,134,145,135,116,151], saturation: [100,97,87,84,26,71], brightness: [61,46,8,41,100,53])
        
        lightningBolt = LindenmayerSystem(axiom: "S1F",
                                                 length: 100,
                                                 initialDirection: 270,
                                                 angle: 15,
                                                 reduction: 1.7,
                                                 rules: ["F": [
                                                              RuleSet(odds: 1, successorText: "X+F[+++F]"),
                                                              RuleSet(odds: 1, successorText: "Y-F"),
                                                              RuleSet(odds: 1, successorText: "FF[---F]"),
                                                              ],
                                                         "X": [
                                                              RuleSet(odds: 1, successorText: "F-X"),
                                                              RuleSet(odds: 1, successorText: "XX[+++F--F]")
                                                              ],
                                                         "Y": [
                                                              RuleSet(odds: 1, successorText: "F+Y[--F]"),
                                                              RuleSet(odds: 1, successorText: "F+Y[++F-F]"),
                                                              RuleSet(odds: 1, successorText: "YY")
                                                              ]

                                                        ],
                                                 generations: 6,
                                                 pointToStartRenderingFrom: Point(x: 250, y: 470),
                                                 turtleToRenderWith: fifthTurtle,
                                                 hue: [206],
                                                 saturation: [14],
                                                 brightness: [97])
        
//        myLSystem = LindenmayerSystem(axiom: "S2[-F]++[F]++[F][--F]++[F]++[F][--F]++[F]++[F]",
//                                            length: 50,
//                                            initialDirection: 45,
//                                            angle: 30,
//                                            reduction: 2,
//                                            rules: ["F": [
//                                                         RuleSet(odds: 1, successorText: "[F+F-FF+F-F]")
//                                                         ]
//
//                                                   ],
//                                            generations: 3,
//                                            pointToStartRenderingFrom: Point(x: 250, y: 250),
//                                            turtleToRenderWith: sixthTurtle)
        
        mitsubishi = LindenmayerSystem(axiom: "S1F++F++F++",
                                               length: 50,
                                               initialDirection: 60,
                                               angle: 60,
                                               reduction: 2,
                                               rules: ["F": [
                                                            RuleSet(odds: 1, successorText: "F+F--F+F")
                                                            ]

                                                      ],
                                               generations: 3,
                                               pointToStartRenderingFrom: Point(x: 80, y: 150),
                                               turtleToRenderWith: seventhTurtle,
                                               hue: [0],
                                               saturation: [70],
                                               brightness: [100])
                                            
        // DEBUG:
        print("Rendering:")
        
    }
    
    // This function runs repeatedly, forever, to create the animated effect
    func draw() {
        
        // Update rendering of all systems for the current frame of the animation
//        kochIsland.update(forFrame: canvas.frameCount)
//        anotherKochConstruction.update(forFrame: canvas.frameCount)
        
       

        coniferousTree.update(forFrame: canvas.frameCount)
        lightningBolt.update(forFrame: canvas.frameCount)
        mitsubishi.update(forFrame: canvas.frameCount)

    }
    
}
