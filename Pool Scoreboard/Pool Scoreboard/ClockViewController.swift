//
//  ClockViewController.swift
//  Pool Scoreboard
//
//  Created by HarveyHu on 12/01/2017.
//  Copyright © 2017 HarveyHu. All rights reserved.
//

import UIKit

class ClockViewController: BaseViewController {
    let stopwatchView = UIView()
    let clockLabel = UILabel()
    let startButton = UIButton()
    let stopButton = UIButton()
    let extensionButton = UIButton()
    let viewModel = ClockViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        clockLabel.layer.cornerRadius = clockLabel.frame.size.width / 2.0
        clockLabel.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func setUI() {
        super.setUI()
        self.view.addSubview(stopwatchView)
        self.stopwatchView.addSubview(clockLabel)
        self.stopwatchView.addSubview(startButton)
        self.stopwatchView.addSubview(stopButton)
        self.stopwatchView.addSubview(extensionButton)
        
        self.view.backgroundColor = UIColor.white
        self.stopwatchView.backgroundColor = UIColor.black
        
        
        clockLabel.text = "\(viewModel.countdownSeconds)"
        clockLabel.textAlignment = .center
        clockLabel.textColor = UIColor.themeOrange()
        clockLabel.font = UIFont.boldSystemFont(ofSize: 100.0)
        clockLabel.layer.borderWidth = 10.0
        clockLabel.layer.borderColor = UIColor.white.cgColor
        clockLabel.layer.masksToBounds = true
        
        startButton.setTitle("START", for: .normal)
        startButton.setTitleColor(UIColor.white, for: .normal)
        startButton.setTitleColor(UIColor.orange, for: .highlighted)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 30.0)
        
        stopButton.setTitle("STOP", for: .normal)
        stopButton.titleLabel?.font = UIFont.systemFont(ofSize: 30.0)
        stopButton.setTitleColor(UIColor.orange, for: .highlighted)
        
        extensionButton.setTitle("EXTENSION", for: .normal)
        extensionButton.titleLabel?.font = UIFont.systemFont(ofSize: 30.0)
        extensionButton.setTitleColor(UIColor.orange, for: .highlighted)
    }
    
    override func setUIConstraints() {
        super.setUIConstraints()
        let screenWidth = UIScreen.main.bounds.width
        
        stopwatchView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        clockLabel.snp.makeConstraints { (make) in
            make.top.equalTo(screenWidth * 0.25)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.view.snp.width).multipliedBy(0.5)
            make.height.equalTo(clockLabel.snp.width)
        }
        
        startButton.snp.makeConstraints { (make) in
            make.top.equalTo(clockLabel.snp.bottom).offset(50.0)
            make.centerX.equalToSuperview().offset(-screenWidth * 0.25)
            make.width.equalTo(screenWidth * 0.25)
            make.height.equalTo(startButton.snp.width).multipliedBy(0.5)
        }
        
        stopButton.snp.makeConstraints { (make) in
            make.top.equalTo(startButton.snp.top)
            make.centerX.equalToSuperview().offset(screenWidth * 0.25)
            make.width.equalTo(screenWidth * 0.25)
            make.height.equalTo(stopButton.snp.width).multipliedBy(0.5)
        }
        
        extensionButton.snp.makeConstraints { (make) in
            make.top.equalTo(startButton.snp.bottom).offset(20.0)
            make.centerX.equalToSuperview()
            make.width.equalTo(screenWidth * 0.25)
            make.height.equalTo(stopButton.snp.width).multipliedBy(0.5)
        }
    }

    override func setUIEvents() {
        super.setUIEvents()
        
        
        
        startButton.rx.tap.asDriver()
        .drive(onNext: { (tap) in
            self.viewModel.startTimer()
            
            self.viewModel.seconds.drive(onNext: { (second) in
                self.clockLabel.text = "\(second)"
                
            }, onCompleted: nil, onDisposed: nil)
                .addDisposableTo(self.disposeBag)
        }, onCompleted: nil, onDisposed: nil)
            .addDisposableTo(disposeBag)
        
        stopButton.rx.tap.asDriver()
            .drive(onNext: { (tap) in
                self.viewModel.stopTimer()
                self.viewModel.seconds.drive(onNext: { (second) in
                    self.clockLabel.text = "\(second)"
                }, onCompleted: nil, onDisposed: nil)
                    .addDisposableTo(self.disposeBag)
            }, onCompleted: nil, onDisposed: nil)
            .addDisposableTo(disposeBag)
        
        extensionButton.rx.tap.asDriver()
            .drive(onNext: { (tap) in
                self.viewModel.extentionCall()
                self.viewModel.seconds.drive(onNext: { (second) in
                    self.clockLabel.text = "\(second)"
                    
                }, onCompleted: nil, onDisposed: nil)
                    .addDisposableTo(self.disposeBag)
            }, onCompleted: nil, onDisposed: nil)
            .addDisposableTo(disposeBag)
    }
}
