//
//  MiddleView.swift
//  Pool Scoreboard
//
//  Created by HarveyHu on 29/12/2016.
//  Copyright © 2016 HarveyHu. All rights reserved.
//

import UIKit

class MiddleView: UIView {

    let titleView = UIView()
    let titleTextField = UITextField()
    let scoreView = UIView()
    
    let score0Label = MiddleView.makeScoreLabel(text: "0")
    let score1Label = MiddleView.makeScoreLabel(text: "1")
    let score2Label = MiddleView.makeScoreLabel(text: "2")
    let score3Label = MiddleView.makeScoreLabel(text: "3")
    let score4Label = MiddleView.makeScoreLabel(text: "4")
    let score5Label = MiddleView.makeScoreLabel(text: "5")
    let score6Label = MiddleView.makeScoreLabel(text: "6")
    let score7Label = MiddleView.makeScoreLabel(text: "7")
    let score8Label = MiddleView.makeScoreLabel(text: "8")
    let score9Label = MiddleView.makeScoreLabel(text: "9")
    let score10Label = MiddleView.makeScoreLabel(text: "10")
    let score11Label = MiddleView.makeScoreLabel(text: "11")
    let score12Label = MiddleView.makeScoreLabel(text: "12")
    let score13Label = MiddleView.makeScoreLabel(text: "13")
    let score14Label = MiddleView.makeScoreLabel(text: "14")
    
    static func makeScoreLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28.0)
        return label
    }
    
    convenience init(title: String) {
        self.init(frame: CGRect.zero)
        self.titleTextField.text = title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleView.addSubview(titleTextField)
        self.addSubview(titleView)
        self.addSubview(scoreView)
        
        self.scoreView.addSubview(score0Label)
        self.scoreView.addSubview(score1Label)
        self.scoreView.addSubview(score2Label)
        self.scoreView.addSubview(score3Label)
        self.scoreView.addSubview(score4Label)
        self.scoreView.addSubview(score5Label)
        self.scoreView.addSubview(score6Label)
        self.scoreView.addSubview(score7Label)
        self.scoreView.addSubview(score8Label)
        self.scoreView.addSubview(score9Label)
        self.scoreView.addSubview(score10Label)
        self.scoreView.addSubview(score11Label)
        self.scoreView.addSubview(score12Label)
        self.scoreView.addSubview(score13Label)
        self.scoreView.addSubview(score14Label)
        
        titleView.backgroundColor = UIColor.black
        scoreView.backgroundColor = UIColor.black
        
        titleTextField.textAlignment = .center
        titleTextField.textColor = UIColor.white
        titleTextField.font = UIFont.systemFont(ofSize: 32.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(28)
            make.leading.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(15.0 / 1)
        }
        
        scoreView.snp.makeConstraints { (make) in
            make.top.equalTo(titleView.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalTo(self.snp.bottom).offset(-20)
        }
        
        titleTextField.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        setScoreLabelsConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setScoreLabelsConstraints() {
        score0Label.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(15.0)
        }
        
        score1Label.snp.makeConstraints { (make) in
            make.top.equalTo(score0Label.snp.bottom)
            make.leading.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(15.0)
        }
        
        score2Label.snp.makeConstraints { (make) in
            make.top.equalTo(score1Label.snp.bottom)
            make.leadingMargin.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(15.0)
        }
        
        score3Label.snp.makeConstraints { (make) in
            make.top.equalTo(score2Label.snp.bottom)
            make.leadingMargin.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(15.0)
        }
        
        score4Label.snp.makeConstraints { (make) in
            make.top.equalTo(score3Label.snp.bottom)
            make.leadingMargin.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(15.0)
        }
        
        score5Label.snp.makeConstraints { (make) in
            make.top.equalTo(score4Label.snp.bottom)
            make.leadingMargin.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(15.0)
        }
        
        score6Label.snp.makeConstraints { (make) in
            make.top.equalTo(score5Label.snp.bottom)
            make.leadingMargin.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(15.0)
        }
        
        score7Label.snp.makeConstraints { (make) in
            make.top.equalTo(score6Label.snp.bottom)
            make.leadingMargin.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(15.0)
        }
        
        score8Label.snp.makeConstraints { (make) in
            make.top.equalTo(score7Label.snp.bottom)
            make.leadingMargin.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(15.0)
        }
        
        score9Label.snp.makeConstraints { (make) in
            make.top.equalTo(score8Label.snp.bottom)
            make.leadingMargin.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(15.0)
        }
        
        score10Label.snp.makeConstraints { (make) in
            make.top.equalTo(score9Label.snp.bottom)
            make.leadingMargin.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(15.0)
        }
        
        score11Label.snp.makeConstraints { (make) in
            make.top.equalTo(score10Label.snp.bottom)
            make.leadingMargin.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(15.0)
        }
        
        score12Label.snp.makeConstraints { (make) in
            make.top.equalTo(score11Label.snp.bottom)
            make.leadingMargin.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(15.0)
        }
        
        score13Label.snp.makeConstraints { (make) in
            make.top.equalTo(score12Label.snp.bottom)
            make.leadingMargin.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(15.0)
        }
        
        score14Label.snp.makeConstraints { (make) in
            make.top.equalTo(score13Label.snp.bottom)
            make.leadingMargin.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(15.0)
        }
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
