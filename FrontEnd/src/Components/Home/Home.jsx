import React, { useState, useEffect } from 'react';
import NavBar from '../NavBar';
import ListarEventos from '../Eventos/ListarEventos';
import Footer from '../Footer';
import Paginacao from '../Eventos/Paginacao';
import fetchGets from '../../Api/UtilRequest';  // Helper para requisições
import todosEventos from '../../Api/Rotas/RotasEventos';  // Endpoint da API

function Home() {

    /* lista completa de eventos */
    const [eventos, setEventos] = useState([]);
    
    /* eventos que devem ser exibidos. */
    const [eventosExibidos, setEventosExibidos] = useState([]);


    const filtraBusca = (nomeEvento) => {
        if (nomeEvento === '') {
            /* Se vazio exibe todos os Eventos */
            setEventosExibidos(eventos);

        /* ao digitar qualquer coisa o bloco é executado */
        } else {

            /* Cria uma nova lista de eventos que correspondem ao texto digitado pelo usuário armazenando em eventosFiltrados */
            const eventosFiltrados = eventos.filter(evento =>
            evento.nomeEvento.toLowerCase().includes(nomeEvento.toLowerCase())
        );
        /* Chama setEventosExibidos recebendo o resultado da lista filtrada para atualizar eventosExibidos */
        setEventosExibidos(eventosFiltrados);
        }
    };

    useEffect(() => {
        const fetchEventos = async () => {
        try {
            await fetchGets(todosEventos, setEventos);
        } catch (error) {
            console.error('Erro ao buscar eventos:', error);
        }
        };

        fetchEventos();
    }, []);

    useEffect(() => {
        setEventosExibidos(eventos);
    }, [eventos]);

    return (
        <>
        <NavBar pesquisa={filtraBusca} />
        <ListarEventos eventos={eventosExibidos} />
        <Paginacao />
        <Footer />
        </>
    );
    }

    export default Home;
