import React from "react";
import NavBar from "../NavBar";
import ListarEventos from "../Eventos/ListarEventos";
import Footer from "../Footer";
import Paginacao from "../Eventos/Paginacao";

function Home() {
    return(
        <>
            <NavBar/>
            <ListarEventos/>
            <Paginacao/>
            <Footer/>
        </>
    );
}

export default Home;