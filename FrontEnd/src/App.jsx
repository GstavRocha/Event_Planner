import { useState } from "react";
import NavBar from "./Components/NavBar";
import ListarEventos from "./Components/Eventos/ListarEventos";
import Footer from "./Components/Footer";
import ListarUsuarios from "./Components/Usuarios/ListarUsuarios"

function App() {
    return (
        <>
            <NavBar/>
            <ListarEventos/>
            {/* <ListarUsuarios/> */}
            <Footer/>
            
        </>
    );
}

export default App;