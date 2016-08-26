import Vapor
import VaporMustache
import HTTP


let drop = Droplet()

// MARK: Sockets

var pipes:[WebSocket] = []

drop.socket("test") { req, ws in
    
   pipes.append(ws)
    
    ws.onText = { ws, text in
        
        for pipe in pipes {
            
            try pipe.send(text)
        }
    }
    
    try ws.send("Hello")
    
    
    ws.onClose = { ws, _, _, _ in
        
    }
}

drop.serve()

