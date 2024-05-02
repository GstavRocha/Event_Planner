import RotasEventos from './Rotas/RotasEventos.js';

const fetchEvento = async (link) => {
    try {
        const resposta = await fetch(link);
        const jsonDados = await resposta.json();
        //console.log(jsonDados);
        setEvento(jsonDados);  
         
    } catch (error) {
        console.log('Erro ao buscar dados', error);  
    }
};