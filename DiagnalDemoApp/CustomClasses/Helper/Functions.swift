

//

import Foundation
import UIKit
extension UIImageView {
func compressImage() -> UIImage? {
    let newSize = CGSize(width: 1000, height:1000)
    UIGraphicsBeginImageContext(newSize)
    self.draw(CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage
}
  
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
            contentMode = mode
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async() {
                    self.image = image
                }
                }.resume()
        }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .center) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
            guard let url = URL(string: link) else { return }
            downloaded(from: url, contentMode: mode)
        }
    
}
extension UIView {
    func fadeTo(_ alpha: CGFloat, duration: TimeInterval? = 0.3) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: duration != nil ? duration! : 0.3) {
                self.alpha = 0.8
            }
        }
    }
    func fadeOut(_ alpha: CGFloat, duration: TimeInterval? = 0.3) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: duration != nil ? duration! : 0.3) {
                self.alpha = 0
            }
        }
    }
    func fadeIn(_ duration: TimeInterval? = 0.3) {
        fadeTo(1.0, duration: duration)
    }
    func fadeOut(_ duration: TimeInterval? = 0.3) {
        fadeTo(0.0, duration: duration)
    }
}


extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}




func isNsnullOrNil(object : AnyObject?) -> Bool{
    if (object is NSNull) || (object == nil)
    {
        return true
    }
    else
    {
        return false
    }
}

func UIColorRGB(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1.0)
}
func UIColorRGBA(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
    return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
}

func alert(withmessage message: String,withpresentviewcontroller presentviewcontroller: UIViewController,withtype type:String)
{
    
    let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
        UIAlertAction in
        NSLog("OK Pressed")
        
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
        UIAlertAction in
        NSLog("Cancel Pressed")
    }
    
    // Add the actions
    if type == "Single"{
        alertController.addAction(okAction)
    } else {
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
    }
    
    // Present the controller
    presentviewcontroller.present(alertController, animated: true, completion: nil)
    
}
//MARK: VALIDATION
func validateEmail(enteredEmail:String) -> Bool {
    
    let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
    return emailPredicate.evaluate(with: enteredEmail)
    
}
// MARK: - Storyboard
func getStoryboard(storyboardName: String) -> UIStoryboard {
    return UIStoryboard(name: "\(storyboardName)", bundle: nil)
}

func instantiateViewController(storyboardID: String) -> UIViewController {
    let viewController = getStoryboard(storyboardName: "Main").instantiateViewController(withIdentifier: storyboardID)
    return viewController
}

func pushViewController(withfromviewController fromviewController : UIViewController, withtoViewController toviewController: String){
    print("Push")
    let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(toviewController)")
    fromviewController.navigationController?.pushViewController(nextVC, animated: true)
    
    
}


func UserdefaultsValueString(withvalue value:String,withkey key:String){
    UserDefaults.standard.set(value, forKey: key)
}
extension String{
    
    public var isBlank: Bool {
        let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
        return trimmed.isEmpty
    }
    func stringtoDate(withselectedDate selectedDate: String, withformat format: String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let newSelecteddate = dateFormatter.date(from: selectedDate)
        return newSelecteddate!
    }
    
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    
}
extension Date {
    
    func dateToStringWithCustomFormat (_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        return dateFormatter.string(from: self)
    }
    
    
}

extension Array {
    func contains<T>(obj: T) -> Bool where T : Equatable {
        return self.filter({$0 as? T == obj}).count > 0
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension Collection where Indices.Iterator.Element == Index {
    subscript (exist index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

func topViewController()-> UIViewController{
    var topViewController:UIViewController = UIApplication.shared.keyWindow!.rootViewController!
    
    while ((topViewController.presentedViewController) != nil) {
        topViewController = topViewController.presentedViewController!;
    }
    
    return topViewController
}

func showShareActivity(msg:String?, image:UIImage?, url:String?, sourceRect:CGRect?){
    var objectsToShare = [AnyObject]()
    
    if let url = url {
        objectsToShare = [url as AnyObject]
    }
    
    if let image = image {
        objectsToShare = [image as AnyObject]
    }
    
    if let msg = msg {
        objectsToShare = [msg as AnyObject]
    }
    
    let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
    activityVC.modalPresentationStyle = .popover
    activityVC.popoverPresentationController?.sourceView = topViewController().view
    if let sourceRect = sourceRect {
        activityVC.popoverPresentationController?.sourceRect = sourceRect
    }
    
    topViewController().present(activityVC, animated: true, completion: nil)
}

func GetDateFromString(DateStr: String)-> Date
{
    let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
    let DateArray = DateStr.components(separatedBy: "/")
    let components = NSDateComponents()
    components.year = Int(DateArray[2])!
    components.month = Int(DateArray[1])!
    components.day = Int(DateArray[0])!
    components.timeZone = TimeZone(abbreviation: "GMT+0:00")
    let date = calendar?.date(from: components as DateComponents)
    
    return date!
}

func StringTOdate(withdateStr dateStr:String) -> String?{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //Your date format
    
    print(dateStr)
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
    //according to date format your date string
    guard let date = dateFormatter.date(from: dateStr) else {
        fatalError()
    }
    print("string to date")
    print(date)
    let finalTime = DateToString(withDATE: date as NSDate)
    return finalTime
}

func CurrentDateToString() -> String?{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //Your date format
    //according to date format your date string
    let datestr = dateFormatter.string(from: Date())
    print("-------------------currentdatetostring-----------------------------------")
    print(datestr)
    
    return datestr
}

func DateToString(withDATE DATE: NSDate?) -> String {
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
    formatter.dateFormat = "hh:mm a"
    formatter.amSymbol = "AM"
    formatter.pmSymbol = "PM"
    
    let dateString = formatter.string(from: DATE as! Date)
    print("******************datetostring****************************")
    print(dateString)   // "4:44 PM on June 23, 2016\n"
    return dateString
}

//MARK: protocol created
protocol AddressProtocol : class {
    func getaddress(withstreet street:String, withapartment apartment:String,withcountry country:String,withstate state:String, withcity city:String,withzip zip:String,withphone phone:String,withlocation location:String)
    
}
extension UITextField{
   @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}
