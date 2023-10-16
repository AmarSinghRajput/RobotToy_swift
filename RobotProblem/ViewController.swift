//
//  ViewController.swift
//  RobotProblem
//
//  Created by Amar Singh on 15/10/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    private var robot: Robot?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try self.robot = Robot(x: 0, y: 0)
        } catch {
            textView.text = "Error: \(error.localizedDescription)"
        }
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        guard let command = textField.text else { return }
        let commandArray = command.components(separatedBy: " ")
        var executable = [String]()
        var temp = [String]()
        for i in 0..<commandArray.count {
            if commandArray[i] == "place" || temp.count != 0 {
                temp.append(commandArray[i])
                if temp.count == 4 {
                    executable.append(temp.joined(separator: " "))
                    temp.removeAll()
                }
            } else {
                executable.append(commandArray[i])
            }
        }
        guard let robot = robot else { return }
        do {
            for filteredCommand in executable {
                try robot.execute(command: filteredCommand, completion: { report, error in
                    if let error = error {
                        self.textView.text = "Error: \(error.rawValue)"
                    }else {
                        guard let currentReport = report else { return }
                        self.textView.text = "Robot at: X Y (\(currentReport.x),\(currentReport.y)), Direction \(currentReport.face)"
                    }
                })
            }
        } catch {
            textView.text = "Error: \((error as! RobotError).rawValue)"
        }
    }    
}

