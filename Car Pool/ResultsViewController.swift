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
    var fields: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fields.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsCell", for: indexPath)
        cell.textLabel?.text = fields[indexPath.row].description
        let trip = fields[indexPath.row]
        return cell
    }
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
