//
//  Error.swift
//  RobotProblem
//
//  Created by Amar Singh on 15/10/23.
//

import Foundation

enum RobotError: String, Error {
    case invalid_place = "invalid place specified"
    case invalid_init_position = "invalid position"
    case invalid_command = "invalid command"
    case invalid_direction = "invalid direction"
    case robot_not_placed = "robot not placed on table"
    case invalid_move = "invalid move command, ROBOT WILL FALL!, please change robot direction"
}
