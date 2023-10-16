//
//  Robot.swift
//  RobotProblem
//
//  Created by Amar Singh on 15/10/23.
//

import Foundation
/*
 
            NORTH
 
            xy(0,0)--------------->
            |
            |
 WEST       |                  EAST
            |
            |
            |
            V
            SOUTH
 
 The four possible directions that the robot can face: north, south, east, and west.
 For example, if the robot is facing north and it rotates right, it will now be facing east. If the robot is facing east and it rotates left, it will now be facing north.
 We can use this graph to visualize the robot's direction and to understand how the rotation commands work.
 */

class Robot {
    var x: Int = 0
    var y: Int = 0
    var face: Direction = .none
    var onTable: Bool = false
    
    init(x: Int, y: Int) throws {
        guard !(x < 0 || x >= 5 || y < 0 || y >= 5) else {
            throw RobotError.invalid_init_position
            
        }
        self.x = x
        self.y = y
    }
    
    func place(x: Int, y: Int, face: Direction) throws {
        guard !(x < 0 || x >= 5 || y < 0 || y >= 5) else {
            throw RobotError.invalid_place
        }
        self.x = x
        self.y = y
        self.face = face
        self.onTable = true
    }
    
    func move() throws {
        //south west is origin (0, 0)
        var newX = 0
        var newY = 0
        switch face {
        case .east:
            newX = x + 1
            newY = y
        case .west:
            newX = x - 1
            newY = y
        case .north:
            newX = x
            newY = y + 1
        case .south:
            newX = x
            newY = y - 1
        case .none:
            break
        }
        
        guard !(newX < 0 || newX >= 5 || newY < 0 || newY >= 5) else {
            throw RobotError.invalid_move
        }
        x = newX
        y = newY
    }
    
    func turnLeft() {
        face = face.turnLeft()
    }
    
    func turnRight() {
        face = face.turnRight()
    }
    
    func report() -> (x: Int, y: Int, face: Direction) {
        return (x, y, face)
    }
    
    func execute(command: String, completion: @escaping ((x: Int, y: Int, face: Direction)?, RobotError?) -> (Void)) throws {
        let commandComponents = command.split(separator: " ")
        guard let commandType = commandComponents.first else {
            completion(nil, RobotError.invalid_command)
            return
        }
        if commandType != "place" {
            guard onTable == true else {
                completion(nil, RobotError.robot_not_placed)
                return
            }
        }
        switch commandType.lowercased() {
        case "place":
            guard commandComponents.count > 3 else {
                completion(nil, RobotError.invalid_command)
                return
            }
            let x = Int(commandComponents[1]) ?? 0
            let y = Int(commandComponents[2]) ?? 0
            let direction = Direction(rawValue: String(commandComponents[3])) ?? .none
            guard direction != .none else {
                completion(nil, RobotError.invalid_direction)
                return
            }
            
            try place(x: x, y: y, face: direction)
            let report = report()
            completion(report, nil)
        case "move":
            try move()
            let report = report()
            completion(report, nil)
        case "left":
            turnLeft()
            let report = report()
            completion(report, nil)
        case "right":
            turnRight()
            let report = report()
            completion(report, nil)
        case "report":
            let report = report()
            completion(report, nil)
        default:
            completion(nil, RobotError.invalid_command)
            return
        }
    }
}
