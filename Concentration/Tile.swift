//
//  Tile.swift
//  Concentration
//
//  Created by Webb, Carter J on 12/7/18.
//  Copyright © 2018 Wigglesworth, Elizabeth G. All rights reserved.
//

import UIKit

class Tile: UIStackView {
    //MARK: Initialization
   // let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
    private var id:Int=0
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    //MUST RUN TO HAVE AN IMAGE
    public func Image(image: UIImage,id:Int)
    {
        self.id=id
        addArrangedSubview(UIImageView.init(image: image))
    }
    public func getID() -> Int
    {
        return id
    }
}
