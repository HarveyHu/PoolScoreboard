//
//  MagnetView.swift
//  Pool Scoreboard
//
//  Created by HarveyHu on 29/12/2016.
//  Copyright © 2016 HarveyHu. All rights reserved.
//

import UIKit
import RxSwift

class MagnetView: UIView {
    let disposeBag = DisposeBag()
    static func makeScoreLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28.0)
        return label
    }
    
    convenience init(color: UIColor, frame: CGRect, parentView: UIView, id: String) {
        self.init(frame: frame)
        self.backgroundColor = color
        self.layer.cornerRadius = frame.width / 2.0
        self.layer.masksToBounds = true
        let parentViewFrame = parentView.frame
        let tabbarHeight: CGFloat = 49.0
        
        let panGR = UIPanGestureRecognizer()
        panGR.rx.event.asDriver().drive(onNext: {[weak self](pan) in
            if pan.state == .changed || pan.state == .ended {
                let radius = frame.size.width / 2
                let offset = pan.translation(in: pan.view!)
                let x = self!.center.x + offset.x
                let y = self!.center.y + offset.y
                let rightLimit = parentViewFrame.size.width - radius
                let bottomLimit = parentViewFrame.size.height - radius - tabbarHeight
                
                if x >= radius && x <= rightLimit
                    {
                        if y < radius {
                            self!.center = CGPoint(x: x, y: radius)
                        } else if y > bottomLimit {
                            self!.center = CGPoint(x: x, y: bottomLimit)
                        } else {
                            self!.center = CGPoint(x: x, y: y)
                        }
                } else {
                    if y < radius {
                        self!.center = CGPoint(x: x < radius ? radius : rightLimit, y: radius)
                    } else if y > bottomLimit {
                        self!.center = CGPoint(x: x < radius ? radius : rightLimit, y: bottomLimit)
                    } else {
                        self!.center = CGPoint(x: x < radius ? radius : rightLimit, y: y)
                    }
                }
                pan.setTranslation(CGPoint(x:0, y:0), in: pan.view!)
                
                // keep the last position to userDefault
                if pan.state == .ended {
                    var userDefault = UserDefault()
                    if userDefault.magnetPositionList == nil {
                        userDefault.magnetPositionList = ["\(id)": [self!.center.x, self!.center.y]]
                    } else {
                        userDefault.magnetPositionList?["\(id)"] = [self!.center.x, self!.center.y]
                    }
                }
            }
            }, onCompleted: nil, onDisposed: nil)
            .addDisposableTo(disposeBag)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(panGR)
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
