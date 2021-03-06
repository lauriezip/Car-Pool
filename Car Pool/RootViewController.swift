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
        cell.contentView.backgroundColor = UIColor.clear
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

