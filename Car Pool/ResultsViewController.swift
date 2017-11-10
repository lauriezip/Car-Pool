//
//  ResultsViewController.swift
//  Car Pool
//
//  Created by joshua dodd on 11/10/17.
//  Copyright © 2017 Laurie Zipperer. All rights reserved.
//

import CarpoolKit
import UIKit

class ResultsViewController: UITableViewController {
    
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let ref = Database.database().reference().child("snaps").queryOrdered(byChild: "author").queryEqual(toValue: (chap?.friends[indexPath.row])!)
//        ref.observe(.childAdded, with: { (snapshot) in
//            guard let value = snapshot.value as? [String: Any] else { return }
//            if let snap = Snap(from: value) {
//                if snap.imageUri.hasPrefix("gs://") {
//                    
//                    var downloadedSnaps = [Snap]()
//                    downloadedSnaps.append(snap)
//                    downloadedSnaps.sort(by: {$0.time.compare($1.time) == .orderedAscending})
//                    for snap in downloadedSnaps {
//                        let ref = Storage.storage().reference(forURL: snap.imageUri)
//                        ref.getData(maxSize: Int64.max) { (data, error) in
//                            if let data = data, let image = UIImage(data: data){
//                                self.performSegue(withIdentifier: "ViewSnapSegue", sender: image)
//                            }
//                        }
//                    }
//                }
//            }
//        })
//    }
//    
    
}
