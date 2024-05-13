import { useState } from 'react'

function NavBar() {

  return (
    
    <nav className="bg-gray-800 py-3 px-24 fixed w-full top-0 left-0">
      <div className="container mx-auto flex justify-between items-center ">


        <a href="#" className="text-white text-3xl font-bold">Event Planner</a>

        
        <div className="relative flex items-center">
          <input type="text" class="bg-gray-700 text-white py-1 px-3 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Buscar Evento..." />
          <img src="https://icongr.am/octicons/search.svg?size=16&color=fffafa" alt="Ícone de busca" className="absolute right-3 h-6 w-6" />
        </div>
        
        <div className='flex '>
          <ul className="flex space-x-6">
            <li className="nav-item">
              <button className="absolute inset-y-3 right-4 px-4 py-1 bg-roxo  hover:bg-oxford-blue text-white rounded-md">Login</button>
            </li>
          </ul>
        </div>
        

      </div>
    </nav>
  );


}

export default NavBar;
