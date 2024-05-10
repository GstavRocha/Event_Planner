
//Url Base do Backend
const urlBase = 'http://localhost:3000/';

//função Fetch recebendo o parametro Link e o setState.
const fetchGets = async (link, setState) => {
    try {
        const resposta = await fetch(urlBase+link);
        const jsonDados = await resposta.json();
        setState(jsonDados);  
         
    } catch (error) {
        console.log('Erro ao buscar dados', error);  
    }
};

export default fetchGets;