import React from "react";
import {BrowserRouter, Routes, Route} from "react-router-dom";
import { useState } from "react";
import Home from "./Components/Home/Home";
import NavBar from "./Components/NavBar";
import ListarEventos from "./Components/Eventos/ListarEventos";
import Footer from "./Components/Footer";
import ListarUsuarios from "./Components/Usuarios/ListarUsuarios"

function App() {
    
    return (
        <>
        <BrowserRouter>    
            <Routes>
                <Route Component={Home} path="/" exact />
                  
            </Routes>
        </BrowserRouter>
            {/* <NavBar/>
            <ListarEventos/>
            <ListarUsuarios/>
            <Footer/> */}
        </>);}

export default App;