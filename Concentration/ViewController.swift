//
//  ViewController.swift
//  Concentration
//
//  Created by Wigglesworth, Elizabeth G on 12/5/18.
//  Copyright © 2018 Wigglesworth, Elizabeth G. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tile: Tile!
    var tap = UITapGestureRecognizer()
    override func viewDidLoad() {
        super.viewDidLoad()
        tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap(_:)))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        tile.addGestureRecognizer(tap)
        tile.isUserInteractionEnabled = true
        //self.view.addSubview(view)
        if let tile = tile
        {
            tile.Image(image: UIImage(named: "download")!,id: 0)
        }
        //Image.isUserInteractionEnabled = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        print("Hello World")
    }

}

