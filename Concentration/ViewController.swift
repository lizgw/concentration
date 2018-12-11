//
//  ViewController.swift
//  Concentration
//
//  Created by Wigglesworth, Elizabeth G on 12/5/18.
//  Copyright © 2018 Wigglesworth, Elizabeth G. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        randomizeLayout()
    }
    
    class Tile : UIButton { } // TODO: remove this - it's just to avoid errors while waiting for actual tile class
    let mainStackView : UIStackView = UIStackView() // TODO: remove this - should be populated by IB
    
    // all tiles must be in the grid before this
    func randomizeLayout() {
        // make an array of all the tiles
        var tiles: [Tile] = [] // TODO: get tiles from the UI grid
        // ref to stack view, parse it & save them? break this into a separate method
        
        let rows: [UIStackView] = [] // TODO: populate this from the UI
        let numCols = 4 // TODO: get this from the UI
        
        // loop through the grid
        for row in rows {
            for _ in 0...numCols {
                // put a random tile in that spot
                let randIndex = Int.random(in: 0...tiles.count)
                let tile:Tile = tiles[randIndex]
                row.addArrangedSubview(tile)
                
                // remove that tile from the array
                tiles.remove(at: randIndex)
            }
        }
        
    }
    
    func getTileArray() -> [Tile] {
        // set up an array
        var resultArr: [Tile] = []
        
        // for each sub stack view
        for stackView in mainStackView.arrangedSubviews {
            
            // get it and make sure it's an actual stack view
            guard let stackView = stackView as? UIStackView else { return [] }
            
            // for each tile inside
            for tile in stackView.arrangedSubviews {
                
                // get it and make sure it's a tile
                guard let tile = tile as? Tile else { return [] }
                
                // add the tile to the array
                resultArr.append(tile)
            }
        }
        
        // return an array with all the tiles
        return resultArr
    }
    
}

