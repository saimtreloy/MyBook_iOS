//
//  ContentUIViewController.swift
//  MyBook
//
//  Created by Navana Real Estate Ltd. on 21/7/18.
//  Copyright © 2018 Nano IT. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ContentUIViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating{
    
    
    
    let CONTENT_URL = "http://www.mamunscare.org/BOOKAPP_API/getContentByCategory.php"
    let CONTENT_URL_AUDIO = "http://www.mamunscare.org/BOOKAPP_API/getMainAudio.php"
    let CONTENT_URL_VIDEO = "http://www.mamunscare.org/BOOKAPP_API/getMainVideo.php"
    
    @IBOutlet weak var tblContent: UITableView!
    var modelContent = [ModelContent]()
    var modelContentFilter = [ModelContent]()
    let preferences = UserDefaults.standard
    var book_name:String = ""
    var vc_title:String = ""
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return self.modelContentFilter.count
        }
        return self.modelContent.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "content_cell", for: indexPath) as! ContentTableViewCell
        
        DispatchQueue.main.async {
            let mContent:ModelContent
            
            if self.searchController.isActive && self.searchController.searchBar.text != "" {
                mContent = self.modelContentFilter[indexPath.row]
            } else {
                mContent = self.modelContent[indexPath.row]
            }
            
            cell.lblContentName.text = mContent.name
            cell.lblContentBookName.text = mContent.category
            cell.lblContentType.text = mContent.type
            cell.lblContentDate.text = mContent.date_time
            
            Alamofire.request(mContent.banner!).responseImage { response in
                if let image = response.result.value {
                    cell.imgCover.image = image
                }
                
            }
        }
        
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text!)
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            modelContentFilter = modelContent.filter({( modelContent1 : ModelContent) -> Bool in
                return (modelContent1.name?.contains(searchText))!
            })
        } else {
            modelContentFilter = modelContent
        }
        tblContent.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController.dismiss(animated: false, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.vc_title = self.vc_title.replacingOccurrences(of: "_", with: " ")
        self.navigationItem.title = vc_title
        print(book_name)
        
        if (book_name == "AUDIO") {
            GET_BOOK_AUDIO(full_name: self.preferences.string(forKey: KEY_SAVE_FULLNAME)!)
        } else if (book_name == "VIDEO") {
            GET_BOOK_VIDEO(full_name: self.preferences.string(forKey: KEY_SAVE_FULLNAME)!)
        } else {
            GET_BOOK_CONTENTS(full_name: book_name)
        }
        
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        tblContent.tableHeaderView = searchController.searchBar
    }
    
    func GET_BOOK_CONTENTS(full_name:String) {
        var parameters:[String:String]?
        parameters = ["category_name":full_name as String]
        Alamofire.request(CONTENT_URL, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { response in
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
                                let name = u["name"] as? String
                                let banner = u["banner"] as? String
                                let location = u["location"] as? String
                                let type = u["type"] as? String
                                let category = u["category"] as? String
                                let date_time = u["date_time"] as? String
                                
                                self.modelContent.append(ModelContent(id: id, name: name, banner: banner, location: location, type: type, category: category, date_time: date_time))
                            }
                            self.tblContent.reloadData()
                        }
                        
                    }
                }
            }
        }
        self.tblContent.reloadData()
    }
    
    func GET_BOOK_AUDIO(full_name:String) {
        var parameters:[String:String]?
        parameters = ["user_fullname":full_name as String]
        Alamofire.request(CONTENT_URL_AUDIO, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { response in
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
                                let name = u["name"] as? String
                                let banner = u["banner"] as? String
                                let location = u["location"] as? String
                                let type = u["type"] as? String
                                let category = u["category"] as? String
                                let date_time = u["date_time"] as? String
                                
                                self.modelContent.append(ModelContent(id: id, name: name, banner: banner, location: location, type: type, category: category, date_time: date_time))
                            }
                            self.tblContent.reloadData()
                        }
                        
                    }
                }
            }
            
        }
        self.tblContent.reloadData()
    }
    
    func GET_BOOK_VIDEO(full_name:String) {
        var parameters:[String:String]?
        parameters = ["user_fullname":full_name as String]
        Alamofire.request(CONTENT_URL_VIDEO, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { response in
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
                                let name = u["name"] as? String
                                let banner = u["banner"] as? String
                                let location = u["location"] as? String
                                let type = u["type"] as? String
                                let category = u["category"] as? String
                                let date_time = u["date_time"] as? String
                                
                                self.modelContent.append(ModelContent(id: id, name: name, banner: banner, location: location, type: type, category: category, date_time: date_time))
                            }
                            self.tblContent.reloadData()
                        }
                        
                    }
                }
            }
            
        }
        self.tblContent.reloadData()
    }
    
    
}
