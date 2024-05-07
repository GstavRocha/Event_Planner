import { useState } from "react";
import NavBar from "./Components/NavBar";
import ListarEventos from "./Components/Eventos/ListarEventos";
import Footer from "./Components/Footer";

function App() {
    return (
        <>
            <NavBar/>
            <ListarEventos/>
            <Footer/>
        </>
    );
}

export default App;