//
//  ViewController.swift
//  FaceIt
//
//  Created by 陈志鹏 on 11/14/16.
//  Copyright © 2016 陈志鹏. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController, UIScrollViewDelegate
{
    var expression = FacialExpression(eyes: .closed, eyeBrows: .relaxed, mouth: .smirk) {
        didSet {   
            updateUI()
        }
    }  
    
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: #selector(FaceView.changeScale(_:))))
            let happiserSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.increaseHappiness))
            happiserSwipeGestureRecognizer.direction = .up
            faceView.addGestureRecognizer(happiserSwipeGestureRecognizer)
            
            let sadderSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.decreaseHappiness))
            sadderSwipeGestureRecognizer.direction = .down
            faceView.addGestureRecognizer(sadderSwipeGestureRecognizer)
            
            updateUI()
        }
    }
    
    @IBAction func toggleEyes(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            switch expression.eyes {
            case .open:
                expression.eyes = .closed
            case .closed:
                expression.eyes = .open
            case .squinting: break
            }
         }
    }
    
    private struct Animation {
        static let ShakeAngle = CGFloat(M_PI/6)
        static let ShakeDuration = 0.5
    }
    
    @IBAction func headShake(_ sender: UITapGestureRecognizer)
    {
        UIView.animate(withDuration: Animation.ShakeDuration, animations: {
            self.faceView.transform = self.faceView.transform.rotated(by: Animation.ShakeAngle)
        }) { finished in
            if finished {
                UIView.animate(withDuration: Animation.ShakeDuration, animations: {
                    self.faceView.transform = self.faceView.transform.rotated(by: -Animation.ShakeAngle * 2)
                }) { finished in
                    if finished {
                        UIView.animate(withDuration: Animation.ShakeDuration, animations: {
                            self.faceView.transform = self.faceView.transform.rotated(by: Animation.ShakeAngle)
                        }) { finished in
                            if finished {
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    func increaseHappiness()
    {
        expression.mouth = expression.mouth.happierMouth()
    }
    
    func decreaseHappiness()
    {
        expression.mouth = expression.mouth.sadderMouth()
    }
    
    fileprivate var mouthCurvatures = [FacialExpression.Mouth.frown:-1.0, .grin:0.5, .smile:1.0, .smirk:-0.5, .neutral:0.0]
    fileprivate var eyeBrowTilts = [FacialExpression.EyeBrows.relaxed:0.5, .normal:0.0, .furrowed:-0.5];
    
    fileprivate func updateUI() {
        if faceView != nil {
            switch expression.eyes {
            case .open: faceView.eyesOpen = true
            case .closed: faceView.eyesOpen = false
            case .squinting: faceView.eyesOpen = false
            }
            faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
            faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
        }
    }
    
    let instance = getFaceMVCinstanceCount()
}

