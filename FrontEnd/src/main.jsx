import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App.jsx'
import './index.css'
import Eventos from './components/Eventos/Eventos.jsx'

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <App /> <Eventos/>
  </React.StrictMode>,
)
