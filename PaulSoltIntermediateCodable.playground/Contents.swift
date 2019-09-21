import UIKit

// https://swapi.co/api/people/1/
// Have api data on the side to see how JSON is layed out

struct Person: Codable {
    let name: String
    let height: String
    let hairColor: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case height
        case hairColor = "hair_color"
    }
}

let url = URL(string: "https://swapi.co/api/people/1/")!

let data = try! Data(contentsOf: url)

let decoder = JSONDecoder()

let luke = try! decoder.decode(Person.self, from: data)

print(luke)
