// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// Bring in Phoenix channels client library:
import {Socket} from "phoenix"
// And connect to the path in "lib/auction_web/endpoint.ex". We pass the
// token for authentication. Read below how it should be used.
let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()
let match = document.location.pathname.match(/\/items\/(\d+)$/)

if (match) {
	let itemId = match[1]
	let channel = socket.channel(`item:${itemId}`, {})
	
	channel.on("new_bid", data => {
		console.log("new_bid message received", data)
	})

	channel.join()
	  .receive("ok", resp => { console.log("Joined successfully", resp) })
	  .receive("error", resp => { console.log("Unable to join", resp) })
}


export default socket
