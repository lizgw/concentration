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
    var firstSelected = -1
    var secondSelected = -1
    
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
        if secondSelected != -1
        {
            return
        }
        
        //print("This happened")
        //Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false){ timer in print("FireTimer")}
        var indexSentFrom:Int=0
        var index=0
        while index<20
        {
            if sender.view == imageArray[index]
            {
                indexSentFrom=index
            }
            index+=1
        }
        if indexSentFrom == firstSelected
        {
            return
        }
        let currTile:Tile=imageArray[indexSentFrom]
        let curImage = (currTile.subviews[currTile.subviews.count-1] as! UIImageView).image
        
        /*if firstSelected != -1 && secondSelected != -1
        {
            if !imageArray[firstSelected].matched
            {
                self.changeImage(tile: imageArray[firstSelected], newImage: UIImage(named: "back")!)
            }
            if !imageArray[secondSelected].matched
            {
                self.changeImage(tile: imageArray[secondSelected], newImage: UIImage(named: "back")!)
            }
            firstSelected = -1
            secondSelected = -1
        }*/
        
        if firstSelected == -1
        {
            firstSelected = indexSentFrom
        }
        else
        {
            secondSelected = indexSentFrom
        }
        
        /*if curImage != UIImage(named: "back")
        {
            changeImage(tile: currTile, newImage: UIImage(named: "back")!)
        }*/
        if image(image1: curImage!, isEqualTo: UIImage(named: "back")!)
        {
            var currTileID: String
            if (currTile.getID() < 10)
            {
                currTileID = "0\(currTile.getID())"
            }
            else
            {
                currTileID = "\(currTile.getID())"
            }
            changeImage(tile: currTile, newImage: UIImage(named: "icon\(currTileID)")!)
            
        }
        
        if (firstSelected != -1 && secondSelected != -1)
        {
            let equals = imageArray[firstSelected].getID() == imageArray[secondSelected].getID()
            if (equals)
            {
                imageArray[firstSelected].matched = true
                imageArray[secondSelected].matched = true
            }
        }
        print(firstSelected)
        print(secondSelected)
        if (firstSelected != -1 && secondSelected != -1){
            if (!imageArray[firstSelected].matched && !imageArray[secondSelected].matched)
            {
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false){ timer in
                    self.changeImage(tile: currTile, newImage: UIImage(named: "back")!)
                    self.changeImage(tile: self.imageArray[self.firstSelected], newImage: UIImage(named: "back")!)
                    self.firstSelected = -1
                    self.secondSelected = -1
                }
                //firstSelected = -1
                //secondSelected = -1
            }
            else
            {
                self.firstSelected = -1
                self.secondSelected = -1
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

}

