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
    @IBOutlet weak var tile: Tile!
    var tap = UITapGestureRecognizer()
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
        //createTile(image: "download",id:0,tile:self.tile)
        
        randomizeLayout()
    }
    
    @IBOutlet weak var mainStackView: UIStackView!
    //to change image
    func changeImage(tile:Tile,newImage:UIImage)
    {
        tile.addArrangedSubview(UIImageView.init(image:newImage))
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
        print("Hello World")
        
    }
    
    // all tiles must be in the grid before this
    func randomizeLayout() {
        
        // make an array of all the tiles
        var tiles: [Tile] = getTileArray()
        
        print("number of tiles in array: \(tiles.count)")
        
        // get values from the grid
        guard let rows = mainStackView.arrangedSubviews as? [UIStackView] else { return }
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
        }
    
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

