import "phoenix_html"
import Elm from "./elm"
import { register } from "./localStorage"

const elmDiv = document.getElementById("elm-main")
const elmApp = Elm.Main.embed(elmDiv)
console.info(elmApp.ports)
register(elmApp.ports, console.log)
