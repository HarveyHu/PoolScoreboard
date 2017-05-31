//
//  ScoreboardViewController.swift
//  Pool Scoreboard
//
//  Created by HarveyHu on 28/12/2016.
//  Copyright © 2016 HarveyHu. All rights reserved.
//

import UIKit

class ScoreboardViewController: BaseViewController {
    let leftView = SideView(title: "A")
    let middleView = MiddleView(title: "Score")
    let rightView = SideView(title: "B")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func setUI() {
        super.setUI()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(leftView)
        self.view.addSubview(rightView)
        self.view.addSubview(middleView)
        
        
        
        let diameter = self.view.frame.width / 15.0
        
        let keyYellow = "yellow"
        let keyRed = "red"
        let userDefault = UserDefault()
        
        for index in 0...5 {
            var magnetFrame = CGRect.zero
            if let list = userDefault.magnetPositionList, let x = list["\(keyYellow)\(index)"]?[0], let y = list["\(keyYellow)\(index)"]?[1] {
                magnetFrame = CGRect(x: x - diameter / 2, y: y - diameter / 2, width: diameter, height: diameter)
            } else {
                magnetFrame = CGRect(x: diameter * CGFloat(index) * 2 + diameter, y: diameter * 2, width: diameter, height: diameter)
            }
            let magnet = MagnetView(color: UIColor.yellow, frame: magnetFrame, parentView: self.view, id: "\(keyYellow)\(index)")
            
            self.view.addSubview(magnet)
        }
        
        for index in 0..<2 {
            var magnetFrame = CGRect.zero
            if let list = userDefault.magnetPositionList, let x = list["\(keyRed)\(index)"]?[0], let y = list["\(keyRed)\(index)"]?[1] {
                magnetFrame = CGRect(x: x - diameter / 2, y: y - diameter / 2, width: diameter, height: diameter)
            } else {
                magnetFrame = CGRect(x: diameter * CGFloat(index) * 10 + diameter, y: self.view.frame.size.height - diameter * 4, width: diameter, height: diameter)
            }
            let magnet = MagnetView(color: UIColor.red, frame: magnetFrame, parentView: self.view, id: "\(keyRed)\(index)")
            self.view.addSubview(magnet)
        }
    }
    
    override func setUIConstraints() {
        super.setUIConstraints()
        
        leftView.snp.makeConstraints { (make) in
            make.leadingMargin.equalToSuperview()
            make.bottomMargin.equalToSuperview()
            make.topMargin.equalToSuperview()
            make.width.equalToSuperview().dividedBy(3.3)
        }
        
        rightView.snp.makeConstraints { (make) in
            make.trailingMargin.equalToSuperview()
            make.bottomMargin.equalTo(leftView)
            make.topMargin.equalTo(leftView)
            make.width.equalToSuperview().dividedBy(3.3)
        }
        
        middleView.snp.makeConstraints { (make) in
            make.leading.equalTo(leftView.snp.trailing).offset(8)
            make.trailing.equalTo(rightView.snp.leading).offset(-8)
            make.topMargin.equalTo(leftView)
            make.bottomMargin.equalTo(leftView)
        }
    }
    override func setUIEvents() {
        super.setUIEvents()
    }
    
}

