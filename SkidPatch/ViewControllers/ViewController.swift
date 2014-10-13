//
//  ViewController.swift
//  SkidPatch
//
//  Created by Romain Bousquet on 12/10/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var label: UIView?
    var skidPatch: RBTWheelPatch?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.redColor()
        self.skidPatch = RBTWheelPatch(frame: CGRectMake(50, 50, CGRectGetWidth(self.view.frame) - 100, CGRectGetWidth(self.view.frame) - 100), sizePlateau: 30, sizePignon: 12)
        self.skidPatch?.backgroundColor = UIColor.greenColor()
        self.view.addSubview(self.skidPatch!)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

