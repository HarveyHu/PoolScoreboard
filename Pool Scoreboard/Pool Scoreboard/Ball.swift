//
//  Ball.swift
//  Pool Scoreboard
//
//  Created by HarveyHu on 15/06/2017.
//  Copyright © 2017 HarveyHu. All rights reserved.
//

import UIKit
import RxCocoa

class Ball {
    var ballViews: Array<UIView>
    let diameter: Double
    let gap = Double(UIScreen.main.bounds.height / 50)
    init(diameter: Double) {
        ballViews = Array<UIView>()
        self.diameter = diameter
        
        self.ballViews = self.setupBallViews()
    }
    
    private func setupBallViews() -> Array<UIView> {
        var newViews = Array<UIView>()
        for index in 0...15 {
            let ballView = createBallView(number: index)
            ballView.tag = index
            newViews.append(ballView)
        }
        return newViews
    }
    
    private func createBallView(number: Int) -> UIView {
        let ballView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: diameter, height: diameter))
        ballView.layer.cornerRadius = CGFloat(diameter / 2)
        ballView.layer.masksToBounds = true
        if number < 9 {
            ballView.backgroundColor = getColorFromNumber(number: number)
        } else {
            ballView.backgroundColor = UIColor.white
        }
        
        let centerView = UIView(frame: CGRect(x: diameter * 0.2, y: 0.0, width: diameter * 0.6, height: diameter))
        ballView.addSubview(centerView)
        centerView.backgroundColor = getColorFromNumber(number: number)
        
        let circleLable = UILabel(frame: CGRect(x: diameter * 0.2, y: diameter * 0.2, width: diameter * 0.6, height: diameter * 0.6))
        circleLable.text = number == 0 ? "": "\(number)"
        circleLable.adjustsFontSizeToFitWidth = true
        circleLable.textAlignment = .center
        circleLable.layer.cornerRadius = CGFloat(diameter * 0.6 / 2)
        circleLable.layer.masksToBounds = true
        circleLable.backgroundColor = UIColor.white
        ballView.addSubview(circleLable)
        
        return ballView
    }
    
    private func getColorFromNumber(number: Int) -> UIColor {
        switch number {
        case 0:
            return UIColor.white
        case 1, 9:
            return UIColor.yellow
        case 2, 10:
            return UIColor.blue
        case 3, 11:
            return UIColor.red
        case 4, 12:
            return UIColor.purple
        case 5, 13:
            return UIColor.orange
        case 6, 14:
            return UIColor.grassGreen()
        case 7, 15:
            return UIColor.lightBlue()
        case 8:
            return UIColor.black
        default:
            break
        }
        return UIColor.white
    }
    
    func getLocation(number: Int) -> CGRect {
        let userDefault = UserDefault()
        var ballFrame = CGRect.zero
        if let list = userDefault.ballPositionList, let x = list["\(number)"]?[0], let y = list["\(number)"]?[1] {
            ballFrame = CGRect(x: x - diameter / 2, y: y - diameter / 2, width: diameter, height: diameter)
        } else {
            ballFrame = CGRect(x: gap + diameter, y: (diameter + gap) * Double(number + 1), width: diameter, height: diameter)
        }
        return ballFrame
    }
    
    func updateLocation(number: Int, frame: CGRect) {
        var userDefault = UserDefault()
        if userDefault.ballPositionList == nil {
            userDefault.ballPositionList = ["\(number)": [Double(frame.origin.x) + diameter / 2, Double(frame.origin.y) + diameter / 2]]
        } else {
            userDefault.ballPositionList?["\(number)"] = [Double(frame.origin.x) + diameter / 2, Double(frame.origin.y) + diameter / 2]
        }
    }
    
    func resetLocations() {
        
        for number in 0...15 {
            let ballFrame = CGRect(x: gap + diameter, y: (diameter + gap) * Double(number + 1), width: diameter, height: diameter)
            updateLocation(number: number, frame: ballFrame)
        }
    }
}
