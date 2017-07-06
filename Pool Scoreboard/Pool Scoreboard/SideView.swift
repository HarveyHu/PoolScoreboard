//
//  SideView.swift
//  Pool Scoreboard
//
//  Created by HarveyHu on 29/12/2016.
//  Copyright © 2016 HarveyHu. All rights reserved.
//

import UIKit

class SideView: UIView {
    let titleView = UIView()
    let titleTextField = UITextField()
    let accumulationView = UIView()
    let foulView = UIView()
    let foulLabel = UILabel()
    let deducedScoreView = UIView()
    
    let accu00Label = SideView.makeAccuLabel(text: "00")
    let accu11Label = SideView.makeAccuLabel(text: "11")
    let accu22Label = SideView.makeAccuLabel(text: "22")
    let accu33Label = SideView.makeAccuLabel(text: "33")
    let accu44Label = SideView.makeAccuLabel(text: "44")
    let accu55Label = SideView.makeAccuLabel(text: "55")
    let accu66Label = SideView.makeAccuLabel(text: "66")
    let accu77Label = SideView.makeAccuLabel(text: "77")
    let accu88Label = SideView.makeAccuLabel(text: "88")
    let accu99Label = SideView.makeAccuLabel(text: "99")
    let foul0Label = SideView.makeFoulLabel(text: "0")
    let foul1Label = SideView.makeFoulLabel(text: "1")
    let foul2Label = SideView.makeFoulLabel(text: "2")
    let foul3Label = SideView.makeFoulLabel(text: "3")
    
    static func makeAccuLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28.0)
        return label
    }
    
    static func makeFoulLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = UIColor.red
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
        self.addSubview(accumulationView)
        foulView.addSubview(foulLabel)
        self.addSubview(foulView)
        self.addSubview(deducedScoreView)
        
        self.accumulationView.addSubview(accu00Label)
        self.accumulationView.addSubview(accu11Label)
        self.accumulationView.addSubview(accu22Label)
        self.accumulationView.addSubview(accu33Label)
        self.accumulationView.addSubview(accu44Label)
        self.accumulationView.addSubview(accu55Label)
        self.accumulationView.addSubview(accu66Label)
        self.accumulationView.addSubview(accu77Label)
        self.accumulationView.addSubview(accu88Label)
        self.accumulationView.addSubview(accu99Label)
        
        self.deducedScoreView.addSubview(foul0Label)
        self.deducedScoreView.addSubview(foul1Label)
        self.deducedScoreView.addSubview(foul2Label)
        self.deducedScoreView.addSubview(foul3Label)
        
        titleView.backgroundColor = UIColor.black
        accumulationView.backgroundColor = UIColor.black
        foulView.backgroundColor = UIColor.black
        deducedScoreView.backgroundColor = UIColor.black
        
        titleTextField.textAlignment = .center
        titleTextField.textColor = UIColor.white
        titleTextField.font = UIFont.systemFont(ofSize: 36.0)
        titleTextField.adjustsFontSizeToFitWidth = true
        
        foulLabel.text = "Foul"
        foulLabel.textAlignment = .center
        foulLabel.textColor = UIColor.white
        foulLabel.font = UIFont.systemFont(ofSize: 30.0)
        foulLabel.adjustsFontSizeToFitWidth = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(28)
            make.leadingMargin.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(15.0 / 1)
        }
        
        accumulationView.snp.makeConstraints { (make) in
            make.top.equalTo(titleView.snp.bottom).offset(8)
            make.leadingMargin.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalTo(foulView.snp.top).offset(-8)
        }
        
        foulView.snp.makeConstraints { (make) in
            make.leadingMargin.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(15.0 / 1)
            make.bottom.equalTo(deducedScoreView.snp.top).offset(-8)
        }
        
        deducedScoreView.snp.makeConstraints { (make) in
            make.leadingMargin.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(15.0 / 3)
            make.bottom.equalTo(self.snp.bottom).offset(-20)
        }
        
        titleTextField.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        foulLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        setAccuLabelsConstraints()
        
        setFoulLabelsConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAccuLabelsConstraints() {
        accu00Label.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(10.0)
        }
        
        accu11Label.snp.makeConstraints { (make) in
            make.top.equalTo(accu00Label.snp.bottom)
            make.leading.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(10.0)
        }
        
        accu22Label.snp.makeConstraints { (make) in
            make.top.equalTo(accu11Label.snp.bottom)
            make.leadingMargin.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(10.0)
        }
        
        accu33Label.snp.makeConstraints { (make) in
            make.top.equalTo(accu22Label.snp.bottom)
            make.leadingMargin.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(10.0)
        }
        
        accu44Label.snp.makeConstraints { (make) in
            make.top.equalTo(accu33Label.snp.bottom)
            make.leadingMargin.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(10.0)
        }
        
        accu55Label.snp.makeConstraints { (make) in
            make.top.equalTo(accu44Label.snp.bottom)
            make.leadingMargin.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(10.0)
        }
        
        accu66Label.snp.makeConstraints { (make) in
            make.top.equalTo(accu55Label.snp.bottom)
            make.leadingMargin.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(10.0)
        }
        
        accu77Label.snp.makeConstraints { (make) in
            make.top.equalTo(accu66Label.snp.bottom)
            make.leadingMargin.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(10.0)
        }
        
        accu88Label.snp.makeConstraints { (make) in
            make.top.equalTo(accu77Label.snp.bottom)
            make.leadingMargin.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(10.0)
        }
        
        accu99Label.snp.makeConstraints { (make) in
            make.top.equalTo(accu88Label.snp.bottom)
            make.leadingMargin.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(10.0)
        }
    }
    
    func setFoulLabelsConstraints() {
        foul0Label.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(4.0)
        }
        
        foul1Label.snp.makeConstraints { (make) in
            make.top.equalTo(foul0Label.snp.bottom)
            make.leading.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(4.0)
        }
        
        foul2Label.snp.makeConstraints { (make) in
            make.top.equalTo(foul1Label.snp.bottom)
            make.leading.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(4.0)
        }
        
        foul3Label.snp.makeConstraints { (make) in
            make.top.equalTo(foul2Label.snp.bottom)
            make.leading.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(4.0)
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
