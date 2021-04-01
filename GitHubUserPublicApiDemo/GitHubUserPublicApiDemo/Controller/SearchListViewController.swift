//
//  ViewController.swift
//    
//
//

import UIKit
import SDWebImage

class SearchListViewController: UIViewController {
    
    //MARK:- IbOutlets and Variables
    @IBOutlet weak var userTableView: UITableView!
    @IBOutlet weak var errorLabel: UILabel!
    
    //  Declarion to searchview controller
    private lazy var resultSearchController: UISearchController = {
        let controller = UISearchController(searchResultsController:nil )
        controller.obscuresBackgroundDuringPresentation = false
        controller.definesPresentationContext = true
        controller.isActive = false
        controller.searchBar.sizeToFit()
        controller.hidesNavigationBarDuringPresentation = false
        return controller
    }()
    var SearchModel : searchResponse_model?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  set nibfile to tableview
        let nib = UINib(nibName: "UserTableCell", bundle: nil)
        userTableView.register(nib, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Github Public Users"
        //  set searchview in tableview header
        resultSearchController.searchResultsUpdater = self
        self.userTableView.tableHeaderView = resultSearchController.searchBar
        // Reload the table
        self.userTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    
}
//MARK:-  Tableview Delegate and Tableview DataSource method


extension SearchListViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.SearchModel?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? UserTableCell else {
            assertionFailure("cell was nil")
            return UITableViewCell()
        }
        cell.userNameLbl?.text = SearchModel?.items[indexPath.row].login ?? ""
        cell.ImgUser.sd_setImage(with: URL(string: SearchModel?.items[indexPath.row].avatarURL ?? ""), completed: .none)
        cell.selectionStyle = .none
        cell.accessoryType = .detailButton
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.tableHeaderView = nil
        resultSearchController.isActive = false
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        controller.DetailModel = SearchModel?.items[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
// MARK: - UISearchResultsUpdating
extension SearchListViewController : UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text ?? "")
        getSearchUserData(searchText: searchController.searchBar.text ?? "")
    }
}

// MARK: - Api for search Userdata
extension SearchListViewController {
    private func getSearchUserData(searchText : String){
        ServiceManager().MakeApiCall(url: "https://api.github.com/search/users?q=\(searchText)", withParameters: nil, httpMethod: .get) { (response) in
            
            do {
                let model = try JSONDecoder().decode(searchResponse_model.self, from: response)
                self.SearchModel = model
                DispatchQueue.main.async {
                    self.userTableView.reloadData()
                }
            } catch {
                self.userTableView.tableFooterView = UIView()
                print("This is the main error: \(error.localizedDescription)")
            }
        }
    }
    
}

