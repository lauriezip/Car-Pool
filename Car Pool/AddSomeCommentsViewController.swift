//
//  AddSomeCommentsViewController.swift
//  Car Pool
//
//  Created by joshua dodd on 11/17/17.
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
