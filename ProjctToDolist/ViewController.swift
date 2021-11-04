//  ProjctToDolist
//
//  Created by Osama folta on 26/03/1443 AH.

import UIKit

class ViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource , passDataBack ,UISearchBarDelegate {
 
    var UserList = [String]()
//
    @IBOutlet weak var usertext: UITextField!
    @IBOutlet weak var myTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
         filterList = UserList
        serchBar.delegate = self
        myTable.delegate = self
        myTable.dataSource = self
        usertext.layer.cornerRadius = 20
        myTable.layer.cornerRadius = 15
        if let usrDefaults = UserDefaults.standard.object(forKey: "List") as? [String]{
            UserList = usrDefaults
        }
    }
//
    @IBAction func saveBTN(_ sender: Any) {
        if usertext.text != ""{
            UserList.append(usertext.text!)
            UserDefaults.standard.set(UserList,forKey: "List")
            usertext.text = ""
            myTable.reloadData()
        }
    }
// to clear the list
    @IBAction func deleteBTN(_ sender: Any) {
        UserList.removeAll()
        myTable.reloadData()
        UserDefaults.standard.set(UserList,forKey: "List")
    }
// to delete only selected
    @IBAction func delete_BTN(_ sender: Any) {
        if myTable.indexPathForSelectedRow != nil {
        let select = ( myTable.indexPathForSelectedRow![1])
        print(myTable.indexPathForSelectedRow![1])
        UserList.remove(at: select)
        myTable.reloadData()
            
        }
        else{
// display error msg
            let titel = "Wrong Action"
            let msg = "Pleas Select the Task First"
            let alter = UIAlertController(title: titel, message: msg, preferredStyle: .alert)
            alter.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alter, animated: true, completion: nil)
        }
    }
    var selectdata:String=""
    var selectindex:Int=0
// protocol function to receiv data
    func updateRow(updateName: String) {
        UserList[selectindex] = updateName
        myTable.reloadData()
    }

//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let action = UIContextualAction(style: .normal, title: "Edit"){
//            (action,view,completion) in
//            print( self.selectdata = self.UserList[indexPath.row],
//            self.selectindex = indexPath.row)
//            self.performSegue(withIdentifier: "myseque", sender: self)
//            completion(true) }
//    return UISwipeActionsConfiguration (actions: [action])}

    @IBAction func updateBTN(_ sender: Any) {
        self.selectindex = (myTable.indexPathForSelectedRow![1])
        self.selectdata = UserList[self.selectindex]
            print(self.selectindex)
        self.performSegue(withIdentifier: "myseque", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination:myViewController = segue.destination as! myViewController
        destination.delegate = self
        destination.DataSors = selectdata
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = UserList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt index: IndexPath) {
        print("User selected: \(index.row)")
    }
    // SearchBar
    @IBOutlet weak var serchBar: UISearchBar!
    var filterList = [String]()
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != ""{
            filterList   = UserList.filter{$0.contains((searchBar.text?.lowercased())!)}
            //UserList = filterList.filter{$0.contains(searchText)}
            print(filterList)}}
    }
  


