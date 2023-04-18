//
//  ViewController.swift
//  Api(K)
//
//  Created by undhad kaushik on 23/03/23.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var myTableView: UITableView!
    var arrdetails: [Elements] = []
    var arr: Elements!

    override func viewDidLoad() {
        super.viewDidLoad()
        nib()
        apiK()
    }
    private func nib() {
        myTableView.delegate = self
        myTableView.dataSource = self
    }

    private func apiK() {
        AF.request("https://api.spaceflightnewsapi.net/v3/articles",method: .get).responseData{ [self] response in
            debugPrint(response)
            if response.response?.statusCode == 200{
                guard let apiData = response.data else { return }
                do {
                    let result = try JSONDecoder().decode([Elements].self, from: apiData)
                    arrdetails = result
                    myTableView.reloadData()
                }catch{
                    print(error.localizedDescription)
                }
                
            } else {
                print("wrong")
            }
        }
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrdetails.count
       
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ApiKTableViewCell = tableView.dequeueReusableCell(withIdentifier: "apiKcell", for: indexPath) as! ApiKTableViewCell
        
        cell.nameLabel1.text = "\(arrdetails[indexPath.row].id)"
        cell.namelabel2.text = "\(arrdetails[indexPath.row].title)"
        cell.nameLabel3.text = "\(arrdetails[indexPath.row].launches)"
        cell.nameLAbel4.text = "\(arrdetails[indexPath.row].featured)"
        cell.myImage.image = img(link: arrdetails[indexPath.row].imageUrl!)
        cell.spaceWebView.loadRequest(URLRequest(url: URL(string: arrdetails[indexPath.row].url!)!))
        //      cell.spaceWebView.loadHTMLString(arrdetails[indexPath.row].url, baseURL:nil)
        cell.layer.borderWidth = 1
        return cell
    }
    
    func img(link:String)->UIImage?{
        let url1 = URL(string: link)
        let data = try? Data(contentsOf: url1! as URL)
        return UIImage(data: data!)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 1000
    }
}

struct Elements: Codable {
    let id: Int
    let title: String
    let url: String?
    let imageUrl: String?
    let newsSite: String
    let summary: String
    let publishedAt: String
    let updatedAt: String
    let featured: Bool
    let launches: [Launch]
    let events: [Event]
}

struct Launch: Codable {
    let id: String?
    let provider: String?
}

struct Event: Codable {
    let id: Int?
    let provider: String?
}
