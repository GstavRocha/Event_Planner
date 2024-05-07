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
        <div class=" mt-28 flex justify-center items-center h-auto">
            <div class="w-full max-w-3xl">
                <h2 class="text-2xl font-bold mb-4 text-center">Lista de Eventos</h2>
                <ul>
                {evento.map(evento => (
                    <li key={evento.idEvento} class="bg-white shadow-2xl shadow-gray-800 rounded-xl p-4 mb-8">
                        <div>
                            <p class="text-lg font-bold mb-2 uppercase">{evento.nomeEvento}</p>
                            <p><strong>Descrição:</strong> {evento.descricaoEvento} </p>
                            <p><strong>Local: </strong> {evento.endereco}</p>
                            <p><strong>Hora:</strong> {evento.hora} </p>
                        </div>
                        <div class="flex justify-end">
                            <button class="bg-pine-green hover:bg-oxford-blue text-white font-bold py-2 px-4 rounded mt-2 " onClick={() => reservarEvento(evento.idEvento)}>Ver descrição</button>
                        </div>
                    </li>
                ))}
                </ul>
            </div>
        </div>
    );
};


export default ListarEventos;