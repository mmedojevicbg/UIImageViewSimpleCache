# UIImageViewSimpleCache
let imageFromWeb = "..."
let noImage = UIImage(named:"no-photo.png")!
imageView.cacheImageFromUrl(imageFromWeb, missingImage: noImage)
