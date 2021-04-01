//
//  DetailViewController.swift
//    
//
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    //MARK:- IbOutlets and Variables
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var ImgUser: UIImageView!
    @IBOutlet weak var userLinkLbl: UILabel!
    @IBOutlet weak var userFollowersLbl: UILabel!
    @IBOutlet weak var userRepoLbl: UILabel!
    @IBOutlet weak var userRepoTableView: UITableView!
    
    var DetailModel : Item?
    var Followers_Model : [Followers_model]?
    var RepositoryModel : [Repo_Model]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewSetUp()
    }
    
}
//MARK:-  Tableview Delegate and Tableview DataSource method
extension DetailViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.self.RepositoryModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PublicRepoCell else {
            assertionFailure("cell is nil")
            return UITableViewCell()
        }
        cell.lblName?.text = RepositoryModel?[indexPath.row].name
        cell.lblFullName?.text = RepositoryModel?[indexPath.row].fullName
        
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
// MARK: - Api for Followers and Repos
extension DetailViewController{
    
    func apiListFollowers(){
        ServiceManager().MakeApiCall(url: DetailModel?.followersURL ?? "", withParameters: nil, httpMethod: .get) { (responce) in
            do {
                let model = try JSONDecoder().decode(Array<Followers_model>.self, from: responce)
                self.Followers_Model = model
            } catch {
                print("error through")
            }
            self.userFollowersLbl.text = "\(self.Followers_Model?.count ?? 0) Followers"
        }
        
    }
    func apiListPublicRepos(){
        ServiceManager().MakeApiCall(url: DetailModel?.reposURL ?? "", withParameters: nil, httpMethod: .get) { (responce) in
            do {
                let model = try JSONDecoder().decode(Array<Repo_Model>.self, from: responce)
                self.RepositoryModel = model
            } catch {
                print("error through1")
                
            }
            self.userRepoLbl.text = "\(self.RepositoryModel?.count ?? 0) Repositories"
            if self.RepositoryModel?.count == 0{
                
            }else{
                self.userRepoTableView.reloadData()
            }
        }
    }
}

// MARK: - setup values
extension DetailViewController {
    private func viewSetUp() {
        
        self.title = DetailModel?.login
        self.usernameLbl.text = DetailModel?.login
        self.userLinkLbl.text = DetailModel?.htmlURL
        self.ImgUser.sd_setImage(with: URL(string: DetailModel?.avatarURL ?? ""), completed: .none)
        
        //  set nibfile to tableview
        let nib = UINib(nibName: "PublicRepoCell", bundle: nil)
        userRepoTableView.register(nib, forCellReuseIdentifier: "cell")
        
        // call api methods
        self.apiListFollowers()
        self.apiListPublicRepos()
        
    }
}

