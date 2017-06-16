//
//  PoolTableViewController.swift
//  Pool Scoreboard
//
//  Created by HarveyHu on 15/06/2017.
//  Copyright © 2017 HarveyHu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PoolTableViewController: BaseViewController {
    let backgroundView = UIView()
    let imageView = UIImageView()
    let resetButton = UIButton()
    var ball: Ball?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setUI() {
        super.setUI()
        self.view.addSubview(backgroundView)
        backgroundView.addSubview(imageView)
        backgroundView.addSubview(resetButton)
        
        self.view.backgroundColor = UIColor.white
        self.backgroundView.backgroundColor = UIColor.black
        imageView.image = UIImage(named: "pool_table")
        
        self.resetButton.setTitle("RESET", for: .normal)
        self.resetButton.setBackgroundImage(UIColor.gray.tinyImage(), for: .normal)
        self.resetButton.setBackgroundImage(UIColor.darkGray.tinyImage(), for: .selected)
        self.resetButton.layer.cornerRadius = 10
        self.resetButton.layer.masksToBounds = true
        self.resetButton.layer.borderWidth = 2
        self.resetButton.layer.borderColor = UIColor.red.cgColor
        
        let height = self.view.frame.size.height
        ball = Ball(diameter: Double(height) / 40.0)
        for ballView in ball!.ballViews {
            ballView.frame = ball!.getLocation(number: ballView.tag)
            self.backgroundView.addSubview(ballView)
        }
    }
    
    override func setUIConstraints() {
        super.setUIConstraints()
        
        backgroundView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.9)
            make.width.equalTo(self.imageView.snp.height).multipliedBy(857.0 / 1564) // the ratio of the image
        }
        
        resetButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20.0)
            make.bottom.equalTo(imageView.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.05)
            make.trailing.equalTo(imageView.snp.leading).offset(-20)
        }
    }
    
    override func setUIEvents() {
        super.setUIEvents()
        
        if let ball = self.ball {
            for ballView in ball.ballViews {
                self.addPanGestureToBalls(view: ballView, diameter: ball.diameter)
            }
        }
        
        resetButton.rx.tap.asDriver()
        .drive(onNext: {[weak self] in
            self?.ball?.resetLocations()
            for ballView in self!.ball!.ballViews {
                ballView.frame = self!.ball!.getLocation(number: ballView.tag)
            }
        }, onCompleted: nil, onDisposed: nil)
        .addDisposableTo(disposeBag)
    }
    

    private func addPanGestureToBalls(view: UIView, diameter: Double) {
        let panGR = UIPanGestureRecognizer()
        panGR.rx.event.asDriver().drive(onNext: {[weak self](pan) in
            if pan.state == .changed || pan.state == .ended {
                let radius = CGFloat(diameter / 2)
                let offset = pan.translation(in: pan.view!)
                let x = view.center.x + offset.x
                let y = view.center.y + offset.y
                let parentViewFrame = self!.view.frame
                let tabbarHeight: CGFloat = 49.0
                
                let rightLimit = parentViewFrame.size.width - radius
                let bottomLimit = parentViewFrame.size.height - radius - tabbarHeight
                
                if x >= radius && x <= rightLimit
                {
                    if y < radius {
                        view.center = CGPoint(x: x, y: radius)
                    } else if y > bottomLimit {
                        view.center = CGPoint(x: x, y: bottomLimit)
                    } else {
                        view.center = CGPoint(x: x, y: y)
                    }
                } else {
                    if y < radius {
                        view.center = CGPoint(x: x < radius ? radius : rightLimit, y: radius)
                    } else if y > bottomLimit {
                        view.center = CGPoint(x: x < radius ? radius : rightLimit, y: bottomLimit)
                    } else {
                        view.center = CGPoint(x: x < radius ? radius : rightLimit, y: y)
                    }
                }
                pan.setTranslation(CGPoint(x:0, y:0), in: pan.view!)
                
                // keep the last position to userDefault
                if pan.state == .ended {
                    self?.ball?.updateLocation(number: view.tag, frame: view.frame)
                }
            }
            }, onCompleted: nil, onDisposed: nil)
            .addDisposableTo(disposeBag)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(panGR)
    }

}
