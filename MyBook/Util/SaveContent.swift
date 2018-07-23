//
//  SaveContent.swift
//  MyBook
//
//  Created by Navana Real Estate Ltd. on 23/7/18.
//  Copyright © 2018 Nano IT. All rights reserved.
//

import Foundation
import SQLite

class SaveContent {
    
    private let contents = Table("contents")
    private let id = Expression<Int64>("id")
    private let name = Expression<String?>("name")
    private let banner = Expression<String>("banner")
    private let location = Expression<String>("location")
    private let type = Expression<String>("type")
    private let category = Expression<String>("category")
    private let date_time = Expression<String>("date_time")
    
    static let instance = SaveContent()
    private let db: Connection?
    
    private init() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        do {
            db = try Connection("\(path)/content.sqlite3")
            createTable()
        } catch {
            db = nil
            print ("Unable to open database")
        }
    }
    
    func createTable() {
        do {
            try db!.run(contents.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(name)
                table.column(banner)
                table.column(location)
                table.column(type)
                table.column(category)
                table.column(date_time)
            })
        } catch {
            print("Unable to create table")
        }
    }
    
    func addContent(ID:Int64, NAME:String, BANNER:String, LOCATION:String, TYPE:String, CATEGORY:String, DATE_TIME:String) {
        do {
            let insert = contents.insert(id<-ID, name<-NAME, banner<-BANNER, location<-LOCATION, type<-TYPE, category<-CATEGORY, date_time<-DATE_TIME)
            try db!.run(insert)
        } catch {
            print("Insert failed")
        }
    }
    
    func getContents() -> [ModelContent] {
        var contents = [ModelContent]()
        
        do {
            for content in try db!.prepare(self.contents) {
                contents.append(ModelContent(id: "\(content[id])", name: content[name]!, banner: content[banner], location: content[location], type: content[type], category: content[category], date_time: content[date_time]))
            }
        } catch {
            print("Select failed")
        }
        
        return contents
    }
    
    func deleteContent(cid: Int64) -> Bool {
        do {
            let content = contents.filter(id == cid)
            try db!.run(content.delete())
            return true
        } catch {
            
            print("Delete failed")
        }
        return false
    }
}
