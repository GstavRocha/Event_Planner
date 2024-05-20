import React, { useState, useEffect} from 'react';
import '../../style.css';
import fetchGets from '../../Api/UtilRequest';
import todosEventos from '../../Api/Rotas/RotasEventos';

function ListarEventos({ eventos}) {
 
    const reservarEvento = (idEvento) => {

        console.log(`Evento ${idEvento} reservado com Sucesso`);
    }

    return ( 
        <div className=" mt-28 flex justify-center items-center h-auto">
            <div className="w-full max-w-3xl">
                <h2 className="text-2xl font-bold mb-4 text-center">Lista de Eventos</h2>
                <ul>
                {eventos.map(evento => (
                    <li key={evento.idEvento} className="bg-white shadow-2xl shadow-gray-800 rounded-xl p-4 mb-8">
                        <div>
                            <p className="text-lg font-bold mb-2 uppercase">{evento.nomeEvento}</p>
                            <p><strong>Descrição:</strong> {evento.descricaoEvento} </p>
                            <p><strong>Local: </strong> {evento.endereco}</p>
                            <p><strong>Hora:</strong> {evento.hora} </p>
                            {/* <p><strong>Valor:</strong> R$ {evento.ingresso}</p> */}
                        </div>
                        <div className="flex justify-end space-x-4 mt-4">
                            <button className="transition ease-in-out delay-150 hover:-translate-y-1 hover:scale-105 bg-pine-green hover:bg-oxford-blue text-white font-bold py-2 px-4 rounded mt-2 " onClick={() => reservarEvento(evento.idEvento)}>Ver descrição</button>
                            <button className= "transition ease-in-out delay-150 hover:-translate-y-1 hover:scale-105  hover:bg-oxford-blue duration-300 ... bg-roxo text-white font-bold py-2 px-4 rounded mt-2 " onClick={() => reservarEvento(evento.idEvento)}>Reservar</button>
                        </div>
                    </li>
                ))}
                </ul>
            </div>
        </div>
    );
};


export default ListarEventos;