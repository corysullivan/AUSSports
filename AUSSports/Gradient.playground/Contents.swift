//: A UIKit based Playground for presenting user interface

import PlaygroundSupport
import UIKit

// class MyViewController : UIViewController {
//    override func loadView() {
//        let view = UIView()
//        view.backgroundColor = .white
//
//        let label = UILabel()
//        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
//        label.text = "Hello World!"
//        label.textColor = .black
//
//        view.addSubview(label)
//        self.view = view
//    }
// }
//// Present the view controller in the Live View window
// PlaygroundPage.current.liveView = MyViewController()
// Set Up a Test View in Swift Playgrounds

let color1 = UIColor.clear.cgColor // UIColor(red: 0.059, green: 0.059, blue: 0.059, alpha: 0.33).cgColor
let color2 = UIColor.red.cgColor // UIColor(red: 0.059, green: 0.059, blue: 0.059, alpha: 0.66).cgColor
let testView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
// Create Gradient Layer
var gradientLayer = CAGradientLayer()
// Set Layer Size
gradientLayer.frame = testView.frame
// Provide an Array of CGColors
gradientLayer.colors = [color1, color2]
// Guesstimate a Match to 47° in Coordinates
gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
// Add Gradient Layer to Test View
testView.layer.addSublayer(gradientLayer)

gradientLayer.locations = [NSNumber(value: 0.8)]

//  var gradientLayer2 = CAGradientLayer()
//// Set Layer Size
//  gradientLayer2.frame = testView.frame
//// Provide an Array of CGColors
//  gradientLayer2.colors = [color2, color1]
//// Guesstimate a Match to 47° in Coordinates
// gradientLayer2.startPoint = CGPoint(x: 0.0, y: 0.5)
// gradientLayer2.endPoint = CGPoint(x: 1.0, y: 0.5)
//// Add Gradient Layer to Test View
//  testView.layer.addSublayer(gradientLayer2)

testView
