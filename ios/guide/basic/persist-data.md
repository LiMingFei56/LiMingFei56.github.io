---
layout: page
permalink: /ios/guide/basic/persistdata
---

Persist Data

ios序列化对象有多种解决方案，这里使用NSCoding方法，NSCoding是一个轻量级的方法存储
对象和结构到硬盘，在之后的时间读取。

### 对象的处理
#### 需要实现NSObject, NSCoding

	class Meal: NSObject, NSCoding {

#### 需要实现encode(with aCoder: NSCoder)方法

	func encode(with aCoder: NSCoder) {
	    aCoder.encode(name, forKey: PropertyKey.name)
	    aCoder.encode(photo, forKey: PropertyKey.photo)
	    aCoder.encode(rating, forKey: PropertyKey.rating)
	}
encode需要传递key值。一般使用静态常量而不是字符串字面，这可以解决很多麻烦。

	struct PropertyKey {
	    static let name = "name"
	    static let photo = "photo"
	    static let rating = "rating"
	}

#### 需要实现init?(coder aDecoder: NSCoder)构造方法

	required convenience init?(coder aDecoder: NSCoder) {
    
	    // The name is required. If we cannot decode a name string, the initializer should fail.
	    guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
	        os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
	        return nil
	    }
	    
	    // Because photo is an optional property of Meal, just use conditional cast.
	    let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
	    
	    let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
	    
	    // Must call designated initializer.
	    self.init(name: name, photo: photo, rating: rating)
	    
	}

### 存储目录
对象序列化到硬盘，需要目录来存储文件。使用File Manager的urls方法来查找应用的documents目录
，这个目录是应用保存用户数据的目录。

	static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!

这个方法返回一个URL数组，first返回这个数组第一个元素。在documents目录下创建"meals"
目录并返回url。

	static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")

### 存储对象

	let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path)

### 读取对象

	 NSKeyedUnarchiver.unarchiveObject(withFile: Meal.ArchiveURL.path) as? [Meal]
