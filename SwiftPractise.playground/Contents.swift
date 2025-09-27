import UIKit

var productName = "TV"
var age = 22
var height = 1.63
var control = false

print(productName)
print("\(age) years old")

//var daha sonra değerini değiştirebilirsin

var x = 100
print(x)
x = 200
print(x)

//Constant - Sabitler
//Kotlin val

let y = 100
//let değişmez ve y = 50 dersem hata olur

//Optional
//Nullable - Null Safety
var str = "Hello"

//null = nil
var message:String? //var message:String? = nil

message = "Hello World"

if message != nil {
    print(message!) //unwrapping işlemi; optionallıktan kurtardım ve sonucu aldım*
} else{
    print( "Message is nil")
}

//Optional Binding
//let temp = message //burada message nil ise ifade total olarak false olur

if let temp = message {
    print(temp) //otomatik unwrapping; ünlem koymamıza gerek kalmadı
}else{
    print( "Message is nil")
}

if var temp = message {
    print(temp) //otomatik unwrapping; ünlem koymamıza gerek kalmadı
    temp = "Updated message"
    print (temp)
}else{
    print( "Message is nil")
}

//Object Oriented - Nesne Tabanlı
//Class - Object
class Product {
    var id:Int?
    var name:String?
    var price:Double?
    
    //self = bulunduğumuz sınıf - Kotlin (this)
    
    init(id:Int, name:String, price:Double){
        self.id = id //Shadowing*
        self.name = name
        self.price = price
        print("init worked...")
        // bu sınıftan nesne oluşturduğumuzda çalışır
    }
}

var product1 = Product(id: 1, name: "TV", price: 39000.0)
print(product1.id!)
print(product1.name!)
print(product1.price!)

var product2 = Product(id: 2, name: "Laptop", price: 7800.0)
print(product2.id!)
print(product2.name!)
print(product2.price!)




