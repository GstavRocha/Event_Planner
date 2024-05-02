import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App.jsx'
import './index.css'
import ListarEventos from './Components/Eventos/ListarEventos.jsx'

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <App /> <ListarEventos/>
  </React.StrictMode>,
)
