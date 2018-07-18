
import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController {
    
    let URL_GET_DATA = "https://simplifiedcoding.net/demos/marvel/"
    let URL_IMAGE = "https://www.simplifiedcoding.net/demos/marvel/captainamerica.jpg"
    let login = "http://www.mamunscare.org/BOOKAPP_API/login.php"

    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputRegistrationCode: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var parameters:[String:String]?
        parameters = ["user_email":"streloy@gmail.com" as String,"user_pass":"46043017" ]
        Alamofire.request(login, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            print(response)
            if let result = response.value as? [Dictionary<String, AnyObject>] {
                if let code = result[0]["code"] as? String {
                    print(code)
                    if code == "failed" {
                        /*if let message = result[0]["message"] as? String {
                            print(message)
                            let alert = UIAlertController(title: code, message: message, preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            */
                        
                    } else if (code == "success") {
                        
                    }
                }
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
        }
        
        //let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //let newViewControler = storyboard.instantiateViewController(withIdentifier: "storyboardHome") as? HomeViewController
        //self.present(newViewControler!, animated: true, completion: nil)
        
        //storyboardNavControl
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewControler = storyboard.instantiateViewController(withIdentifier: "storyboardNavControl") as? UINavigationController
        self.present(newViewControler!, animated: true, completion: nil)
    }
    

}

