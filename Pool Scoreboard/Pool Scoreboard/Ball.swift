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
    let touchDiameter: Double
    init(diameter: Double, touchDiameter: Double) {
        ballViews = Array<UIView>()
        self.diameter = diameter
        self.touchDiameter = touchDiameter
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
        let touchView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: touchDiameter, height: touchDiameter))
        touchView.bounds = touchView.frame
        touchView.backgroundColor = UIColor.clear
        
        let ballView = UIView()
        touchView.addSubview(ballView)
        
        // Size needs to be set up before Center, otherwise, Origin will be set as the same point as Center.
        ballView.frame.size = CGSize(width: diameter, height: diameter)
        ballView.center = CGPoint(x: touchView.bounds.width / 2, y: touchView.bounds.height / 2)
        
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
        
        return touchView
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
    
    func getLocationCenterPoint(number: Int) -> CGPoint {
        let userDefault = UserDefault()
        var centerPoint = CGPoint.zero
        if let list = userDefault.ballPositionList, let x = list["\(number)"]?[0], let y = list["\(number)"]?[1] {
            centerPoint = CGPoint(x: x, y: y)
        } else {
            centerPoint = CGPoint(x: gap + diameter, y: (diameter + gap) * Double(number + 1))
        }
        return centerPoint
    }
    
    func updateLocation(number: Int, center: CGPoint) {
        var userDefault = UserDefault()
        if userDefault.ballPositionList == nil {
            userDefault.ballPositionList = ["\(number)": [Double(center.x), Double(center.y)]]
        } else {
            userDefault.ballPositionList?["\(number)"] = [Double(center.x), Double(center.y)]
        }
    }
    
    func resetLocations() {
        
        for number in 0...15 {
            let ballCenter = CGPoint(x: gap + diameter, y: (diameter + gap) * Double(number + 1))
            updateLocation(number: number, center: ballCenter)
        }
    }
}
