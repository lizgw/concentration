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
        
        for tile in imageArray
        {
            createTile(image: "back", id: 1, tile: tile)
        }
        
        randomizeLayout()
        //print(imageArray.count)
    }
    
    @IBOutlet weak var mainStackView: UIStackView!
    //to change image
    func changeImage(tile:Tile,newImage:UIImage)
    {
        tile.addArrangedSubview(UIImageView.init(image:newImage))
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
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
        let currTile:Tile=imageArray[indexSentFrom]
        if (currTile.subviews[0] as! UIImageView).image != UIImage(named: "back")
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
    
    // all tiles must be in the grid before this
    func randomizeLayout() {
        
        // shuffle rows
        let numRows = mainStackView.arrangedSubviews.count
        var rows = mainStackView.arrangedSubviews
        
        for rowIndex in 0...numRows - 1 {
            let view: UIView = rows[rowIndex];
                
            mainStackView.removeArrangedSubview(view)
            
            let randomNum = Int.random(in: 0...numRows - 1) // TODO: make sure this stays in bounds
            
            mainStackView.insertArrangedSubview(view, at: randomNum)
        }
        
        /*var rows = mainStackView.arrangedSubviews
        
        if let rows = rows as? [UIStackView] {
            for row in rows {
                row.removeArrangedSubview(<#T##view: UIView##UIView#>)
            }
        }*/
        
        
        
        
        // shuffle columns in each row
        
        // make an array of all the tiles
        //var tiles: [Tile] = imageArray
        
        //print("number of tiles in array: \(tiles.count)")
        
        
        
        // get values from the grid
        /*guard let rows = mainStackView.arrangedSubviews as? [UIStackView] else { return }
        let numCols = mainStackView.arrangedSubviews.count
        
        // clear the grid in the UI
        for row in rows {
            for stackView in row.arrangedSubviews {
                // get the view
                guard let stackView = stackView as? UIStackView else { return }
                // remove it
                row.removeArrangedSubview(stackView)
            }
        }
    
        // loop through the grid
        for row in rows {
            for _ in 0...numCols {
                // pick a random tile
                let randIndex = Int.random(in: 0...tiles.count)
                let tile:Tile = tiles[randIndex]
                
                // add it to the UI
                row.addArrangedSubview(tile)
                
                // remove that tile from the array so it's not picked again
                tiles.remove(at: randIndex)
            }
        }*/
    
    }
    
    func getTileArray() -> [Tile] {
        // set up an array
        var resultArr: [Tile] = []
        
        //print("count: \(mainStackView.arrangedSubviews.count)")
        
        // for each sub stack view
        for stackView in mainStackView.arrangedSubviews {
            
            //print("found a stackview")
        
            // get it and make sure it's an actual stack view
            guard let stackView = stackView as? UIStackView else { return [] }
            
            // for each tile inside
            for tile in stackView.arrangedSubviews {
                //print("num tiles: \(stackView.arrangedSubviews.count)")
                
                // get it and make sure it's a tile
                guard let tile = tile as? Tile else { return [] }
                // TODO: needs to be made of tiles, not images
                
                print("passed the second guard")
                
                // add the tile to the array
                resultArr.append(tile)
            }
        }
        
        // return an array with all the tiles
        return resultArr
    }

}

