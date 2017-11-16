//
//  AddSomeCommentsViewController.swift
//  Car Pool
//
//  Created by Laurie Zipperer on 11/16/17.
//  Copyright © 2017 Laurie Zipperer. All rights reserved.
//

import UIKit
import CarpoolKit

class AddSomeCommentsViewController: UIViewController {
    
    var trip: Trip?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBOutlet weak var commentsView: CommentsCell!
    
}
