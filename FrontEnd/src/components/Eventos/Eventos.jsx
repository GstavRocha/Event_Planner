import React, { useState, useEffect} from 'react';

function Eventos() {
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
            <h1>Lista de Eventos</h1>
            <ul>
                {evento.map(evento => (
                    <li key={evento.idEvento}>
                        <h2>{evento.nomeEvento}</h2>
                        <p><strong>Descrição:</strong> {evento.descricaoEvento} </p>
                        <p><strong>Local: </strong> {evento.endereco}</p>
                        <p><strong>Hora:</strong> {evento.hora} </p>
                        <button onClick={ () => reservarEvento(evento.idEvento)} >Reservar</button>
                    </li>
                    
                ))}
            </ul>
        </div>
    );
};

export default Eventos;