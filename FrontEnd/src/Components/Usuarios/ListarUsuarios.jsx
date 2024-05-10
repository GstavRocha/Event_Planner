import { useEffect, useState } from "react";
import fetchGets from "../../Api/UtilRequest";
import todosUsers from "../../Api/Rotas/RotasUsuarios";

function ListarUsuarios() {
    
    const [usuario, setUsuario] = useState([]);
    
    useEffect ( ()=> {
        fetchGets(todosUsers,setUsuario);   
    },[]);
    
    return(
        <>
            <div className=" mt-28 flex justify-center items-center h-auto">
                <div className="w-full max-w-3xl">
                    <h2 className="text-2xl font-bold mb-4 text-center">Usuarios Cadastrados</h2>
                    <ul>
                        {
                            usuario.map(usuario => (
                                <li key={usuario.idUsuario}>
                                    <div>
                                        <p><strong>Nome</strong> {usuario.nome}</p>
                                        <p><strong>Login</strong> {usuario.login} </p>
                                        <p><strong>Email</strong> {usuario.email} </p>
                                    </div>    
                                </li>
                        ))}
                    </ul>
                </div>
            </div>
        </>
    );
}

export default ListarUsuarios;