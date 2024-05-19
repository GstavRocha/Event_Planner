import React from "react";
import {BrowserRouter, Routes, Route} from "react-router-dom";
import { useState } from "react";
import Home from "./Components/Home/Home";
import NavBar from "./Components/NavBar";
import ListarEventos from "./Components/Eventos/ListarEventos";
import Footer from "./Components/Footer";
import ListarUsuarios from "./Components/Usuarios/ListarUsuarios"
import Login from "./Components/Login/Login";

function App() {
    
    return (
        <>
        <BrowserRouter>    
            <Routes>
                <Route Component={Home} path="/" exact />
                <Route Component={Login} path="/login" />
                
            </Routes>
        </BrowserRouter>
            {/* <NavBar/>
            <ListarEventos/>
            <ListarUsuarios/>
            <Footer/> */}
        </>);}

export default App;