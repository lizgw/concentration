//
//  ViewController.swift
//  Concentration
//
//  Created by Wigglesworth, Elizabeth G on 12/5/18.
//  Copyright © 2018 Wigglesworth, Elizabeth G. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    
    //how to create a tile
    var tap = UITapGestureRecognizer()
    @IBOutlet var imageArray: [Tile]!
    var firstSelected: Int!
    var secondSelected: Int!
    
    // timer
    var clock:Timer!
    var gameTime = 0
    
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
        
        var tileID = 0
        let numTiles = 10
        for tile in imageArray
        {
            createTile(image: "back", id: tileID + 1, tile: tile)
            
            // loop through all the tiles
            tileID = (tileID + 1) % numTiles
        }
        
        print("view loaded")
        
        randomizeLayout()
        
        // start a countdown timer
        clock = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(incrementClock), userInfo: nil, repeats: true)
    }
    
    @IBOutlet weak var mainStackView: UIStackView!
    //to change image
    func changeImage(tile:Tile,newImage:UIImage)
    {
        tile.addArrangedSubview(UIImageView.init(image:newImage))
    }
    func image(image1: UIImage, isEqualTo image2: UIImage) -> Bool {
        let data1: NSData = image1.pngData()! as NSData
        let data2: NSData = image2.pngData()! as NSData
        return data1.isEqual(data2)
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
       let curImage = (currTile.subviews[currTile.subviews.count-1] as! UIImageView).image
        if !image(image1: curImage!, isEqualTo: UIImage(named: "back")!)
        {
            changeImage(tile: currTile, newImage: UIImage(named: "back")!)
        }
        /*if curImage != UIImage(named: "back")
        {
            changeImage(tile: currTile, newImage: UIImage(named: "back")!)
        }*/
        if image(image1: curImage!, isEqualTo: UIImage(named: "back")!)
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
    
    // all tiles must be in the grid before this
    func randomizeLayout() {
        
        // shuffle rows
        let numRows = mainStackView.arrangedSubviews.count
        var rows = mainStackView.arrangedSubviews
        
        for rowIndex in 0...numRows - 1 {
            // get the row
            let view: UIView = rows[rowIndex];
            
            // remove it
            mainStackView.removeArrangedSubview(view)
            
            // pick a random index
            let randomNum = Int.random(in: 0...numRows - 1)
            
            // insert it in that random spot
            mainStackView.insertArrangedSubview(view, at: randomNum)
            
            // shuffle within the row, same algorithm as above
            if let stackView = view as? UIStackView {
                let numCols = stackView.arrangedSubviews.count
                var cols = stackView.arrangedSubviews
                
                for colIndex in 0...numCols - 1 {
                    let col = cols[colIndex]
                    stackView.removeArrangedSubview(col)
                    let randColIndex = Int.random(in: 0...numCols - 1)
                    stackView.insertArrangedSubview(col, at: randColIndex)
                }
            }
        }
    
    }
    
    @objc func incrementClock()
    {
        // increment the game time
        gameTime += 1
        
        // update UILabel
        let gameMins = gameTime / 60;
        let gameSecs = gameTime % 60
        
        // add a leading 0 for the seconds value
        var secLeadingZero = ""
        if gameSecs < 10 {
            secLeadingZero = "0"
        }
        
        // add a leading 0 for the minutes value
        var minLeadingZero = ""
        if gameMins < 10 {
            minLeadingZero = "0"
        }
        
        let timeString = "\(minLeadingZero)\(gameMins):\(secLeadingZero)\(gameSecs)"
        timerLabel.text = timeString
    }

}

