//
//  AllBooksViewController.swift
//  MyBook
//
//  Created by Navana Real Estate Ltd. on 19/7/18.
//  Copyright © 2018 Nano IT. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class AllBooksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let GET_ALL_BOOKS = "http://www.mamunscare.org/BOOKAPP_API/getCategory.php"
    var book_name:String = ""
    
    @IBOutlet weak var tblAllBooks: UITableView!
    var modelAllBooks = [ModelAllBooks]()
    let preferences = UserDefaults.standard

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelAllBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "book_cell", for: indexPath) as! AllBookTableViewCell
        
        DispatchQueue.main.async {
            let mBook:ModelAllBooks
            mBook = self.modelAllBooks[indexPath.row]
            
            cell.lblBookName.text = mBook.category_name
            Alamofire.request(mBook.cover!).responseImage { response in
                if let image = response.result.value {
                    cell.imgBook.image = image
                }
                
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.modelAllBooks[indexPath.row].category_name!)
        
        let myVC = storyboard?.instantiateViewController(withIdentifier: "storyboardContent") as! ContentUIViewController
        myVC.book_name = self.modelAllBooks[indexPath.row].category_name!
        myVC.vc_title = self.modelAllBooks[indexPath.row].category_name!
        navigationController?.pushViewController(myVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.GET_ALL_BOOKS(full_name: self.preferences.string(forKey: KEY_SAVE_FULLNAME)!)
        }
    }
    
    func GET_ALL_BOOKS(full_name:String) {
        
        var parameters:[String:String]?
        parameters = ["user_fullname":full_name as String]
        Alamofire.request(GET_ALL_BOOKS, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            if let result = response.value as? [Dictionary<String, AnyObject>] {
                if let code = result[0]["code"] as? String {
                    if code == "failed" {
                        if let message = result[0]["message"] as? String {
                            print(message)
                        }
                        
                    } else if (code == "success") {
                        if let user = result[0]["user"] as? [Dictionary<String, AnyObject>] {
                            for u in user {
                                let id = u["id"] as? String
                                let category_name = u["category_name"] as? String
                                let cover = u["cover"] as? String
                                self.modelAllBooks.append(ModelAllBooks(id: id, category_name: category_name, cover: cover))
                            }
                            self.tblAllBooks.reloadData()
                        }
                        
                    }
                }
            }
            
        }
        self.tblAllBooks.reloadData()
        
    }
   
}
