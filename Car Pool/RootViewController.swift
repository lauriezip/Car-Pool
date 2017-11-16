import UIKit
import CarpoolKit


class RootViewController: UITableViewController {
    
    @IBOutlet weak var allEventsSegmentedControl: UISegmentedControl!
    
    var tripCalendar: API.TripCalendar?
    var trips: [Trip] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        API.observeTrips(sender: self) { (result) in
            switch result {
            case .success(let trips):
                self.trips = trips
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        //override
         func viewWillAppear(animated: Bool) {
            animateTable()
        }
        
        func animateTable() {
            tableView.reloadData()
            let cells = tableView.visibleCells
            let tableHeight: CGFloat = tableView.bounds.size.height
            
            for i in cells {
                let cell: UITableViewCell = i as UITableViewCell
                cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
            }
            
            var index = 0
            
            
            for a in cells {
                let cell: UITableViewCell = a as UITableViewCell
                UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0);
                }, completion: nil)
                
                index += 1
            }
        }
        
        
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if let tripDetailVC = segue.destination as? TripDetailViewController {
            let indexPath = tableView.indexPathForSelectedRow
            tripDetailVC.trip = trips[(indexPath?.row)!]
        }
    }
    
    @IBAction func unwindFromCreateTripVC(segue: UIStoryboardSegue) {
    }
    
    @IBAction func onEventsControlPressed(_ sender: UISegmentedControl) {
        
        API.unobserveAllTrips()
        
        switch allEventsSegmentedControl.selectedSegmentIndex {
        case 0:
            API.observeTheTripsOfMyFriends(sender: self, observer: { (result) in
                switch result {
                case .success(let trips):
                    self.trips = trips
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            })
        case 1:
            API.observeMyTripCalendar(sender: self) { result in
                switch result {
                case .success(let tripCalendar):
                    self.tripCalendar = tripCalendar
                    self.tableView.reloadData()
                case .failure(let error):
                    print(#function, error)
                }
            }
        case 2:
            API.observeMyTrips(sender: self, observer: { (result) in
                switch result {
                case .success(let trips):
                    self.trips = trips
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            })
        default:
            break
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if allEventsSegmentedControl.selectedSegmentIndex == 0 {
            return trips.count
        } else {
            return tripCalendar?.dailySchedule(forWeekdayOffsetFromToday: section).trips.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "A", for: indexPath)
        
        if allEventsSegmentedControl.selectedSegmentIndex == 0 {
            cell.textLabel?.text = trips[indexPath.row].event.description
        } else {
            cell.textLabel?.text = tripCalendar?.dailySchedule(forWeekdayOffsetFromToday: indexPath.section).trips[indexPath.row].event.description
        }
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if allEventsSegmentedControl.selectedSegmentIndex == 0 {
            return 1
        } else {
            return 7
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if allEventsSegmentedControl.selectedSegmentIndex == 0 {
            return nil
        } else {
            return tripCalendar?.dailySchedule(forWeekdayOffsetFromToday: section).prettyName
        }
    }
}
