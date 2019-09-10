//
//  ClockViewController.swift
//  Pool Scoreboard
//
//  Created by HarveyHu on 12/01/2017.
//  Copyright © 2017 HarveyHu. All rights reserved.
//

import UIKit

class ClockViewController: BaseViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    let stopwatchView = UIView()
    let clockLabel = UILabel()
    let startButton = UIButton()
    let stopButton = UIButton()
    let extensionButton = UIButton()
    let viewModel = ClockViewModel()
    let pickerView = UIPickerView()
    var pickerDataArray = Array<Int>()
    
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
        self.stopwatchView.addSubview(pickerView)
        
        self.view.backgroundColor = UIColor.white
        self.stopwatchView.backgroundColor = UIColor.black
        
        
        clockLabel.text = "\(viewModel.countdownSeconds)"
        clockLabel.textAlignment = .center
        clockLabel.textColor = UIColor.themeOrange()
        clockLabel.font = UIFont.boldSystemFont(ofSize: 100.0)
        clockLabel.layer.borderWidth = 10.0
        clockLabel.layer.borderColor = UIColor.white.cgColor
        clockLabel.layer.masksToBounds = true
        clockLabel.adjustsFontSizeToFitWidth = true
        
        startButton.setTitle("START", for: .normal)
        startButton.setTitleColor(UIColor.white, for: .normal)
        startButton.setTitleColor(UIColor.orange, for: .highlighted)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 30.0)
        startButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        stopButton.setTitle("STOP", for: .normal)
        stopButton.titleLabel?.font = UIFont.systemFont(ofSize: 30.0)
        stopButton.setTitleColor(UIColor.orange, for: .highlighted)
        stopButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        extensionButton.setTitle("EXTENSION", for: .normal)
        extensionButton.titleLabel?.font = UIFont.systemFont(ofSize: 30.0)
        extensionButton.setTitleColor(UIColor.orange, for: .highlighted)
        extensionButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        if pickerDataArray.count == 0 {
            for index in 10...100 {
                pickerDataArray.append(index)
            }
        }
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.backgroundColor = UIColor.white
        pickerView.isHidden = true
        pickerView.selectRow(viewModel.countdownSeconds - 10, inComponent: 0, animated: false)
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
            make.width.equalTo(screenWidth * 0.5)
            make.height.equalTo(stopButton.snp.width).multipliedBy(0.5)
        }
        
        pickerView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }

    override func setUIEvents() {
        super.setUIEvents()
        
        
        
        startButton.rx.tap.asDriver()
        .drive(onNext: {[weak self] (tap) in
            guard let strongSelf = self else {return}
            strongSelf.viewModel.startTimer()
            
            strongSelf.viewModel.seconds.drive(onNext: { (second) in
                strongSelf.clockLabel.text = "\(second)"
                
            }, onCompleted: nil, onDisposed: nil)
                .disposed(by: strongSelf.disposeBag)
        }, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        
        stopButton.rx.tap.asDriver()
            .drive(onNext: {[weak self] (tap) in
                guard let strongSelf = self else {return}
                strongSelf.viewModel.stopTimer()
                strongSelf.viewModel.seconds.drive(onNext: { (second) in
                    strongSelf.clockLabel.text = "\(second)"
                }, onCompleted: nil, onDisposed: nil)
                    .disposed(by: strongSelf.disposeBag)
            }, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        
        extensionButton.rx.tap.asDriver()
            .drive(onNext: {[weak self] (tap) in
                guard let strongSelf = self else {return}
                strongSelf.viewModel.extentionCall()
                strongSelf.viewModel.seconds.drive(onNext: { (second) in
                    strongSelf.clockLabel.text = "\(second)"
                    
                }, onCompleted: nil, onDisposed: nil)
                    .disposed(by: strongSelf.disposeBag)
            }, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        
        pickerView.rx.itemSelected.asDriver()
        .drive(onNext: {[weak self] (rowAndComponent) in
            guard let strongSelf = self else {return}
            strongSelf.viewModel.stopTimer()
            strongSelf.viewModel.countdownSeconds = self!.pickerDataArray[rowAndComponent.0]
            strongSelf.clockLabel.text = "\(strongSelf.pickerDataArray[rowAndComponent.0])"
            strongSelf.pickerView.isHidden = true
        }, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        
        
        let tapGR_clockLabel = UITapGestureRecognizer()
        tapGR_clockLabel.rx.event.asDriver().drive(onNext: {[weak self](tap) in
            if self!.pickerView.isHidden {
                self?.pickerView.isHidden = false
            } else {
                self?.pickerView.isHidden = true
            }
            }, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        clockLabel.isUserInteractionEnabled = true
        clockLabel.addGestureRecognizer(tapGR_clockLabel)
    }
    
    // MARK - UIPickerView
    // returns the number of 'columns' to display.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    // returns the # of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerDataArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return "\(self.pickerDataArray[row])";
    }
}
