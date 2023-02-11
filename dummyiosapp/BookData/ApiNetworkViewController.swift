//
//  ApiNetworkViewController.swift
//  dummyiosapp
//
//  Created by Maheen on 04/09/2022.
//
import SideMenu
import Alamofire
import UIKit

class ApiNetworkViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var labelUserName: UILabel!
    
    //button
    @IBAction func buttonLogout() {
        //removing values from default
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
        
        //switching to login screen
        let LoginView = self.storyboard?.instantiateViewController(withIdentifier: "LoginTableViewController") as! LoginTableViewController
        self.navigationController?.pushViewController(LoginView, animated: true)
        self.dismiss(animated: false, completion: nil)
    }
    
    var menu: SideMenuNavigationController?
    @IBOutlet weak var tableView: UITableView!
    var books = [BookStats]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //hiding back button
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        //getting user data from defaults
        let defaultValues = UserDefaults.standard
        if let name = defaultValues.string(forKey: "username"){
            //setting the name to label
            labelUserName.text = name
        }else{
            //send back to login view controller
        }
        menu = SideMenuNavigationController(rootViewController:MenuListController())
        menu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController=menu
        SideMenuManager.default.addPanGestureToPresent(toView:self.view)
        downloadJSON {
            self.tableView.reloadData()
            print("Success")
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
    @IBAction func didTapMenu() {
        present(menu!, animated: true)
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let listbook = books[indexPath.row]
        cell.textLabel?.text = listbook.localized_name.capitalized
        cell.detailTextLabel?.text = listbook.primary_attr.capitalized
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ServicesViewController {
            destination.listbook = books[tableView.indexPathForSelectedRow!.row]
        }
    }
    
    func downloadJSON(completed: @escaping () -> ()) {
        let url = URL(string: "http://localhost/prototypephase/bookdata.json")
        
        URLSession.shared.dataTask(with: url!) { data, response, err in
            if err == nil {
                do {
                    self.books = try JSONDecoder().decode([BookStats].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                }
                catch {
                    print("error fetching data from api")
                }
            }
        }.resume()
    }
}

class MenuListController: UITableViewController {
    var items = ["Home", "Dashboard", "About Us"]
    
    let darkColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
    
    override func viewDidLoad(){
        super.viewDidLoad()
        tableView.backgroundColor = darkColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.title = "Menu";
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.orange]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.textLabel?.highlightedTextColor = .black
        cell.backgroundColor = darkColor
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if true {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let ApiNetworkViewController = storyBoard.instantiateViewController(withIdentifier: "ApiNetworkViewController") as! ApiNetworkViewController
            self.navigationController?.pushViewController(ApiNetworkViewController, animated: true)
        }
    }
}
