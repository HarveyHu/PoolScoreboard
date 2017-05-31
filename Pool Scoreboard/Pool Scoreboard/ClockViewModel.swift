//
//  ClockViewModel.swift
//  Pool Scoreboard
//
//  Created by HarveyHu on 16/01/2017.
//  Copyright © 2017 HarveyHu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import AVFoundation

class ClockViewModel {
    let disposeBag = DisposeBag()
    var countdownTimer: Timer?
    var countdownSeconds = 30 {
        didSet {
            count = countdownSeconds
            self.seconds = configureSeconds(count).asDriver(onErrorJustReturn: -1)
        }
    }
    
    var audioPlayer: AVAudioPlayer?
    
    var count = 0
    
    var seconds: Driver<Int> = Driver.never()
    
    enum Sound: String {
        case extensionCall = "extension_call.mp3"
        case foul = "foul.mp3"
        case tenSeconds = "ten_seconds.mp3"
        case tick = "tick.mp3"
        case alarm = "alarm.mp3"
    }
    
    init() {
        //self.seconds = configureSeconds(count).asDriver(onErrorJustReturn: -1)
        count = countdownSeconds
        
        
    }
    
    func startTimer() {
        self.countdownTimer?.invalidate()
        self.count = self.countdownSeconds
        self.seconds = configureSeconds(count).asDriver(onErrorJustReturn: -1)
    }
    
    func stopTimer() {
        self.countdownTimer?.invalidate()
        self.count = 0
        self.seconds = Driver.just(0)
        audioPlayer?.stop()
    }
    
    func resumeTimer() {
        self.seconds = configureSeconds(count).asDriver(onErrorJustReturn: -1)
    }
    
    func extentionCall() {
        self.countdownTimer?.invalidate()
        self.count = self.count + self.countdownSeconds
        self.seconds = configureSeconds(count).asDriver(onErrorJustReturn: -1)
        
        playSound(.extensionCall)
    }
    
    func playSound(_ sound: Sound) {
        audioPlayer?.stop()
        let mainPath = Bundle.main.bundlePath
        let pathUrl = URL(fileURLWithPath: mainPath + "/" + sound.rawValue)
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: pathUrl)
        } catch let e {
            print("audioPlayer error! \(e.localizedDescription)")
        }
        audioPlayer?.play()
    }
    
    @objc func countdown(timer: Timer) {
        if let observer = timer.userInfo as? AnyObserver<Int> {
            self.count -= 1
            
            self.playCountDownSound(count: self.count)
            
            if self.count < 0 {
                self.countdownTimer?.invalidate()
                observer.onCompleted()
                return
            }
            observer.on(.next(self.count))
        }
    }
    
    func configureSeconds(_ second: Int) -> Observable<Int> {
        return Observable.create({ (observer) -> Disposable in
            
            observer.on(.next(self.count))
            
            
            
            if #available(iOS 10.0, *) {
                
                self.countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
                    self.count -= 1
                    
                    self.playCountDownSound(count: self.count)
                    
                    if self.count < 0 {
                        self.countdownTimer?.invalidate()
                        observer.onCompleted()
                    }
                    
                    observer.on(.next(self.count))
                })
            } else {
                // Fallback on earlier versions
                self.countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.countdown), userInfo: observer, repeats: true)
            }
            
            
            return Disposables.create()
        })
    }
    
    private func playCountDownSound(count: Int) {
        switch count {
        case 10:
            self.playSound(.tenSeconds)
        case 1..<10:
            self.playSound(.tick)
        case 0:
            self.playSound(.alarm)
        default:
            break
        }
    }
}
