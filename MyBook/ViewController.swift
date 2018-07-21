
import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController {
    
    let URL_GET_DATA = "https://simplifiedcoding.net/demos/marvel/"
    let URL_IMAGE = "https://www.simplifiedcoding.net/demos/marvel/captainamerica.jpg"
    let login = "http://www.mamunscare.org/BOOKAPP_API/login.php"

    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputRegistrationCode: UITextField!
    
    let preferences = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fullname = preferences.string(forKey: KEY_SAVE_FULLNAME);
        if fullname == nil || (fullname?.isEmpty)! {
            print("I am empty")
        } else {
            print("I am not empty")
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewControler = storyboard.instantiateViewController(withIdentifier: "storyboardNavControl") as? UINavigationController
                self.present(newViewControler!, animated: true, completion: nil)
            }
        }
    
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        let email = self.inputEmail.text
        let regCode = self.inputRegistrationCode.text
        
        if ((email?.isEmpty)! || (regCode?.isEmpty)!) {
            print("Email or Registraion code cannot be empty!!!")
        } else {
            print(email! + " : " + regCode!)
            LoginUser(email: email!, pass: regCode!)
        }
        
    }
    
    func LoginUser(email:String, pass:String) {
        
        var parameters:[String:String]?
        //parameters = ["user_email":"streloy@gmail.com" as String,"user_pass":"46043017" ]
        parameters = ["user_email":email as String,"user_pass":pass ]
        Alamofire.request(login, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            if let result = response.value as? [Dictionary<String, AnyObject>] {
                if let code = result[0]["code"] as? String {
                    if code == "failed" {
                        /*if let message = result[0]["message"] as? String {
                         print(message)
                         let alert = UIAlertController(title: code, message: message, preferredStyle: UIAlertControllerStyle.alert)
                         alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                         self.present(alert, animated: true, completion: nil)
                         */
                        if let message = result[0]["message"] as? String {
                            print(message)
                        }
                        
                    } else if (code == "success") {
                        
                        if let user = result[0]["user"] as? [Dictionary<String, AnyObject>] {
                            let id = user[0]["id"] as? String
                            let user_fullname = user[0]["user_fullname"] as? String
                            let user_email = user[0]["user_email"] as? String
                            let user_mobile = user[0]["user_mobile"] as? String
                            let user_pass = user[0]["user_pass"] as? String
                            let user_age = user[0]["user_age"] as? String
                            let user_photo = user[0]["user_photo"] as? String
                            let user_address = user[0]["user_address"] as? String
                            let user_status = user[0]["user_status"] as? String
                            
                            print(id!)
                            self.preferences.set(id!, forKey: KEY_SAVE_ID)
                            self.preferences.set(user_fullname!, forKey: KEY_SAVE_FULLNAME)
                            self.preferences.set(user_email!, forKey: KEY_SAVE_EMAIL)
                            self.preferences.set(user_mobile, forKey: KEY_SAVE_MOBILE)
                            self.preferences.set(user_pass!, forKey: KEY_SAVE_PASS)
                            self.preferences.set(user_age!, forKey: KEY_SAVE_AGE)
                            self.preferences.set(user_photo!, forKey: KEY_SAVE_PHOTO)
                            self.preferences.set(user_address!, forKey: KEY_SAVE_ADDRESS)
                            self.preferences.set(user_status!, forKey: KEY_SAVE_STATUS)
                            self.preferences.synchronize()
                        }
                        
                        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewControler = storyboard.instantiateViewController(withIdentifier: "storyboardNavControl") as? UINavigationController
                        self.present(newViewControler!, animated: true, completion: nil)
                        
                    }
                }
            }
        }
        
    }
    

}

