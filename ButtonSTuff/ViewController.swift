//
//  ViewController.swift
//  ButtonSTuff
//
//  Created by Jim Campagno on 10/17/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var redView: UIView!
    var blueView: UIView!
    var greenView: UIView!
    var orangeView: UIView!
    
    var allViews: [UIView]!
    var touchingViews: [(UIView, UIView)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createViews()
        allViews = [redView, blueView, greenView, orangeView].flatMap { $0 }
        createAllPanGestures()
    }
    
}

// MARK: - Pan Gesture
extension ViewController {
    
    func createAllPanGestures() {
        for view in allViews {
            let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panView))
            view.addGestureRecognizer(gestureRecognizer)
        }
    }
    
    func panView(_ sender: UIPanGestureRecognizer) {
        let point = sender.location(in: view)
        let draggedView = sender.view!
        draggedView.center = point
        checkForCollision()
    }
    
    
}

// MARK: - Collision Methods
extension ViewController {
    
    func checkForCollision() {
        for (index, colorView) in allViews.enumerated() {
            guard index < allViews.count - 1 else { break }
            
            var remainingViews: [UIView] = []
            
            for i in (index + 1)..<allViews.count {
                remainingViews.append(allViews[i])
            }
            
            for otherView in remainingViews {
                if colorView.frame.intersects(otherView.frame) {
                    touchingViews.append((colorView, otherView))
                }
            }
        }
        
        mixColors()
    }
    
    func mixColors() {
        guard !touchingViews.isEmpty else { view.backgroundColor = UIColor.white; return }
        var finalColors: [UIColor] = []
        
        for touchingView in touchingViews {
            switch (touchingView.0, touchingView.1) {
            case (redView, blueView):
                finalColors.append(UIColor.purple)
            case (redView, greenView):
                finalColors.append(UIColor.yellow)
            case (redView, orangeView):
                finalColors.append(UIColor.darkBrown)
            case (blueView, greenView):
                finalColors.append(UIColor.cyan)
            case (blueView, orangeView), (greenView, orangeView):
                finalColors.append(UIColor.brown)
            default:
                break
            }
            
        }
        
        if finalColors.count == 1 { view.backgroundColor = finalColors.first! }
        if finalColors.isEmpty { view.backgroundColor = UIColor.white }
        
        
        touchingViews.removeAll()
        
        
        // Loop through final colors
        let finalColor = !finalColors.isEmpty ? finalColors.last! : UIColor.white
        view.backgroundColor = finalColor
        
        
    }
    
}

// MARK: - Create Views
extension ViewController {
    
    func createViews() {
        let height = view.frame.size.height * 0.15
        
        redView = UIView()
        redView.backgroundColor = UIColor.red
        view.addSubview(redView)
        redView.translatesAutoresizingMaskIntoConstraints = false
        redView.heightAnchor.constraint(equalToConstant: height).isActive = true
        redView.widthAnchor.constraint(equalTo: redView.heightAnchor).isActive = true
        redView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        redView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        blueView = UIView()
        blueView.backgroundColor = UIColor.blue
        view.addSubview(blueView)
        blueView.translatesAutoresizingMaskIntoConstraints = false
        blueView.heightAnchor.constraint(equalToConstant: height).isActive = true
        blueView.widthAnchor.constraint(equalTo: blueView.heightAnchor).isActive = true
        blueView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        blueView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        greenView = UIView()
        greenView.backgroundColor = UIColor.green
        view.addSubview(greenView)
        greenView.translatesAutoresizingMaskIntoConstraints = false
        greenView.heightAnchor.constraint(equalToConstant: height).isActive = true
        greenView.widthAnchor.constraint(equalTo: greenView.heightAnchor).isActive = true
        greenView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        greenView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        orangeView = UIView()
        orangeView.backgroundColor = UIColor.orange
        view.addSubview(orangeView)
        orangeView.translatesAutoresizingMaskIntoConstraints = false
        orangeView.heightAnchor.constraint(equalToConstant: height).isActive = true
        orangeView.widthAnchor.constraint(equalTo: orangeView.heightAnchor).isActive = true
        orangeView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        orangeView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
}

extension UIColor {
    
    class var darkBrown: UIColor {
        return UIColor(red:0.62, green:0.27, blue:0.13, alpha:1.00)
    }
    
    
}

