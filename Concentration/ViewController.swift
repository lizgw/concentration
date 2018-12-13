//
//  ViewController.swift
//  Concentration
//
//  Created by Wigglesworth, Elizabeth G on 12/5/18.
//  Copyright © 2018 Wigglesworth, Elizabeth G. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //how to create a tile
    var tap = UITapGestureRecognizer()
    @IBOutlet var imageArray: [Tile]!
    var firstSelected: Int!
    var secondSelected: Int!
    
    func createTile(image:String,id:Int,tile:Tile)
    {
        tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap(_:)))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        tile.addGestureRecognizer(tap)
        tile.isUserInteractionEnabled = true
        //Use .Image to set initial image and image ID
        tile.Image(image: UIImage(named: image)!,id: id)
    }
    //end of creating tile
    override func viewDidLoad() {
        super.viewDidLoad()
        //example of creating tile
        for tile in imageArray
        {
            createTile(image: "back", id: 1, tile: tile)
        }
        print("view loaded")
        // Do any additional setup after loading the view, typically from a nib.
    }
    //to change image
    func changeImage(tile:Tile,newImage:UIImage)
    {
        tile.addArrangedSubview(UIImageView.init(image:newImage))
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        print("This happened")
        var indexSentFrom:Int=0
        var index=0
        while index<20
        {
            if sender.view == imageArray[index]
            {
                indexSentFrom=index
                firstSelected = index
            }
            index+=1
        }
        
        let currTile:Tile=imageArray[indexSentFrom]
        if (currTile.subviews[currTile.subviews.count-1] as! UIImageView).image != UIImage(named: "back")
        {
            changeImage(tile: currTile, newImage: UIImage(named: "back")!)
        }
        if (currTile.subviews[0] as! UIImageView).image == UIImage(named: "back")
        {
            if currTile.getID()<10
            {
                changeImage(tile: currTile, newImage: UIImage(named: "icon0\(currTile.getID())")!)
            }
            else
            {
                changeImage(tile: currTile, newImage: UIImage(named: "icon10")!)
            }
        }
        
        
    }

}

