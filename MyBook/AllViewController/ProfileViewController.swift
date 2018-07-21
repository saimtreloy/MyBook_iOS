import UIKit
import Alamofire
import AlamofireImage

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var lblFullname: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var lblStudentID: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    
    let preferences = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.lblFullname.text = self.preferences.string(forKey: KEY_SAVE_FULLNAME)
            self.lblEmail.text = self.preferences.string(forKey: KEY_SAVE_EMAIL)
            self.lblMobile.text = self.preferences.string(forKey: KEY_SAVE_MOBILE)
            self.lblStudentID.text = self.preferences.string(forKey: KEY_SAVE_AGE)
            self.lblAddress.text = self.preferences.string(forKey: KEY_SAVE_ADDRESS)
            print(self.preferences.string(forKey: KEY_SAVE_PHOTO)!)
            Alamofire.request(self.preferences.string(forKey: KEY_SAVE_PHOTO)!).responseImage { response in
                if let image = response.result.value {
                    self.imgProfile.image = image
                }
                
            }
        }

    }

    

}
