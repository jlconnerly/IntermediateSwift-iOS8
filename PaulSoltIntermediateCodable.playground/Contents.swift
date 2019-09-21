import UIKit

// https://swapi.co/api/people/1/
// Have api data on the side to see how JSON is layed out

////////// EXAMPLE ONE - PARSING ONLY FIRST 'LEVEL' JSON /////////////////

/*
struct Person: Codable {
    let name: String
    let height: Int
    let hairColor: String
    
    //can name CodingKeys something else if you've overriden init()
//    enum CodingKeys: String, CodingKey{
    enum PersonKeys: String, CodingKey {
        case name
        case height
        case hairColor = "hair_color"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PersonKeys.self)
        
        //setting coding keys manually
        name = try container.decode(String.self, forKey: .name)
        
        /*
        This is cool because in the API height is a string in the JSON but writing
        our own init, we can parse the JSON properly and also keep our height in
        the struct as an Int
         */
        let heightString = try container.decode(String.self, forKey: .height)
        height = Int(heightString) ?? 0
        /*
         so NOW we can keep our height the proper type that we want to use even though
         it is NOT they type we want in JSON
        */
        hairColor = try container.decode(String.self, forKey: .hairColor)
    }
 */


//////////////////////////////////////////////////////////////////////////////////////
/////////// EXAMPLE 2 ADDING DEEPER LEVEL PARSING /////////////////
//////////  NESTED JSON PARSING. FILMS IN SWAPI API IS NESTED ///////////

/*
struct Person: Codable {
    let name: String
    let height: Int
    let hairColor: String
    
    let films: [URL]
    
    //can name CodingKeys something else if you've overriden init()
    //    enum CodingKeys: String, CodingKey{
    enum PersonKeys: String, CodingKey {
        case name
        case height
        case hairColor = "hair_color"
        case films
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PersonKeys.self)
        
        //setting coding keys manually
        name = try container.decode(String.self, forKey: .name)
        
        /*
         This is cool because in the API height is a string in the JSON but writing
         our own init, we can parse the JSON properly and also keep our height in
         the struct as an Int
         */
        let heightString = try container.decode(String.self, forKey: .height)
        height = Int(heightString) ?? 0
        /*
         so NOW we can keep our height the proper type that we want to use even though
         it is NOT they type we want in JSON
         */
        hairColor = try container.decode(String.self, forKey: .hairColor)
        
        // IMPORTANT: this is refrencing the NESTED container
        var filmsContainer = try container.nestedUnkeyedContainer(forKey: .films)
 
////////////// FIRST APPROACH TO PARSING THE NESTED JSON ////////////////////////
        var filmURLs: [URL] = []
        while filmsContainer.isAtEnd == false {
            let filmString = try filmsContainer.decode(String.self)
            if let url = URL(string: filmString) {
                filmURLs.append(url)
            }
        }
        films = filmURLs
    }
    */

struct Person: Codable {
    let name: String
    let height: Int
    let hairColor: String
    
    let films: [URL]
    
    //can name CodingKeys something else if you've overriden init()
    //    enum CodingKeys: String, CodingKey{
    enum PersonKeys: String, CodingKey {
        case name
        case height
        case hairColor = "hair_color"
        case films
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PersonKeys.self)
        
        //setting coding keys manually
        name = try container.decode(String.self, forKey: .name)
        
        /*
         This is cool because in the API height is a string in the JSON but writing
         our own init, we can parse the JSON properly and also keep our height in
         the struct as an Int
         */
        let heightString = try container.decode(String.self, forKey: .height)
        height = Int(heightString) ?? 0
        /*
         so NOW we can keep our height the proper type that we want to use even though
         it is NOT they type we want in JSON
         */
        hairColor = try container.decode(String.self, forKey: .hairColor)
        
///////////2nd APPROACH TO PARSING THE NESTED JSON//////////////////////////////////
        //let filmStrings = try container.decode([String].self, forKey: .films)
        
        //compactMap returns NON-NIL Values
        //films = filmStrings.compactMap { URL(string: $0) }
        
///////////3rd APPROACH TO PARSING NESTED JSON /////////////////////////////////////////
        films = try container.decode([URL].self, forKey: .films)
        
      
    }
}


let url = URL(string: "https://swapi.co/api/people/1/")!

let data = try! Data(contentsOf: url)

let decoder = JSONDecoder()

let luke = try! decoder.decode(Person.self, from: data)

print(luke)
