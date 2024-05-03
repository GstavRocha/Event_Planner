import { useState } from "react";
import NavBar from "./Components/NavBar";
import ListarEventos from "./Components/Eventos/ListarEventos";

function App() {
    return (
        <>
            <NavBar/>
            <ListarEventos/>
        </>
    );
}

export default App;