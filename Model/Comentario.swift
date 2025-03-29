import Foundation
import UIKit

struct Comentario: Identifiable, Codable {
    let id = UUID()
    let autor: String       // Solo un nombre
    let contenido: String
    let fecha: Date
    var imagenData: Data?   // Para persistencia de imagen
    
    var imagen: UIImage? {
        if let imagenData = imagenData {
            return UIImage(data: imagenData)
        }
        return nil
    }
}
