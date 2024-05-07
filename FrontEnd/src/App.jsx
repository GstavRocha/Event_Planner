import { useState } from "react";
import NavBar from "./Components/NavBar";
import ListarEventos from "./Components/Eventos/ListarEventos";
import ListarUsuarios from "./Components/Usuarios/ListarUsuarios";

function App() {
    return (
        <>
            <NavBar/>
            <ListarEventos/>
            {/* <ListarUsuarios/> */}
        </>
    );
}

export default App;