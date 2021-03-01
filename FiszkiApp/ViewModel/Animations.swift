//
//  Animations.swift
//  FiszkiApp
//
//  Created by Leopold on 27/01/2021.
//

import UIKit
import Lottie

struct Animations {
    
    func addSwipeRightAnimation(view: UIView) {
        let animationView = AnimationView()
        animationView.animation = Animation.named("swipe-right")
        view.addSubview(animationView)
        animationView.backgroundColor = .white
        animationView.contentMode = .scaleAspectFit
        animationView.fillSuperview()
        animationView.loopMode = .loop
        animationView.play()
    }
    
    func addSwipeLeftAnimation(view: UIView) {
        let animationView = AnimationView()
        animationView.animation = Animation.named("swipe-left")
        view.addSubview(animationView)
        animationView.fillSuperview()
        animationView.backgroundColor = .white
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
    }
    
    func addYesCheckMarkAnimation(view: UIView) {
        let animationView = AnimationView()
        animationView.animation = Animation.named("checkmark")
        view.addSubview(animationView)
        animationView.fillSuperview()
        animationView.backgroundColor = .white
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            animationView.play()
        }
        
    }
    
    func addNoCheckMarkAnimation(view: UIView) {
        let animationView = AnimationView()
        animationView.animation = Animation.named("checkmark-no")
        view.addSubview(animationView)
        animationView.fillSuperview()
        animationView.backgroundColor = .white
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            animationView.play()
        }
    }
    
    func showSwipeTips(leftView: UIView, rightView: UIView, yesCheckMark: UIImageView, noCheckMark: UIImageView) {
        
        DispatchQueue.main.asyncAfter(deadline:.now() + 0.5) {
            
            //BEGIN ANIMATION
            
            UIView.animate(withDuration: 1) {
                
                // LEFT STACK
                leftView.alpha = 1
                noCheckMark.alpha = 1
                
                //RIGHT STACK
                yesCheckMark.alpha = 1
                rightView.alpha = 1
            }
        }
        
        // DISMISS ANIMATION
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            UIView.animate(withDuration: 1) {
                
                // LEFT STACK
                leftView.alpha = 0
                noCheckMark.alpha = 0
                
                //RIGHT STACK
                rightView.alpha = 0
                yesCheckMark.alpha = 0
            }
        }
    }
}
