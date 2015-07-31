import UIKit

extension UIImageView {
    func cacheImageFromUrl(url: String, missingImage: UIImage) {
        var paths = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true) as [String]
        var cacheDir = paths[0]
        var cacheSubdir = cacheDir.stringByAppendingPathComponent("0CBwQFjAAahUKEwjp5ZaFwPvGAhWkhHIKHdi7Cds")
        let filemgr = NSFileManager.defaultManager()
        let fileExtension = url.pathExtension
        var isDir : ObjCBool = true
        if !filemgr.fileExistsAtPath(cacheSubdir, isDirectory:&isDir) {
            filemgr.createDirectoryAtPath(cacheSubdir, withIntermediateDirectories: true, attributes: nil, error: nil)
        }
        let url2 = NSURL(string: url)
        var image : UIImage
        if let data = NSData(contentsOfURL: url2!) {
            image = UIImage(data: data)!
        } else {
            image = missingImage
        }
        var fileName = url.md5() as String
        if fileExtension.utf16Count > 0 {
            fileName += "." + fileExtension
        }
        let destinationPath = cacheSubdir.stringByAppendingPathComponent(fileName)
        if !NSFileManager().fileExistsAtPath(destinationPath) {
            switch fileExtension
            {
                case "jpg":
                    UIImageJPEGRepresentation(image, 1.0).writeToFile(destinationPath, atomically: true)
                case "png":
                    UIImagePNGRepresentation(image).writeToFile(destinationPath, atomically: true)
                default:
                    UIImageJPEGRepresentation(image, 1.0).writeToFile(destinationPath, atomically: true)
            }
            
        }
        self.image = UIImage(contentsOfFile: destinationPath)
    }

}

