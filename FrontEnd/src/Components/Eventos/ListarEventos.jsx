import React, { useState, useEffect} from 'react';
import '../../index.css';

function ListarEventos() {
    const [evento, setEvento] = useState([]);

    useEffect( ()=> {
        fetchEvento();
    }, []);
 
    const fetchEvento = async () => {
        try {
            const resposta = await fetch('http://localhost:3000/controllers/eventos');
            const jsonDados = await resposta.json();
            setEvento(jsonDados);  
             
        } catch (error) {
            console.log('Erro ao buscar dados', error);  
        }
    };

    const reservarEvento = (idEvento) => {

        console.log(`Evento ${idEvento} reservado com Sucesso`);
    }

    return ( 
        <div>
            <h2>Lista de Eventos</h2>
            <ul>
                {evento.map(evento => (
                    <li key={evento.idEvento}>
                        <h3>{evento.nomeEvento}</h3>
                        <p><strong>Descrição:</strong> {evento.descricaoEvento} </p>
                        <p><strong>Local: </strong> {evento.endereco}</p>
                        <p><strong>Hora:</strong> {evento.hora} </p>
                        <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded" onClick={ () => reservarEvento(evento.idEvento)} >Reservar</button>
                    </li>
                    
                ))}
            </ul>
        </div>
    );
};

export default ListarEventos;