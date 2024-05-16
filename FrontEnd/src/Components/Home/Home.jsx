import React from "react";
import NavBar from "../NavBar";
import ListarEventos from "../Eventos/ListarEventos";
import Footer from "../Footer";

function Home() {
    return(
        <>
            <NavBar/>
            <ListarEventos/>
            <Footer/>
        </>
    );
}

export default Home;