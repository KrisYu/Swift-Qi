//
//  ViewController.swift
//  SegueWithoutUIElementsDemo
//
//  Created by 雪 禹 on 6/27/16.
//  Copyright © 2016 XueYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        sleep(1)
        
        
        performSegueWithIdentifier("to2view", sender: nil)
        
    }


}

